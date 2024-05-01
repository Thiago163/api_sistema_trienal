CREATE DATABASE Mundo_verde;

USE Mundo_verde;

CREATE TABLE LOCALIZACAO (
    id_localizacao INTEGER NOT NULL PRIMARY KEY IDENTITY,
    cep VARCHAR(20),
    estado VARCHAR(50),
    cidade VARCHAR(50),
    rua VARCHAR(100),
    numero VARCHAR(20),
    pais VARCHAR(50),
    complemento VARCHAR(100)
);

CREATE TABLE USUARIO (
    id_usuario INTEGER NOT NULL PRIMARY KEY IDENTITY,
    id_localizacao INTEGER,
    documento INTEGER,
    tipo_documento VARCHAR(20),
    nome VARCHAR(300),
    email VARCHAR(100),
    telefone VARCHAR(20),
    senha VARCHAR(100),
    FOREIGN KEY (id_localizacao) REFERENCES LOCALIZACAO(id_localizacao) ON DELETE RESTRICT
);

CREATE TABLE AGUA (
    id_agua INTEGER NOT NULL PRIMARY KEY IDENTITY,
    previsao_proxima_irrigacao DATE,
    quantidade_agua_muda DOUBLE,
    quantidade_agua_campo DOUBLE,
    frequencia_irrigacao DATE
);

CREATE TABLE COMPONENTES (
    id_componentes INTEGER NOT NULL PRIMARY KEY IDENTITY,
    marca_adubo VARCHAR(100),
    previsao_proxima_adubo DATE,
    tipo_adubo VARCHAR(100),
    data_validade_adubo DATE
);

CREATE TABLE ALIMENTO (
    id_alimento INTEGER NOT NULL PRIMARY KEY IDENTITY,
    nome_alimento VARCHAR(200),
    marca_semente VARCHAR(200),
    data_plantacao DATE,
    tipo_alimento VARCHAR(200),
    periodo_plantacao DATE,
    data_validade_semente DATE
);

CREATE TABLE CAMPO (
    id_campo INTEGER NOT NULL PRIMARY KEY IDENTITY,
    id_localizacao INTEGER,
    id_agua INTEGER,
    id_alimento INTEGER,
    id_componentes INTEGER,
    quantidade_mudas INTEGER,
    tamanho_campo DOUBLE,
    qualidade_solo VARCHAR(100),
    tipo_solo VARCHAR(100),
    data_ultima_colheita DATE,
    previsao_colheita DATE,
    estacao_ano VARCHAR(50),
    FOREIGN KEY (id_localizacao) REFERENCES LOCALIZACAO(id_localizacao) ON DELETE RESTRICT,
    FOREIGN KEY (id_agua) REFERENCES AGUA(id_agua) ON DELETE RESTRICT,
    FOREIGN KEY (id_alimento) REFERENCES ALIMENTO(id_alimento) ON DELETE RESTRICT
    FOREIGN KEY (id_componentes) REFERENCES COMPONENTES(id_componentes) ON DELETE RESTRICT
);

CREATE TABLE CAMPO_COMPONENTES (
    id_campo INTEGER NOT NULL PRIMARY KEY IDENTITY,
    id_componentes INTEGER,
    PRIMARY KEY (id_campo, id_componentes),
    FOREIGN KEY (id_campo) REFERENCES CAMPO(id_campo) ON DELETE RESTRICT,
    FOREIGN KEY (id_componentes) REFERENCES COMPONENTES(id_componentes) ON DELETE RESTRICT
);

ALTER TABLE USUARIO ADD CONSTRAINT FK_USUARIO_1
    FOREIGN KEY (id_localizacao)
    REFERENCES LOCALIZACAO (id_localizacao)
    ON DELETE RESTRICT;

ALTER TABLE ALIMENTO ADD CONSTRAINT FK_ALIMENTO_1
    FOREIGN KEY (id_agua)
    REFERENCES AGUA (id_agua)
    ON DELETE RESTRICT;

ALTER TABLE ALIMENTO ADD CONSTRAINT FK_ALIMENTO_2
    FOREIGN KEY (id_alimento)
    REFERENCES CAMPO (id_alimento)
    ON DELETE RESTRICT;

ALTER TABLE CAMPO ADD CONSTRAINT FK_CAMPO_1
    FOREIGN KEY (id_localizacao)
    REFERENCES LOCALIZACAO (id_localizacao)
    ON DELETE RESTRICT;

ALTER TABLE CAMPO ADD CONSTRAINT FK_CAMPO_2
    FOREIGN KEY (id_agua)
    REFERENCES AGUA (id_agua)
    ON DELETE RESTRICT;

ALTER TABLE CAMPO ADD CONSTRAINT FK_CAMPO_3
    FOREIGN KEY (id_alimento)
    REFERENCES ALIMENTO (id_alimento)
    ON DELETE RESTRICT;

ALTER TABLE CAMPO_COMPONENTES ADD CONSTRAINT FK_CAMPO_COMPONENTES_1
    FOREIGN KEY (id_campo)
    REFERENCES CAMPO (id_campo)
    ON DELETE RESTRICT;

ALTER TABLE CAMPO_COMPONENTES ADD CONSTRAINT FK_CAMPO_COMPONENTES_2
    FOREIGN KEY (id_componentes)
    REFERENCES COMPONENTES (id_componentes)
    ON DELETE RESTRICT;
