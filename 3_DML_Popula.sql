USE sustentare;
SET @current_user_id = 100; -- Exemplo de Usuário que está adicionando dados no banco

INSERT INTO usuario (nome, email, senha, acesso, ativo) VALUES
('Maria Souza', 'maria.souza@gmail.com', 'senha456', 2, 1),
('Carlos Pereira', 'carlos.pereira@gmail.com', 'senha789', 2, 1);
-- ============================================================== Audit usuário =============================================================================
-- Inserts para criação dos 8 usuários
/*INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado) VALUES
('Criação de usuário', '2024-08-25 08:00:00', 100, 101),
('Criação de usuário', '2024-08-25 08:10:00', 100, 102),
('Criação de usuário', '2024-08-25 08:20:00', 100, 103),

-- Inserts para 3 registros de alteração
INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado) VALUES
('Alteração de senha', '2024-08-26 14:30:00', 100, 100),
('Alteração de email', '2024-08-27 09:15:00', 100, 101),
('Atualização de perfil de acesso', '2024-08-28 16:45:00', 100, 102);
*/
-- ============================================================ Unidade de medida =============================================================================

INSERT INTO unidade_medida (categoria, conversao_padrao, nome, simbolo, ativo) VALUES
('Volume', 1.00, 'Litro', 'L', 1),
('Volume', 0.01, 'Mililitro', 'mL', 1),
('Massa', 1.00, 'Quilograma', 'kg', 1),
('Massa', 0.001, 'Grama', 'g', 1),
('Volume', 3.8, 'Galões', 'gal', 1),
('Genérica', 1.00, 'Unidade Genérica', 'un', 1),
('Genérica', 2.00, 'Kit refrigerante', 'kit', 1);

-- ========================================================== Unidades de medida audit ==========================================================================
/*
INSERT INTO unidade_medida_audit (descricao, dataHora, fkUsuario, fkUnidadeMedida) VALUES
('Litro', '2024-08-25 10:00:00', 100, 1),
('Mililitro', '2024-08-25 10:10:00', 100, 2),
('Quilograma', '2024-08-25 10:20:00', 100, 3),
('Grama', '2024-08-25 10:30:00', 100, 4),
('Unidade', '2024-08-25 11:10:00', 100, 8),
*/
-- =================================================================== Categoria ===============================================================================

INSERT INTO categoria_item (nome, ativo) VALUES
('Ingredientes self-service', 1),
('Bebidas', 1),
('Descartáveis', 1),
('Produtos de limpeza', 1),
('Frente de caixa', 1),
('Condimentos', 1),
('Doces por encomenda', 1); -- Criado pelo usuário -> audit

-- =============================================================== Categoria Audit ================================================================================
/*
INSERT INTO categoria_item_audit (descricao, dataHora, fkCategoriaItem, fkUsuario) VALUES
('Criação da categoria: Doces por encomenda', '2024-08-25 10:00:00', 14, 100);
*/
-- ==================================================================== Item =====================================================================================

INSERT INTO item (fk_categoria_item, nome, perecivel, fk_unidade_medida, dias_vencimento, qtd_min_item, ativo) VALUES
(4, 'Detergente', 6, 6, NULL, NULL, 1), -- Produtos de limpeza, Unidade (un)
(3, 'Sacola plástica', 6, 6, NULL, 2, 1), -- Descartáveis, Unidade (un)
(2, 'Brahma duplo malte lata', 1, 6, 30, 10, 1), -- Bebidas, Unidade (un)
(2, 'Coca 300', 1, 6, 30, 10, 1), -- Bebidas, Unidade (un)
(2, 'Coca Zero 300', 1, 6, 30, 10, 1), -- Bebidas,Unidade (un)
(2, 'Heineken garrafa', 1, 6, 180, 10, 1), -- Bebidas, Unidade (un)
(5, 'Chocolate crunch', 1, 4, 360, NULL, 1), -- Frente de caixa, Peso (g)
(1, 'Molho de tomate', 1, 1, 720, 3, 1), -- Ingredientes self-s, Volume (L)
(1, 'Filé de frango', 1, 3, 5, 4, 1), -- Ingredientes self-s, Peso (kg)
(1, 'Camarão', 1, 4, 3, 8, 1), -- Ingredientes self-s, Peso (g)
(1, 'Arroz', 0, 3, 365, 9, 1), -- Ingredientes self-s, Peso (kg)
(1, 'Cenoura', 1, 6, 14, NULL, 1), -- Ingredientes self-s, Unidade (un)
(1, 'Maçã', 1, 6, 30, NULL, 1), -- Ingredientes self-s, Unidade (un)
(1, 'Batata', 1, 6, 30, NULL, 1), -- Ingredientes self-s, Unidade (un)
(1, 'Abacaxi', 1, 6, 30, NULL, 1), -- Ingredientes self-s, Unidade (un)
(1, 'Contra Filé', 1, 3, 30, NULL, 1), -- Ingredientes self-s, Peso (kg)
(1, 'Feijão', 1, 3, 30, NULL, 1), -- Ingredientes self-s, Peso (kg)
(7, 'Banoffee', 1, 6, 30, NULL, 1), -- Doces por encomenda self-s, Unidade (un)
(1, 'Queijo mussarela', 1, 3, 30, NULL, 1), -- Ingredientes self-s, Peso (kg)
(7, 'Bolo de chocolate', 1, 6, 7, NULL, 1); -- Doces por encomenda, Unidade (un)

