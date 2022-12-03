INSERT INTO evento(nome, edicao) VALUES('tusca', '2022');
INSERT INTO evento(nome, edicao) VALUES('ies', 'halloween');
INSERT INTO evento(nome, edicao) VALUES('festa junina', '2022');

INSERT INTO equipamento(cod_patrimonio, nome, setor, valor_pago) VALUES(123456789, 'raquete', 'esportes', 94.99);
INSERT INTO equipamento(cod_patrimonio, nome, setor, valor_pago) VALUES(111111111, 'tamborim', 'bateria', 58.90);

INSERT INTO equipamento_ev(cod_patrimonio, nome_e, edicao_e) VALUES(123456789, 'tusca', '2022');
INSERT INTO equipamento_ev(cod_patrimonio, nome_e, edicao_e) VALUES(111111111, 'tusca', '2022');

INSERT INTO empresa_p(cnpj, nome_fantasia) VALUES('12312312312300', 'bar da pizza');
INSERT INTO empresa_p(cnpj, nome_fantasia) VALUES('99999999999999', 'twitter');

INSERT INTO patrocinio(nome_e, edicao_e, cnpj_ep, contribuicao) VALUES('tusca', '2022', '99999999999999', 2000.00);
INSERT INTO patrocinio(nome_e, edicao_e, cnpj_ep, contribuicao) VALUES('ies', 'halloween', '12312312312300', 80.00);

INSERT INTO aluno(ra, nome, vinculo) VALUES(12563710, 'hugo ferreira', 'socio');
INSERT INTO aluno(ra, nome, vinculo) VALUES(12345678, 'joao pedro ribeiro', 'socio');
INSERT INTO aluno(ra, nome, vinculo) VALUES(87654321, 'mariana kaori', 'membro');
INSERT INTO aluno(ra, nome, vinculo) VALUES(12563712, 'eduardo miranda', 'membro');
INSERT INTO aluno(ra, nome, vinculo) VALUES(12341234, 'gustavo martins', 'membro');

INSERT INTO viagem(id, destino, data_hora_partida, local_partida, custo) VALUES(1, 'araraquara', TO_DATE('2022/05/03', 'YYYY/MM/DD'), 'sao carlos', 300);
INSERT INTO viagem(id, destino, data_hora_partida, local_partida, custo) VALUES(2, 'sao paulo', TO_DATE('2022/09/15', 'YYYY/MM/DD'), 'sao carlos', 670);
INSERT INTO viagem(id, destino, data_hora_partida, local_partida, custo) VALUES(3, 'sao paulo', TO_DATE('2019/04/03', 'YYYY/MM/DD'), 'sao carlos', 710);

INSERT INTO viagem_aluno(id_v, ra) VALUES(1, 12563710);
INSERT INTO viagem_aluno(id_v, ra) VALUES(1, 12563712);
INSERT INTO viagem_aluno(id_v, ra) VALUES(2, 12563710);
INSERT INTO viagem_aluno(id_v, ra) VALUES(2, 87654321);
INSERT INTO viagem_aluno(id_v, ra) VALUES(2, 12345678);
INSERT INTO viagem_aluno(id_v, ra) VALUES(3, 12563710);

INSERT INTO viagem_evento(nome_e, edicao_e, id_v) VALUES('ies', 'halloween', 1);
INSERT INTO viagem_evento(nome_e, edicao_e, id_v) VALUES('ies', 'halloween', 2);

INSERT INTO membro(ra, cargo) VALUES(87654321, 'presidente');
INSERT INTO membro(ra, cargo) VALUES(12563712, 'assessor');

INSERT INTO socio(ra, data_inicio_plano, data_fim_plano) VALUES(12563710, TO_DATE('2022/05/03', 'yyyy/mm/dd'), TO_DATE('2022/12/03', 'yyyy/mm/dd'));
INSERT INTO socio(ra, data_inicio_plano, data_fim_plano) VALUES(12345678, TO_DATE('2021/04/08', 'yyyy/mm/dd'), TO_DATE('2023/04/07', 'yyyy/mm/dd'));

INSERT INTO evento_membro(nome_e, edicao_e, ra) VALUES('tusca', '2022', 87654321);
INSERT INTO evento_membro(nome_e, edicao_e, ra) VALUES('ies', 'halloween', 87654321);
INSERT INTO evento_membro(nome_e, edicao_e, ra) VALUES('festa junina', '2022', 87654321);

