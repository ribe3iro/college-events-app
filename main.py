import oracledb
import os
from dotenv import load_dotenv

def main():
  conn = conectar_bd()
  if not conn:
    quit()

  print('\n\n===== Bem-vindo ao Sistema de Gerenciamento de Eventos da Atlética =====')
  while True:
    op = escolher_opcao()

    if op == 1:
      sql_str = '''
                SELECT e.nome, e.edicao, SUM(CASE WHEN tipo = 'inteira' THEN de.preco_ingresso WHEN tipo = 'meia' THEN de.preco_ingresso/2 ELSE 0 END) AS valor_arrecadado_ingressos
                FROM evento e LEFT JOIN dia_evento de ON e.nome = de.nome_e AND e.edicao = de.edicao_e
                              LEFT JOIN ingresso i ON i.id_de = de.id AND i.tipo != 'franca'
                GROUP BY e.nome, e.edicao
                '''
      result = consultar_bd(conn, sql_str)
      if result['success']:
        exibir_linhas(result['selected'])
      else:
        print(result['message'])
    elif op == 2:
      nome = input('Digite o nome do evento: ')
      edicao = input('Digite a edicao do evento: ')
      result = inserir_linha(conn, 'evento', {'nome': nome, 'edicao': edicao})
      if result['success']:
        print('Inserção realizada com sucesso!')
      else:
        print(result['message'])
    elif op == 0:
      break

  # encerrando conexão com o SGBD
  conn.close()
  print('Conexão encerrada')

def conectar_bd():
  # realiza a conexão com o banco de dados

  # trazendo usuário e senha de um arquivo .env
  load_dotenv(dotenv_path="./.env")
  BD_USER = os.getenv('BD_USER')
  BD_PASSWD = os.getenv('BD_PASSWD')
  BD_HOST = os.getenv('BD_HOST')
  BD_PORT = os.getenv('BD_PORT')
  BD_SERVICE = os.getenv('BD_SERVICE')

  try:
    # estabelecendo conexão com o SGBD
    print('Conexão com o SGBD está sendo estabelecida. Por favor, aguarde...')
    conn = oracledb.connect(user=BD_USER, password=BD_PASSWD,
                            host=BD_HOST, port=BD_PORT, service_name=BD_SERVICE)
    print('Conexão estabelecida com sucesso!')
    return conn
  except oracledb.Error as e:
    error_obj, = e.args
    print('Erro ao efetuar conexão!\n', error_obj.message)
    return False

def escolher_opcao():
  # exibe as opções de uso para o usuário
  # e retorna a opção escolhida
  op = -1
  while True:
    print('\nEscolha uma das opções abaixo:')
    print('1) - Consultar a arrecadação de cada evento')
    print('2) - Inserir novo evento')
    print('0) - Sair\n')
    try:
      op = int(input('Digite sua opção: '))
      if op < 0 or op > 2:
        raise Exception()
      return op
    except:
      print('\nValor inválido! Redigite')

def inserir_linha(conn, tabela, valores_dict):
  # dada a variável de conexão,
  # o nome de uma tabela e os valores a serem
  # inseridos, realiza uma inserção no banco
  colunas = ''
  valores = ''
  for key, valor in valores_dict.items():
    colunas += limpar_string(key) + ','
    valores += "'" + limpar_string(valor) + "',"
  colunas = colunas[::-1].replace(",", "", 1)[::-1]
  valores = valores[::-1].replace(",", "", 1)[::-1]
  
  tabela = limpar_string(tabela)

  sql_str = "INSERT INTO {tabela} ({colunas}) VALUES ({valores})".format(tabela=tabela, colunas=colunas, valores=valores)

  ret_val = {}
  try:
    conn.begin()
    with conn.cursor() as cursor:
      cursor.execute(sql_str)
    conn.commit()
    ret_val['success'] = True
  except oracledb.Error as e:
    error_obj, = e.args
    conn.rollback()
    ret_val['success'] = False
    ret_val['message'] = 'Erro durante a inserção!\n', error_obj.message

  return ret_val

def consultar_bd(conn, sql_str):
  # dada a variável de conexão e uma query sql,
  # retorna as linhas selecionadas
  ret_val = {}
  try:
    with conn.cursor() as cursor:
      cursor.execute(sql_str)
      columns = [col[0] for col in cursor.description]
      rows = cursor.fetchall()
    ret_val['success'] = True
    ret_val['selected'] = (columns, rows)
  except oracledb.Error as e:
    error_obj, = e.args
    conn.rollback()
    ret_val['success'] = False
    ret_val['message'] = 'Erro durante a consulta!\n', error_obj.message
  return ret_val

def exibir_linhas(selecionados):
  # dada uma tupla com o nome das colunas e 
  # as linhas selecionadas, imprime os resultados na tela
  colunas, linhas = selecionados
  col_len = 20
  for coluna in colunas:
    print(formatar_valor_em_coluna(str(coluna), '^', col_len), end = ' ')
  print('')
  for linha in linhas:
    for atributo in linha:
      print(formatar_valor_em_coluna(str(atributo), '<', col_len), end = ' ')
    print('')

def formatar_valor_em_coluna(text, align, length):
  # formata o valor recebido para exibição em tabela
  if len(text) <= 20:
    return ('|{:' + align + str(length) + '}|').format(text)
  else:
    return '|{}...|'.format(text[:length-3])

def limpar_string(texto):
  # remove alguns caracteres problemáticos para SQL Injection
  return texto.replace("'", "").replace(";", "")

main()