-- ==================================================================== Item audit =================================================================================
/*
INSERT INTO item_audit (descricao, dataHora, fkItem, fkUsuario) VALUES
('Entrada de Detergente', '2024-09-15 10:30:00', 1, 100), -- João Silva adicionou Detergente
('Entrada de Sacola plástica', '2024-09-16 11:00:00', 2, 101), -- Maria Souza adicionou Sacola plástica
('Entrada de Heineken garrafa', '2024-09-17 09:45:00', 3, 102), -- Carlos Pereira adicionou Cerveja
*/
-- ================================================================== Produto =============================================================================
SET @current_user_id = 101;
INSERT INTO produto (fk_item, preco, qtd_produto, qtd_produto_total, qtd_medida, ativo) VALUES
(1, 3.50, 100.0, 100.0,  0.50, 1), -- Detergente em frascos de 500ml
(2, 10.00, 50.0, 100.0,  100.00, 1), -- Pacotes com 100 sacolas plásticas
(3, 2.50, 200.0, 100.0,  0.35, 1), -- Cerveja em latas de 350ml
(4, 5.00, 150.0, 30.0,  0.20, 1), -- Chocolate em barras de 200g
(5, 20.00, 30.0, 30.0,  2.00, 1), -- Panela com capacidade de 2 litros
(6, 4.00, 80.0, 80.0, 50.00, 1), -- Pacotes com 50 copos descartáveis de 200ml
(7, 3.75, 120.0, 80.0,  0.34, 1), -- Molho de tomate em latas de 340g
(8, 10.00, 60.0, 100.0,  1.00, 1), -- Filé de frango congelado em pacotes de 1kg
(9, 12.00, 50.0, 100.0,  0.40, 1), -- Camarão em pacotes de 400g
(10, 15.00, 70.0, 100.0, 5.00, 0), -- Sacos de arroz de 5kg
(10, 14.50, 80.0, 100.0, 5.00, 1), -- Sacos de arroz de 5kg
(11, 3.00, 100.0, 100.0, 1.00, 1), -- Cenoura em pacotes de 1kg
(12, 4.00, 80.0, 100.0, 1.00, 1), -- Maçã em pacotes de 1kg
(13, 8.00, 90.0, 100.0, 0.50, 1), -- Queijo mussarela em pacotes de 500g
(14, 7.00, 50.0, 100.0, 1.00, 1), -- Sorvete em potes de 1 litro
(15, 20.00, 40.0, 100.0, 1.00, 1); -- Bolo de chocolate, unidade

