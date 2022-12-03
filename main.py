import oracledb
import os
from dotenv import load_dotenv

def main():
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
    print('Conexão estabelecida com sucesso!\n\n')
  except oracledb.Error as e:
        error_obj, = e.args
        print('Erro ao efetuar conexão!\n', error_obj.message)
        quit()
        
  print('===== Bem-vindo ao Sistema de Gerenciamento de Eventos da Atlética =====\n')
  while True:
    print('Escolha uma das opções abaixo:')
    print('1) - Consultar a arrecadação de cada evento')
    print('2) - Inserir novo evento')
    print('0) - Sair\n')
    op = input('Digite sua opção: ')

    if op == '1':
      with conn.cursor() as cursor:
        sql_str = '''
                  SELECT e.nome, e.edicao, SUM(CASE WHEN tipo = 'inteira' THEN de.preco_ingresso WHEN tipo = 'meia' THEN de.preco_ingresso/2 ELSE 0 END) AS valor_arrecadado_ingressos
                  FROM evento e LEFT JOIN dia_evento de ON e.nome = de.nome_e AND e.edicao = de.edicao_e
                                LEFT JOIN ingresso i ON i.id_de = de.id AND i.tipo != 'franca'
                  GROUP BY e.nome, e.edicao
                  '''
        cursor.execute(sql_str)
        columns = [col[0] for col in cursor.description]
        rows = cursor.fetchall()
      print(columns)
      for r in rows:
        print(r)
    elif op == '2':
      nome = input('Digite o nome do evento: ')
      edicao = input('Digite a edicao do evento: ')

      nome = nome.replace("'", "").replace(";", "")
      edicao = edicao.replace("'", "").replace(";", "")
      sql_str = "INSERT INTO evento (nome, edicao) VALUES ('{nome}', '{edicao}')".format(nome = nome, edicao = edicao)

      try:
        conn.begin()
        with conn.cursor() as cursor:
          cursor.execute(sql_str)
        conn.commit()
      except oracledb.Error as e:
        error_obj, = e.args
        print('Erro durante a inserção!\n', error_obj.message)
        conn.rollback()
      else:
        print('Inserção realizada com sucesso!')
    elif op == '0':
      break
    else:
      print('Opção inválida!')

  # encerrando conexão com o SGBD
  conn.close()
  print('Conexão encerrada')

main()
