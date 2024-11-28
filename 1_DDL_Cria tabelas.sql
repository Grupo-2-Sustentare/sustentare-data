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

CREATE TABLE IF NOT EXISTS usuario_audit (
    idUsuarioAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    responsavel INT NOT NULL,
    usuarioAlterado INT NOT NULL,
    PRIMARY KEY (idUsuarioAudit),
    CONSTRAINT fk_responsavel FOREIGN KEY (responsavel) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_usuarioAlterado FOREIGN KEY (usuarioAlterado) REFERENCES usuario (id_usuario)
);

CREATE TABLE IF NOT EXISTS unidade_medida (
    id_unidade_medida INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(75) NOT NULL,
    conversao_padrao DECIMAL(4, 2) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    simbolo VARCHAR(10),
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_unidade_medida)
);

CREATE TABLE IF NOT EXISTS unidade_medida_audit (
    idUnidadeMedidaAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkUsuario INT NOT NULL,
    fkUnidadeMedida INT NOT NULL,
    PRIMARY KEY (idUnidadeMedidaAudit),
    CONSTRAINT fk_usuario_audit FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_unidade_medida_audit FOREIGN KEY (fkUnidadeMedida) REFERENCES unidade_medida (id_unidade_medida)
);

CREATE TABLE IF NOT EXISTS categoria_item (
    id_categoria_item INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_categoria_item)
);

CREATE TABLE IF NOT EXISTS categoria_item_audit (
    idCategoriaItemAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkCategoriaItem INT NOT NULL,
    fkUsuario INT NOT NULL,
    PRIMARY KEY (idCategoriaItemAudit),
    CONSTRAINT fk_usuario_categoria_item_audit FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_categoria_categoria_item_audit FOREIGN KEY (fkCategoriaItem) REFERENCES categoria_item (id_categoria_item)
);

CREATE TABLE IF NOT EXISTS item (
    id_item INT NOT NULL AUTO_INCREMENT,
    fk_categoria_item INT NOT NULL,
    nome VARCHAR(65) NOT NULL,
    perecivel TINYINT NOT NULL,
    fk_unidade_medida INT NOT NULL,
    dias_vencimento INT,
    ativo TINYINT NOT NULL,
    PRIMARY KEY (id_item),
    CONSTRAINT fk_categoria_item FOREIGN KEY (fk_categoria_item) REFERENCES categoria_item (id_categoria_item),
    CONSTRAINT fk_unidade_medida_item FOREIGN KEY (fk_unidade_medida) REFERENCES unidade_medida (id_unidade_medida)
);

CREATE TABLE IF NOT EXISTS item_audit (
    idItemAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkItem INT NOT NULL,
    fkUsuario INT NOT NULL,
    PRIMARY KEY (idItemAudit),
    CONSTRAINT fk_usuario_item_audit FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_item_item_audit FOREIGN KEY (fkItem) REFERENCES item (id_item)
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

CREATE TABLE IF NOT EXISTS produto_audit (
    idProdutoAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkUsuario INT NOT NULL,
    fkProduto INT NOT NULL,
    fkItem INT NOT NULL,
    PRIMARY KEY (idProdutoAudit),
    FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    FOREIGN KEY (fkProduto) REFERENCES produto (id_produto),
    FOREIGN KEY (fkItem) REFERENCES item (id_item)
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
    idInteracaoEstoqueAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkUsuario INT NOT NULL,
    fkInteracaoEstoque INT NOT NULL,
    fkProduto INT NOT NULL,
    PRIMARY KEY (idInteracaoEstoqueAudit),
    CONSTRAINT fk_usuario_interacao_estoque_audit FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_interacao_estoque_interacao_estoque_audit FOREIGN KEY (fkInteracaoEstoque, fkProduto) REFERENCES interacao_estoque (id_interacao_estoque, fk_produto)
);

CREATE USER IF NOT EXISTS 'paralelo19' @'localhost' IDENTIFIED BY 'urubu100';

GRANT ALL PRIVILEGES ON sustentare.* TO 'paralelo19' @'localhost';