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
    FOREIGN KEY (id_alimento) REFERENCES ALIMENTO(id_alimento) ON DELETE RESTRICT,
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
    
    -- Inserir dados na tabela LOCALIZACAO
INSERT INTO LOCALIZACAO (cep, estado, cidade, rua, numero, pais, complemento) 
VALUES 
('12345-678', 'São Paulo', 'São Paulo', 'Rua Exemplo', '123', 'Brasil', 'Apt 101'),
('54321-876', 'Rio de Janeiro', 'Rio de Janeiro', 'Av. Modelo', '456', 'Brasil', 'Casa 2'),
('98765-432', 'Belo Horizonte', 'Minas Gerais', 'R. Teste', '789', 'Brasil', 'Loja 3');

-- Inserir dados na tabela USUARIO
INSERT INTO USUARIO (id_localizacao, documento, tipo_documento, nome, email, telefone, senha) 
VALUES 
(1, 123456789, 'RG', 'João Silva', 'joao@example.com', '(11) 91234-5678', 'senha123'),
(2, 987654321, 'CPF', 'Maria Souza', 'maria@example.com', '(21) 99876-5432', 'abcd9876'),
(3, 111222333, 'CPF', 'Pedro Oliveira', 'pedro@example.com', '(31) 98765-4321', 'qwerty');

-- Inserir dados na tabela AGUA
INSERT INTO AGUA (previsao_proxima_irrigacao, quantidade_agua_muda, quantidade_agua_campo, frequencia_irrigacao) 
VALUES 
('2024-05-05', 10.5, 50.2, '2024-05-10'),
('2024-05-06', 9.8, 48.5, '2024-05-11'),
('2024-05-07', 11.2, 55.0, '2024-05-12');

-- Inserir dados na tabela COMPONENTES
INSERT INTO COMPONENTES (marca_adubo, previsao_proxima_adubo, tipo_adubo, data_validade_adubo) 
VALUES 
('Adubo XYZ', '2024-05-08', 'Orgânico', '2025-05-08'),
('Adubo ABC', '2024-05-09', 'Químico', '2025-05-09'),
('Adubo DEF', '2024-05-10', 'Orgânico', '2025-05-10');

-- Inserir dados na tabela ALIMENTO
INSERT INTO ALIMENTO (nome_alimento, marca_semente, data_plantacao, tipo_alimento, periodo_plantacao, data_validade_semente) 
VALUES 
('Tomate', 'Semente A', '2024-04-01', 'Vegetal', '2024-10-01', '2025-04-01'),
('Alface', 'Semente B', '2024-04-05', 'Vegetal', '2024-10-05', '2025-04-05'),
('Cenoura', 'Semente C', '2024-04-10', 'Vegetal', '2024-10-10', '2025-04-10');

-- Inserir dados na tabela CAMPO
INSERT INTO CAMPO (id_localizacao, id_agua, id_alimento, id_componentes, quantidade_mudas, tamanho_campo, qualidade_solo, tipo_solo, data_ultima_colheita, previsao_colheita, estacao_ano) 
VALUES 
(1, 1, 1, 1, 1000, 500.0, 'Fértil', 'Argiloso', '2024-04-15', '2024-07-15', 'Verão'),
(2, 2, 2, 2, 800, 400.0, 'Bom', 'Arenoso', '2024-04-20', '2024-07-20', 'Verão'),
(3, 3, 3, 3, 1200, 600.0, 'Regular', 'Arenoso', '2024-04-25', '2024-07-25', 'Verão');

-- Inserir dados na tabela CAMPO_COMPONENTES
INSERT INTO CAMPO_COMPONENTES (id_campo, id_componentes) 
VALUES 
(1, 1),
(2, 2),
(3, 3);
