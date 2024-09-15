USE sustentare;

-- Criando um primeiro usuário, para ser alvo das triggers
INSERT INTO usuario (nome, email, senha, acesso) VALUE ('Antônio', 'antonio@email.com', '123', 1);
SET @current_user_id = 100; -- Exemplo de Usuário que está adicionando dados no banco

-- Trigger usuario
DELIMITER $$
CREATE TRIGGER trg_insert_usuario
AFTER INSERT ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado)
    VALUES ('Inserção de novo usuário', NOW(), @current_user_id, NEW.id_usuario);
END$$

CREATE TRIGGER trg_update_usuario
AFTER UPDATE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado)
    VALUES ('Atualização de usuário', NOW(), @current_user_id, NEW.id_usuario);
END$$

CREATE TRIGGER trg_delete_usuario
AFTER DELETE ON usuario
FOR EACH ROW
BEGIN
    INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado)
    VALUES ('Remoção de usuário', NOW(), @current_user_id, OLD.id_usuario);
END$$
DELIMITER ;

-- Triger unidade medida

DELIMITER $$
CREATE TRIGGER trg_insert_unidade_medida
AFTER INSERT ON unidade_medida
FOR EACH ROW
BEGIN
    INSERT INTO unidade_medida_audit (descricao, dataHora, fkUsuario, fkUnidadeMedida)
    VALUES ('Inserção de nova unidade de medida', NOW(), @current_user_id, NEW.id_unidade_medida);
END$$

CREATE TRIGGER trg_update_unidade_medida
AFTER UPDATE ON unidade_medida
FOR EACH ROW
BEGIN
    INSERT INTO unidade_medida_audit (descricao, dataHora, fkUsuario, fkUnidadeMedida)
    VALUES ('Atualização de unidade de medida', NOW(), @current_user_id, NEW.id_unidade_medida);
END$$

CREATE TRIGGER trg_delete_unidade_medida
AFTER DELETE ON unidade_medida
FOR EACH ROW
BEGIN
    INSERT INTO unidade_medida_audit (descricao, dataHora, fkUsuario, fkUnidadeMedida)
    VALUES ('Remoção de unidade de medida', NOW(), @current_user_id, OLD.id_unidade_medida);
END$$
DELIMITER ;

-- Trigger categoria item

DELIMITER $$
CREATE TRIGGER trg_insert_categoria_item
AFTER INSERT ON categoria_item
FOR EACH ROW
BEGIN
    INSERT INTO categoria_item_audit (descricao, dataHora, fkCategoriaItem, fkUsuario)
    VALUES ('Inserção de nova categoria de item', NOW(), NEW.id_categoria_item, @current_user_id);
END$$

CREATE TRIGGER trg_update_categoria_item
AFTER UPDATE ON categoria_item
FOR EACH ROW
BEGIN
    INSERT INTO categoria_item_audit (descricao, dataHora, fkCategoriaItem, fkUsuario)
    VALUES ('Atualização de categoria de item', NOW(), NEW.id_categoria_item, @current_user_id);
END$$

CREATE TRIGGER trg_delete_categoria_item
AFTER DELETE ON categoria_item
FOR EACH ROW
BEGIN
    INSERT INTO categoria_item_audit (descricao, dataHora, fkCategoriaItem, fkUsuario)
    VALUES ('Remoção de categoria de item', NOW(), OLD.id_categoria_item, @current_user_id);
END$$
DELIMITER ;

-- Trigger item

DELIMITER $$
CREATE TRIGGER trg_insert_item
AFTER INSERT ON item
FOR EACH ROW
BEGIN
    INSERT INTO item_audit (descricao, dataHora, fkItem, fkUsuario)
    VALUES ('Inserção de novo item', NOW(), NEW.id_item, @current_user_id);
END$$

CREATE TRIGGER trg_update_item
AFTER UPDATE ON item
FOR EACH ROW
BEGIN
    INSERT INTO item_audit (descricao, dataHora, fkItem, fkUsuario)
    VALUES ('Atualização de item', NOW(), NEW.id_item, @current_user_id);
END$$

