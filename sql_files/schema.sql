CREATE TABLE evento(
    nome VARCHAR2(50),
    edicao VARCHAR2(30),
    CONSTRAINT PK_EVENTO PRIMARY KEY(nome, edicao)
);

CREATE TABLE equipamento(
    cod_patrimonio NUMBER(9, 0),
    nome VARCHAR2(30) NOT NULL,
    setor VARCHAR2(30),
    valor_pago NUMBER(8,2),
    CONSTRAINT PK_EQUIPAMENTO PRIMARY KEY(cod_patrimonio)
);

CREATE TABLE equipamento_ev(
    cod_patrimonio NUMBER(9, 0),
    nome_e VARCHAR2(50),
    edicao_e VARCHAR2(30),
    CONSTRAINT PK_EQUIPAMENTO_EV PRIMARY KEY(cod_patrimonio, nome_e, edicao_e),
    CONSTRAINT FK_EQUIPAMENTO_EV1 FOREIGN KEY (cod_patrimonio) REFERENCES equipamento,
    CONSTRAINT FK_EQUIPAMENTO_EV2 FOREIGN KEY (nome_e, edicao_e) REFERENCES evento
);

CREATE TABLE empresa_p(
    cnpj CHAR(14),
    nome_fantasia VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_EMPRESA_P PRIMARY KEY(cnpj),
    CONSTRAINT CK_EMPRESA_P CHECK(REGEXP_LIKE(cnpj, '([0-9]{14})'))
);

CREATE TABLE patrocinio(
    nome_e VARCHAR2(50),
    edicao_e VARCHAR2(30),
    cnpj_ep CHAR(14),
    contribuicao NUMBER(8,2) NOT NULL,
    CONSTRAINT PK_PATROCINIO PRIMARY KEY(nome_e, edicao_e, cnpj_ep),
    CONSTRAINT FK_PATROCINIO1 FOREIGN KEY (nome_e, edicao_e) REFERENCES evento,
    CONSTRAINT FK_PATROCINIO2 FOREIGN KEY (cnpj_ep) REFERENCES empresa_p
);

CREATE TABLE aluno(
    ra NUMBER(8, 0),
    nome VARCHAR2(50) NOT NULL,
    vinculo VARCHAR2(10) NOT NULL,
    CONSTRAINT PK_ALUNO PRIMARY KEY(ra),
    CONSTRAINT CK_ALUNO CHECK (vinculo IN ('socio', 'membro'))
);

CREATE TABLE viagem(
    id NUMBER(10,0),
    destino VARCHAR2(50) NOT NULL,
    data_hora_partida DATE NOT NULL,
    local_partida VARCHAR2(50) NOT NULL,
    custo NUMBER(8, 2),
    CONSTRAINT PK_VIAGEM PRIMARY KEY(id),
    CONSTRAINT UC_VIAGEM UNIQUE (destino, data_hora_partida, local_partida)
);

CREATE TABLE viagem_aluno(
    id_v NUMBER(10,0),
    ra NUMBER(8, 0),
    CONSTRAINT PK_VIAGEM_ALUNO PRIMARY KEY(id_v, ra),
    CONSTRAINT FK_VIAGEM_ALUNO1 FOREIGN KEY (id_v) REFERENCES viagem,
    CONSTRAINT FK_VIAGEM_ALUNO2 FOREIGN KEY (ra) REFERENCES aluno
);

CREATE TABLE viagem_evento(
    nome_e VARCHAR2(50),
    edicao_e VARCHAR2(30),
    id_v NUMBER(10,0),
    CONSTRAINT PK_VIAGEM_EVENTO PRIMARY KEY(nome_e, edicao_e, id_v),
    CONSTRAINT FK_VIAGEM_EVENTO1 FOREIGN KEY (nome_e, edicao_e) REFERENCES evento,
    CONSTRAINT FK_VIAGEM_EVENTO2 FOREIGN KEY (id_v) REFERENCES viagem
);

CREATE TABLE membro(
    ra NUMBER(8, 0),
    cargo VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_MEMBRO PRIMARY KEY(ra),
    CONSTRAINT FK_MEMBRO FOREIGN KEY (ra) REFERENCES aluno
);

CREATE TABLE socio(
    ra NUMBER(8, 0),
    data_inicio_plano DATE NOT NULL,
    data_fim_plano DATE NOT NULL,
    CONSTRAINT PK_SOCIO PRIMARY KEY(ra),
    CONSTRAINT FK_SOCIO FOREIGN KEY (ra) REFERENCES aluno
);