-- ============================================================= Produto Audit ======================================================================
/*
INSERT INTO produto_audit (descricao, dataHora, fkUsuario, fkProduto, fkItem) VALUES
('Entrada produto OMO 500ml', NOW(), 100, 1, 1), -- João Silva adicionou Detergente OMO
('Entrada produto Sacolas Carrefour', NOW(), 101, 2, 2), -- Maria Souza adicionou Sacolas Carrefour
('Entrada produto Cerveja Skol', NOW(), 102, 3, 3), -- Carlos Pereira adicionou Cerveja Skol
('Entrada produto Choc Nestlé 200g', NOW(), 103, 4, 4), -- Ana Oliveira adicionou Chocolate Nestlé
('Entrada produto Panela Tramontina', NOW(), 104, 5, 5), -- Paulo Santos adicionou Panela Tramontina
('Entrada produto Copo Copobrás', NOW(), 105, 6, 6), -- Fernanda Lima adicionou Copo Copobrás
('Entrada produto Molho Heinz 340g', NOW(), 106, 7, 7), -- Ricardo Alves adicionou Molho Heinz
('Entrada produto Frango Seara 1kg', NOW(), 107, 8, 8), -- Beatriz Ramos adicionou Frango Seara
('Entrada produto Camarão Qualitá', NOW(), 100, 9, 9), -- João Silva adicionou Camarão Qualitá
('Entrada produto Arroz Tio João 5kg', NOW(), 101, 10, 10), -- Maria Souza adicionou Arroz Tio João
('Entrada produto Arroz Camil 5kg', NOW(), 101, 11, 10), -- Maria Souza adicionou Arroz Camil
('Entrada produto Cenoura Orgânica', NOW(), 102, 12, 11), -- Carlos Pereira adicionou Cenoura Orgânica
('Entrada produto Maçã Fuji 1kg', NOW(), 103, 13, 12), -- Ana Oliveira adicionou Maçã Fuji
('Entrada produto Queijo Tirol 500g', NOW(), 104, 14, 13), -- Paulo Santos adicionou Queijo Tirol
('Entrada produto Sorvete Kibon 1L', NOW(), 105, 15, 14), -- Fernanda Lima adicionou Sorvete Kibon
('Entrada produto Bolo Bauducco 1 un', NOW(), 106, 16, 15); -- Ricardo Alves adicionou Bolo Bauducco
*/
-- ====================================================================== Fechamento ====================================================================

-- Inserts para fechamento_estoque
/*
INSERT INTO fechamento_estoque (data_fim, data_inicio, data_fechamento, is_manual) VALUES
('2024-08-01 00:00:00', '2024-04-01 00:00:00', '2024-08-01 00:00:00', 0),
('2024-10-01 00:00:00', '2024-09-01 00:00:00', '2024-10-01 00:00:00', 1);
*/
-- ====================================================================== Fechamento Audit ====================================================================
/*
-- Inserts para fechamento_estoque_audit
INSERT INTO fechamento_estoque_audit (descricao, dataHora, fkUsuario, fkFechamentoEstoque) VALUES
('Fechamento automático', NOW(), 100, 1),
('Fechamento manual', NOW(), 101, 3),
*/
-- ============================================================ Melhorar os inserts de Interação ===============================================================
SET @current_user_id = 102;
-- Inserts para interacao_estoque
INSERT INTO interacao_estoque (fk_produto, data_hora, fk_fechamento_estoque, categoria_interacao) VALUES
(1, '2024-08-10 08:30:00', 1, 'Entrada'), -- Adicionando Detergente OMO
(3, '2024-08-15 14:45:00', 1, 'Compra de última hora'), -- Adicionando Cerveja Skol
(10, '2024-08-20 10:15:00', 1, 'Saída'), -- Retirando Arroz Tio João
(11, '2024-08-25 11:30:00', 1, 'Prazo de validade'), -- Retirando Arroz Camil
(12, '2024-08-30 09:00:00', 1, 'Entrada'); -- Adicionando Cenoura Orgânica