INSERT INTO dia_evento(nome_e, edicao_e, data, preco_ingresso, id) VALUES('tusca', '2022', TO_DATE('2022/11/12', 'yyyy/mm/dd'), 500.00, 1);
INSERT INTO dia_evento(nome_e, edicao_e, data, preco_ingresso, id) VALUES('ies', 'halloween', TO_DATE('2022/10/26', 'yyyy/mm/dd'), 80.00, 2);
INSERT INTO dia_evento(nome_e, edicao_e, data, preco_ingresso, id) VALUES('ies', 'halloween', TO_DATE('2022/10/27', 'yyyy/mm/dd'), 80.00, 3);
INSERT INTO dia_evento(nome_e, edicao_e, data, preco_ingresso, id) VALUES('ies', 'halloween', TO_DATE('2022/10/28', 'yyyy/mm/dd'), 80.00, 4);
INSERT INTO dia_evento(nome_e, edicao_e, data, preco_ingresso, id) VALUES('ies', 'halloween', TO_DATE('2022/10/29', 'yyyy/mm/dd'), 80.00, 5);
INSERT INTO dia_evento(nome_e, edicao_e, data, preco_ingresso, id) VALUES('ies', 'halloween', TO_DATE('2022/10/30', 'yyyy/mm/dd'), 80.00, 6);
INSERT INTO dia_evento(nome_e, edicao_e, data, preco_ingresso, id) VALUES('festa junina', '2022', TO_DATE('2022/06/12', 'yyyy/mm/dd'), 30.00, 7);

INSERT INTO artista(cnpj, email, nome_artistico) VALUES('36862586000140', 'equipeanitta@gmail.com', 'anitta');
INSERT INTO artista(cnpj, email, nome_artistico) VALUES('86739952000147', 'ludmilla@gmail.com', 'ludmilla');

INSERT INTO apresentacao (id_de, cnpj_a, horario, cache) VALUES (1, '36862586000140', TO_DATE('18:00', 'HH24:MI'), 500000.00);
INSERT INTO apresentacao (id_de, cnpj_a, horario, cache) VALUES (2, '86739952000147', TO_DATE('19:00', 'HH24:MI'), 400000.00);

INSERT INTO ingresso (nro_serie, tipo, id_de) VALUES (1, 'inteira', 1);
INSERT INTO ingresso (nro_serie, tipo, id_de) VALUES (2, 'franca', 2);
INSERT INTO ingresso (nro_serie, tipo, id_de) VALUES (3, 'meia', 1);
INSERT INTO ingresso (nro_serie, tipo, id_de) VALUES (4, 'inteira', 2);
INSERT INTO ingresso (nro_serie, tipo, id_de) VALUES (5, 'franca', 2);
INSERT INTO ingresso (nro_serie, tipo, id_de) VALUES (6, 'meia', 2);
INSERT INTO ingresso (nro_serie, tipo, id_de) VALUES (7, 'inteira', 1);


INSERT INTO funcionario (cpf, nome) VALUES ('46815736555', 'pedro pereira da silva');
INSERT INTO funcionario (cpf, nome) VALUES ('31498432433', 'luana rodrigues de souza');

INSERT INTO turno (cpf_f, id_de, horario_entrada, horario_saida, funcao, pagamento) VALUES ('46815736555', 1, TO_DATE('15:00', 'HH24:MI'), TO_DATE('22:00', 'HH24:MI'), 'seguranca', 150.00);
INSERT INTO turno (cpf_f, id_de, horario_entrada, horario_saida, funcao, pagamento) VALUES ('31498432433', 2, TO_DATE('14:00', 'HH24:MI'), TO_DATE('20:00', 'HH24:MI'), 'atendente no bar', 100.00);
INSERT INTO turno (cpf_f, id_de, horario_entrada, horario_saida, funcao, pagamento) VALUES ('46815736555', 3, TO_DATE('15:00', 'HH24:MI'), TO_DATE('22:00', 'HH24:MI'), 'seguranca', 70.00);
INSERT INTO turno (cpf_f, id_de, horario_entrada, horario_saida, funcao, pagamento) VALUES ('31498432433', 4, TO_DATE('14:00', 'HH24:MI'), TO_DATE('20:00', 'HH24:MI'), 'atendente no bar', 30.00);
INSERT INTO turno (cpf_f, id_de, horario_entrada, horario_saida, funcao, pagamento) VALUES ('46815736555', 5, TO_DATE('17:00', 'HH24:MI'), TO_DATE('18:00', 'HH24:MI'), 'seguranca', 1000.00);
INSERT INTO turno (cpf_f, id_de, horario_entrada, horario_saida, funcao, pagamento) VALUES ('31498432433', 6, TO_DATE('08:00', 'HH24:MI'), TO_DATE('22:00', 'HH24:MI'), 'atendente no bar', 450.00);


INSERT INTO comerciante (cnpj, nome_fantasia) VALUES ('33767515000170', 'ki lanche bom');
INSERT INTO comerciante (cnpj, nome_fantasia) VALUES ('00804381000161', 'churros malandro');

INSERT INTO produto (cnpj_c, nome, preco, qtde) VALUES ('33767515000170', 'hot dog triplo', 25.00, 50);
INSERT INTO produto (cnpj_c, nome, preco, qtde) VALUES ('00804381000161', 'churros completo', 5.00, 40);

INSERT INTO comerciante_dia_e (cnpj_c, id_de, nro_estande, aluguel) VALUES ('33767515000170', 1, 4, 1000);
INSERT INTO comerciante_dia_e (cnpj_c, id_de, nro_estande, aluguel) VALUES ('00804381000161', 2, 1, 600);
