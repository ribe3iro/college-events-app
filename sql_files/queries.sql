-- 1
SELECT e.nome, e.edicao, count(i.id_de) AS qtde_ingressos_vendidos
FROM evento e LEFT JOIN dia_evento de ON e.nome = de.nome_e AND e.edicao = de.edicao_e
              LEFT JOIN ingresso i ON i.id_de = de.id
GROUP BY e.nome, e.edicao 
ORDER BY qtde_ingressos_vendidos DESC;


-- 2
SELECT a.ra, a.nome, a.vinculo, count(va.id_v) AS qtde_viagens
    FROM viagem v JOIN viagem_aluno va ON va.id_v = v.id AND EXTRACT(YEAR FROM v.data_hora_partida) = 2022
                  RIGHT JOIN aluno a ON a.ra = va.ra 
GROUP BY a.ra, a.nome, a.vinculo
ORDER BY qtde_viagens DESC;


-- 3
SELECT e.nome, e.edicao, SUM(CASE WHEN tipo = 'inteira' THEN de.preco_ingresso WHEN tipo = 'meia' THEN de.preco_ingresso/2 ELSE 0 END) AS valor_arrecadado_ingressos
    FROM evento e LEFT JOIN dia_evento de ON e.nome = de.nome_e AND e.edicao = de.edicao_e
                  LEFT JOIN ingresso i ON i.id_de = de.id AND i.tipo != 'franca'
GROUP BY e.nome, e.edicao;


-- 4
SELECT f.cpf, f.nome, SUM((t.horario_saida - t.horario_entrada)*24) AS horas_trabalhadas, SUM(t.pagamento) AS pagamento_total
    FROM funcionario f JOIN turno t ON t.cpf_f = f.cpf
GROUP BY f.cpf, f.nome;


-- 5
SELECT a.ra, a.nome
    FROM aluno a WHERE NOT EXISTS ((SELECT nome, edicao FROM evento) 
    MINUS (SELECT nome_e, edicao_e FROM evento_membro WHERE ra = a.ra));
