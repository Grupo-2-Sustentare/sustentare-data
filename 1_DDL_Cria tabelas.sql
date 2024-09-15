CREATE DATABASE IF NOT EXISTS sustentare;
USE sustentare;

-- DROP DATABASE sustentare;-- 

CREATE TABLE IF NOT EXISTS usuario (
    id_usuario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(60) NOT NULL,
    email VARCHAR(45) NOT NULL,
    senha VARCHAR(400) NOT NULL,
    acesso TINYINT NOT NULL,
    PRIMARY KEY (id_usuario)
)AUTO_INCREMENT = 100;

--   Select * from usuario;

-- Criação da tabela usuario_audit

CREATE TABLE IF NOT EXISTS usuario_audit (
    idUsuarioAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    responsavel INT NOT NULL,
    usuarioAlterado INT NOT NULL,
    PRIMARY KEY (idUsuarioAudit),
    CONSTRAINT fk_responsavel
       FOREIGN KEY (responsavel) REFERENCES usuario (id_usuario),
   CONSTRAINT fk_usuarioAlterado FOREIGN KEY (usuarioAlterado)
       REFERENCES usuario (id_usuario)
);

-- Select * from usuario_audit;

CREATE TABLE IF NOT EXISTS unidade_medida (
    id_unidade_medida INT NOT NULL AUTO_INCREMENT,
    categoria VARCHAR(75) NOT NULL,
    conversao_padrao DECIMAL(4,2) NOT NULL,
    nome VARCHAR(45) NOT NULL,
    simbolo VARCHAR(10),
    PRIMARY KEY (id_unidade_medida)
);

Select * from unidade_medida;

CREATE TABLE IF NOT EXISTS unidade_medida_audit (
   idUnidadeMedidaAudit INT NOT NULL AUTO_INCREMENT,
   descricao VARCHAR(45) NOT NULL,
   dataHora DATETIME NOT NULL,
   fkUsuario INT NOT NULL,
   fkUnidadeMedida INT NOT NULL,
   PRIMARY KEY (idUnidadeMedidaAudit),
    CONSTRAINT fk_usuario_audit
        FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_unidade_medida_audit
        FOREIGN KEY (fkUnidadeMedida) REFERENCES unidade_medida (id_unidade_medida)
);

Select * from unidade_medida_audit;

-- Criação da tabela categoria
CREATE TABLE IF NOT EXISTS categoria_item (
    id_categoria_item INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_categoria_item)
);

Select * from categoria_item;

-- Criação da tabela categoria_item_audit
CREATE TABLE IF NOT EXISTS categoria_item_audit (
    idCategoriaItemAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkCategoriaItem INT NOT NULL,
    fkUsuario INT NOT NULL,
    PRIMARY KEY (idCategoriaItemAudit),
    CONSTRAINT fk_usuario_categoria_item_audit
        FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_categoria_categoria_item_audit
        FOREIGN KEY (fkCategoriaItem) REFERENCES categoria_item (id_categoria_item)
);

-- Select * from categoria_item_audit;

-- Criação da tabela item
CREATE TABLE IF NOT EXISTS item (
    id_item INT NOT NULL AUTO_INCREMENT,
    fk_categoria_item INT NOT NULL,
    nome VARCHAR(65) NOT NULL,
    perecivel TINYINT NOT NULL,
    fk_unidade_medida INT NOT NULL,
    dias_vencimento INT,
    PRIMARY KEY (id_item),
    CONSTRAINT fk_categoria_item FOREIGN KEY (fk_categoria_item) REFERENCES categoria_item (id_categoria_item),
    CONSTRAINT fk_unidade_medida_item FOREIGN KEY (fk_unidade_medida) REFERENCES unidade_medida (id_unidade_medida)
);

Select * from item;

-- Criação da tabela item_audit
CREATE TABLE IF NOT EXISTS item_audit (
    idItemAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkItem INT NOT NULL,
    fkUsuario INT NOT NULL,
    PRIMARY KEY (idItemAudit),
    CONSTRAINT fk_usuario_item_audit
        FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_item_item_audit
        FOREIGN KEY (fkItem) REFERENCES item (id_item)
);

-- Select * from item_audit;

-- Criação da tabela produto
CREATE TABLE IF NOT EXISTS produto (
    id_produto INT NOT NULL AUTO_INCREMENT,
    fk_item INT NOT NULL,
    nome VARCHAR(120) NOT NULL,
    preco DECIMAL(8,2) NOT NULL,
    qtd_produto INT NOT NULL,
    qtd_medida DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_produto, fk_item),
    FOREIGN KEY (fk_item) REFERENCES item (id_item)
);

-- Select * from produto;

-- Criação da tabela produto_audit
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

-- Select * from produto_audit;

-- Criação da tabela de fechamento do estoque
CREATE TABLE IF NOT EXISTS fechamento_estoque (
    id_estoque INT NOT NULL AUTO_INCREMENT,
    data_fim DATETIME NOT NULL,
    data_inicio DATETIME NOT NULL,
    data_fechamento DATETIME NOT NULL,
    is_manual TINYINT NOT NULL,
    PRIMARY KEY (id_estoque)
);

-- Select * from fechamento_estoque;

-- Criação da tabela fechamento_estoque_audit
CREATE TABLE IF NOT EXISTS fechamento_estoque_audit (
    idFechamentoEstoqueAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkUsuario INT NOT NULL,
    fkFechamentoEstoque INT NOT NULL,
    PRIMARY KEY (idFechamentoEstoqueAudit),
    CONSTRAINT fk_usuario_fechamento_estoque_audit
        FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_fechamento_estoque_fechamento_estoque_audit
        FOREIGN KEY (fkFechamentoEstoque) REFERENCES fechamento_estoque (id_estoque)
);

-- Select * from fechamento_estoque_audit;

-- Criação da tabela interacao_estoque
CREATE TABLE IF NOT EXISTS interacao_estoque (
    id_interacao_estoque INT NOT NULL AUTO_INCREMENT,
    fk_produto INT NOT NULL,
    data_hora DATETIME NOT NULL,
    fk_fechamento_estoque INT,
    categoria_interacao VARCHAR(45),
    PRIMARY KEY (id_interacao_estoque, fk_produto),
    FOREIGN KEY (fk_produto) REFERENCES produto (id_produto)
);

-- Select * from interacao_estoque;

-- Criação da tabela interacao_estoque_audit
CREATE TABLE IF NOT EXISTS interacao_estoque_audit (
    idInteracaoEstoqueAudit INT NOT NULL AUTO_INCREMENT,
    descricao VARCHAR(45) NOT NULL,
    dataHora DATETIME NOT NULL,
    fkUsuario INT NOT NULL,
    fkInteracaoEstoque INT NOT NULL,
    fkProduto INT NOT NULL,
    PRIMARY KEY (idInteracaoEstoqueAudit),
    CONSTRAINT fk_usuario_interacao_estoque_audit
        FOREIGN KEY (fkUsuario) REFERENCES usuario (id_usuario),
    CONSTRAINT fk_interacao_estoque_interacao_estoque_audit
        FOREIGN KEY (fkInteracaoEstoque, fkProduto) REFERENCES interacao_estoque (id_interacao_estoque, fk_produto)
);

-- Select * from interacao_estoque_audit;