CREATE TABLE evento_membro(
    nome_e VARCHAR2(50),
    edicao_e VARCHAR2(30),
    ra NUMBER(8, 0),
    CONSTRAINT PK_EVENTO_MEMBRO PRIMARY KEY(nome_e, edicao_e, ra),
    CONSTRAINT FK_EVENTO_MEMBRO1 FOREIGN KEY (nome_e, edicao_e) REFERENCES evento,
    CONSTRAINT FK_EVENTO_MEMBRO2 FOREIGN KEY (ra) REFERENCES membro
);

CREATE TABLE dia_evento(
    nome_e VARCHAR2(50) NOT NULL,
    edicao_e VARCHAR2(30) NOT NULL,
    data DATE NOT NULL,
    preco_ingresso NUMBER(8,2),
    id NUMBER(10, 0),
    CONSTRAINT PK_DIA_EVENTO PRIMARY KEY(id),
    CONSTRAINT FK_DIA_EVENTO1 FOREIGN KEY (nome_e, edicao_e) REFERENCES evento,
    CONSTRAINT UC_DIA_EVENTO UNIQUE (nome_e, edicao_e, data)
);

CREATE TABLE artista(
    cnpj CHAR(14),
    email VARCHAR(30),
    nome_artistico VARCHAR(50) NOT NULL,
    CONSTRAINT PK_ARTISTA PRIMARY KEY(cnpj),
    CONSTRAINT CK_ARTISTA1 CHECK (REGEXP_LIKE(email, '^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$')),
    CONSTRAINT CK_ARTISTA2 CHECK(REGEXP_LIKE(cnpj, '([0-9]{14})'))
);

CREATE TABLE apresentacao(
    id_de NUMBER(10,0),
    cnpj_a CHAR(14),
    horario DATE,
    cache NUMBER(8, 2),
    CONSTRAINT PK_APRESENTACAO PRIMARY KEY(id_de, cnpj_a),
    CONSTRAINT FK_APRESENTACAO1 FOREIGN KEY (id_de) REFERENCES dia_evento,
    CONSTRAINT FK_APRESENTACAO2 FOREIGN KEY (cnpj_a) REFERENCES artista
);

CREATE TABLE ingresso(
    nro_serie NUMBER(14, 0),
    tipo VARCHAR2(10),
    id_de NUMBER(10,0) NOT NULL,
    CONSTRAINT PK_INGRESSO PRIMARY KEY(nro_serie),
    CONSTRAINT FK_INGRESSO FOREIGN KEY (id_de) REFERENCES dia_evento,
    CONSTRAINT CK_INGRESSO CHECK (tipo IN ('inteira', 'meia', 'franca'))
);

CREATE TABLE funcionario(
    cpf CHAR(11),
    nome VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_FUNCIONARIO PRIMARY KEY(cpf),
    CONSTRAINT CK_FUNCIONARIO CHECK(REGEXP_LIKE(cpf, '([0-9]{11})'))
);

CREATE TABLE turno(
    cpf_f CHAR(11),
    id_de NUMBER(10,0),
    horario_entrada DATE,
    horario_saida DATE,
    funcao VARCHAR2(20),
    pagamento NUMBER(8,2),
    CONSTRAINT PK_TURNO PRIMARY KEY(cpf_f, id_de, horario_entrada),
    CONSTRAINT FK_TURNO1 FOREIGN KEY (id_de) REFERENCES dia_evento,
    CONSTRAINT FK_TURNO2 FOREIGN KEY (cpf_f) REFERENCES funcionario
);

CREATE TABLE comerciante(
    cnpj CHAR(14),
    nome_fantasia VARCHAR2(50) NOT NULL,
    CONSTRAINT PK_COMERCIANTE PRIMARY KEY(cnpj),
    CONSTRAINT CK_COMERCIANTE CHECK(REGEXP_LIKE(cnpj, '([0-9]{14})'))
);

CREATE TABLE produto(
    cnpj_c CHAR(14),
    nome VARCHAR2(50),
    preco NUMBER(8,2),
    qtde NUMBER(8,0),
    CONSTRAINT PK_PRODUTO PRIMARY KEY(cnpj_c, nome),
    CONSTRAINT FK_PRODUTO FOREIGN KEY (cnpj_c) REFERENCES comerciante
);

CREATE TABLE comerciante_dia_e(
    cnpj_c CHAR(14),
    id_de NUMBER(10,0),
    nro_estande NUMBER(3,0),
    aluguel NUMBER(8,2),
    CONSTRAINT PK_COMERCIANTE_DIA_E PRIMARY KEY(cnpj_c, id_de),
    CONSTRAINT FK_COMERCIANTE_DIA_E1 FOREIGN KEY (cnpj_c) REFERENCES comerciante,
    CONSTRAINT FK_COMERCIANTE_DIA_E2 FOREIGN KEY (id_de) REFERENCES dia_evento
);