CREATE TRIGGER trg_delete_item
AFTER DELETE ON item
FOR EACH ROW
BEGIN
    INSERT INTO item_audit (descricao, dataHora, fkItem, fkUsuario)
    VALUES ('Remoção de item', NOW(), OLD.id_item, @current_user_id);
END$$
DELIMITER ;

-- Triger produto

DELIMITER $$
CREATE TRIGGER trg_insert_produto
AFTER INSERT ON produto
FOR EACH ROW
BEGIN
    INSERT INTO produto_audit (descricao, dataHora, fkProduto, fkUsuario, fkItem)
    VALUES ('Inserção de novo produto', NOW(), NEW.id_produto, @current_user_id, NEW.fk_item);
END$$

CREATE TRIGGER trg_update_produto
AFTER UPDATE ON produto
FOR EACH ROW
BEGIN
    INSERT INTO produto_audit (descricao, dataHora, fkProduto, fkUsuario, fkItem)
    VALUES ('Atualização de produto', NOW(),NEW.id_produto, @current_user_id, NEW.fk_item);
END$$

CREATE TRIGGER trg_delete_produto
AFTER DELETE ON produto
FOR EACH ROW
BEGIN
INSERT INTO produto_audit (descricao, dataHora, fkProduto, fkUsuario, fkItem)
VALUES ('Remoção de produto', NOW(),OLD.id_produto, @current_user_id, OLD.fk_item);
END$$
DELIMITER ;

-- Trigger fechamento estoque

-- DELIMITER $$
-- CREATE TRIGGER trg_insert_fechamento_estoque
-- AFTER INSERT ON fechamento_estoque
-- FOR EACH ROW
-- BEGIN
--     INSERT INTO fechamento_estoque_audit (descricao, dataHora, fkFechamentoEstoque, fkUsuario)
--     VALUES ('Inserção de novo fechamento de estoque', NOW(), NEW.id_estoque, @current_user_id);
-- END$$

-- CREATE TRIGGER trg_update_fechamento_estoque
-- AFTER UPDATE ON fechamento_estoque
-- FOR EACH ROW
-- BEGIN
--     INSERT INTO fechamento_estoque_audit (descricao, dataHora, fkFechamentoEstoque, fkUsuario)
--     VALUES ('Atualização de fechamento de estoque', NOW(), NEW.id_estoque, @current_user_id);
-- END$$

-- CREATE TRIGGER trg_delete_fechamento_estoque
-- AFTER DELETE ON fechamento_estoque
-- FOR EACH ROW
-- BEGIN
--     INSERT INTO fechamento_estoque_audit (descricao, dataHora, fkFechamentoEstoque, fkUsuario)
--     VALUES ('Remoção de fechamento de estoque', NOW(), OLD.id_estoque, @current_user_id);
-- END$$
-- DELIMITER ;


-- Trigger interação estoque audit 

DELIMITER $$
CREATE TRIGGER trg_insert_interacao_estoque
AFTER INSERT ON interacao_estoque
FOR EACH ROW
BEGIN
    INSERT INTO interacao_estoque_audit (descricao, dataHora, fkInteracaoEstoque, fkProduto, fkUsuario)
    VALUES ('Inserção de nova interação de estoque', NOW(), NEW.id_interacao_estoque, NEW.fk_produto, @current_user_id);
END$$

CREATE TRIGGER trg_update_interacao_estoque
AFTER UPDATE ON interacao_estoque
FOR EACH ROW
BEGIN
    INSERT INTO interacao_estoque_audit (descricao, dataHora, fkInteracaoEstoque, fkProduto, fkUsuario)
    VALUES ('Atualização de interação de estoque', NOW(), NEW.id_interacao_estoque, NEW.fk_produto, @current_user_id);
END$$

CREATE TRIGGER trg_delete_interacao_estoque
AFTER DELETE ON interacao_estoque
FOR EACH ROW
BEGIN
    INSERT INTO interacao_estoque_audit (descricao, dataHora, fkInteracaoEstoque, fkProduto, fkUsuario)
    VALUES ('Remoção de interação de estoque', NOW(), OLD.id_interacao_estoque, OLD.fk_produto, @current_user_id);
END$$
DELIMITER ;
