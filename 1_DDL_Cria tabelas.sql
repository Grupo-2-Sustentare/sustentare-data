DROP DATABASE IF EXISTS sustentare;

CREATE DATABASE IF NOT EXISTS sustentare;

USE sustentare;

CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(45) NOT NULL,
    senha VARCHAR(400) NOT NULL,
    acesso TINYINT NOT NULL,
    ativo TINYINT NOT NULL DEFAULT(TRUE),
    PRIMARY KEY (id_usuario)
) AUTO_INCREMENT = 100;

CREATE TABLE IF NOT EXISTS unidade_medida (
    id_unidade_medida INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(75) NOT NULL,
    conversao_padrao DECIMAL(4, 2) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    simbolo VARCHAR(10),
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_unidade_medida)
);

CREATE TABLE IF NOT EXISTS categoria_item (
    id_categoria_item INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_categoria_item)
);

CREATE TABLE IF NOT EXISTS item (
    id_item INT NOT NULL AUTO_INCREMENT,
    fk_categoria_item INT NOT NULL,
    nome VARCHAR(65) NOT NULL,
    perecivel TINYINT NOT NULL,
    fk_unidade_medida INT NOT NULL,
    dias_vencimento INT,
    qtd_min_item DECIMAL(6, 2) NOT NULL DEFAULT(0.0),
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_item),
    CONSTRAINT fk_categoria_item FOREIGN KEY (fk_categoria_item) REFERENCES categoria_item (id_categoria_item),
    CONSTRAINT fk_unidade_medida_item FOREIGN KEY (fk_unidade_medida) REFERENCES unidade_medida (id_unidade_medida)
);

CREATE TABLE IF NOT EXISTS item_audit (
    id_item_audit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(60) NOT NULL,
    data_hora DATETIME NOT NULL,
    fk_item INT NOT NULL,
    fk_usuario INT NOT NULL,
    PRIMARY KEY (id_item_audit),
    CONSTRAINT fk_usuario_item_audit FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_item_item_audit FOREIGN KEY (fk_item) REFERENCES item (id_item)
);

CREATE TABLE IF NOT EXISTS produto (
    id_produto INT NOT NULL AUTO_INCREMENT,
    fk_item INT NOT NULL,
    preco DECIMAL(8, 2) NOT NULL,
    qtd_produto DECIMAL(6, 2) NOT NULL,
    qtd_produto_total DECIMAL(6, 2) NOT NULL,
    qtd_medida DECIMAL(12, 2) NOT NULL,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_produto, fk_item),
    FOREIGN KEY (fk_item) REFERENCES item (id_item)
);

CREATE TABLE IF NOT EXISTS interacao_estoque (
    id_interacao_estoque INT NOT NULL AUTO_INCREMENT,
    fk_produto INT NOT NULL,
    data_hora DATETIME NOT NULL,
    fk_fechamento_estoque INT,
    categoria_interacao VARCHAR(45),
    PRIMARY KEY (id_interacao_estoque, fk_produto),
    FOREIGN KEY (fk_produto) REFERENCES produto (id_produto)
);

CREATE TABLE IF NOT EXISTS interacao_estoque_audit (
    id_interacao_estoque_audit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(60) NOT NULL,
    data_hora DATETIME NOT NULL,
    fk_usuario INT NOT NULL,
    fk_interacao_estoque INT NOT NULL,
    fk_produto INT NOT NULL,
    PRIMARY KEY (id_interacao_estoque_audit),
    CONSTRAINT fk_usuario_interacao_estoque_audit FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_interacao_estoque_interacao_estoque_audit FOREIGN KEY (fk_interacao_estoque, fk_produto) REFERENCES interacao_estoque (id_interacao_estoque, fk_produto)
);

CREATE USER IF NOT EXISTS 'projetoSemente'@'localhost' IDENTIFIED BY 'urubu100';
GRANT ALL PRIVILEGES ON sustentare.* TO 'projetoSemente' @'localhost';