/*
-- Inserts para interacao_estoque_audit
INSERT INTO interacao_estoque_audit (descricao, dataHora, fkUsuario, fkInteracaoEstoque, fkProduto) VALUES
('Entrada de Detergente OMO', '2024-08-10 08:30:00', 100, 1, 1), -- João Silva adicionou Detergente OMO
('Entrada de Cerveja Skol', '2024-08-15 14:45:00', 101, 2, 3), -- Maria Souza adicionou Cerveja Skol
('Saída de Arroz Tio João', '2024-08-20 10:15:00', 102, 3, 10), -- Carlos Pereira retirou Arroz Tio João
*/
-- ============================================================================================================================================================
SET @current_user_id = 100;
INSERT INTO interacao_estoque (fk_produto, data_hora, fk_fechamento_estoque, categoria_interacao) VALUES
(1, '2024-09-01 08:00:00', 1, 'Entrada'),
(2, '2024-09-02 10:30:00', 1, 'Entrada'),
(3, '2024-09-03 14:45:00', 1, 'Entrada'),
(3, '2024-09-03 14:45:00', 1, 'Saída'),
(4, '2024-09-04 11:20:00', 1, 'Compra de última hora'),
(5, '2024-09-05 09:15:00', 1, 'Saída'),
(6, '2024-09-06 12:00:00', 1, 'Entrada'),
(7, '2024-09-07 16:30:00', 1, 'Saída'),
(8, '2024-09-08 13:20:00', 1, 'Entrada'),
(9, '2024-09-09 10:45:00', 1, 'Entrada'),
(10, '2024-09-10 09:10:00', 1, 'Entrada'),
(11, '2024-09-11 11:00:00', 1, 'Saída'),
(12, '2024-09-12 14:25:00', 1, 'Compra de última hora'),
(13, '2024-09-13 16:40:00', 1, 'Saída'),
(14, '2024-09-14 08:50:00', 1, 'Entrada'),
(15, '2024-09-14 08:50:00', 1, 'Saída'),
(15, '2024-09-15 10:15:00', 1, 'Saída'),
(16, '2024-09-16 12:30:00', 1, 'Entrada'),
(1, '2024-09-17 15:20:00', 1, 'Entrada'),
(2, '2024-09-18 13:35:00', 1, 'Saída'),
(3, '2024-09-19 09:55:00', 1, 'Compra de última hora'),
(4, '2024-09-20 11:10:00', 1, 'Compra de última hora'),
(5, '2024-09-21 10:25:00', 1, 'Saída'),
(6, '2024-09-22 12:45:00', 1, 'Compra de última hora'),
(7, '2024-09-23 14:00:00', 1, 'Compra de última hora'),
(8, '2024-09-24 16:20:00', 1, 'Saída'),
(9, '2024-09-25 08:40:00', 1, 'Compra de última hora'),
(10, '2024-09-26 09:50:00', 1, 'Prazo de validade'),
(11, '2024-09-27 11:15:00', 1, 'Compra de última hora'),
(12, '2024-09-28 13:00:00', 1, 'Compra de última hora'),
(13, '2024-09-29 15:30:00', 1, 'Prazo de validade'),
(14, '2024-09-30 14:10:00', 1, 'Compra de última hora'),
(15, '2024-09-30 16:40:00', 1, 'Saída'),
(1, '2024-10-01 08:20:00', 2, 'Entrada'),
(2, '2024-10-02 10:00:00', 2, 'Compra de última hora'),
(4, '2024-10-02 10:00:00', 2, 'Entrada'),
(6, '2024-10-02 10:00:00', 2, 'Entrada'),
(7, '2024-10-02 10:00:00', 2, 'Compra de última hora'),
(3, '2024-10-03 11:45:00', 2, 'Contaminado ou extraviado'),
(4, '2024-10-04 12:30:00', 2, 'Entrada'),
(5, '2024-10-05 14:15:00', 2, 'Saída'),
(6, '2024-10-06 15:20:00', 2, 'Entrada'),
(7, '2024-10-07 16:10:00', 2, 'Entrada'),
(8, '2024-10-08 08:55:00', 2, 'Saída'),
(9, '2024-10-09 09:40:00', 2, 'Entrada'),
(10, '2024-10-10 10:25:00', 2, 'Entrada'),
(11, '2024-10-11 11:15:00', 2, 'Saída'),
(12, '2024-10-12 13:00:00', 2, 'Entrada'),
(13, '2024-10-13 14:45:00', 2, 'Saída'),
(14, '2024-10-14 15:30:00', 2, 'Entrada'),
(15, '2024-10-15 16:20:00', 2, 'Entrada'),
(16, '2024-10-16 08:10:00', 2, 'Saída'),
(1, '2024-10-17 09:50:00', 2, 'Entrada'),
(2, '2024-10-18 10:35:00', 2, 'Entrada'),
(3, '2024-10-19 11:25:00', 2, 'Saída'),
(3, '2024-10-19 11:25:00', 2, 'Entrada');
SET @current_user_id = 101;
INSERT INTO interacao_estoque (fk_produto, data_hora, fk_fechamento_estoque, categoria_interacao) VALUES
(4, '2024-10-20 13:05:00', 2, 'Entrada'),
(5, '2024-10-21 14:40:00', 2, 'Entrada'),
(6, '2024-10-22 15:15:00', 2, 'Saída'),
(7, '2024-10-23 16:00:00', 2, 'Entrada'),
(8, '2024-10-24 08:45:00', 2, 'Contaminado ou extraviado'),
(9, '2024-10-24 08:45:00', 2, 'Não se sabe o paradeiro'),
(10, '2024-10-24 08:45:00', 2, 'Não se sabe o paradeiro');
SET @current_user_id = 102;
INSERT INTO interacao_estoque (fk_produto, data_hora, fk_fechamento_estoque, categoria_interacao) VALUES
(9, '2024-10-25 09:30:00', 2, 'Entrada'),
(10, '2024-10-26 10:20:00', 2, 'Entrada'),
(11, '2024-10-27 11:10:00', 2, 'Prazo de validade');
SET @current_user_id = 100;
