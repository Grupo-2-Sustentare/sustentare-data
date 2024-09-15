USE sustentare;

INSERT INTO usuario (nome, email, senha, acesso) VALUES
('Antônio', 'antonio@email.com', '123', 1),
('Maria Souza', 'maria.souza@gmail.com', 'senha456', 2),
('Carlos Pereira', 'carlos.pereira@gmail.com', 'senha789', 2);
-- ============================================================== Audit usuário =============================================================================
-- Inserts para criação dos 8 usuários
/*INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado) VALUES
('Criação de usuário', '2024-05-25 08:00:00', 100, 101),
('Criação de usuário', '2024-05-25 08:10:00', 100, 102),
('Criação de usuário', '2024-05-25 08:20:00', 100, 103),

-- Inserts para 3 registros de alteração
INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado) VALUES
('Alteração de senha', '2024-05-26 14:30:00', 100, 100),
('Alteração de email', '2024-05-27 09:15:00', 100, 101),
('Atualização de perfil de acesso', '2024-05-28 16:45:00', 100, 102);
*/
-- ============================================================ Unidade de medida =============================================================================

INSERT INTO unidade_medida (categoria, conversao_padrao, nome, simbolo) VALUES
('Volume', 1.00, 'Litro', 'L'),
('Volume', 0.01, 'Mililitro', 'mL'),
('Massa', 1.00, 'Quilograma', 'kg'),
('Massa', 0.001, 'Grama', 'g'),
('Volume', 3.8, 'Galões', 'gal'),
('Genérica', 1.00, 'Unidade Genérica', 'un'),
('Genérica', 2.00, 'Kit refrigerante', 'kit');

-- ========================================================== Unidades de medida audit ==========================================================================
/*
INSERT INTO unidade_medida_audit (descricao, dataHora, fkUsuario, fkUnidadeMedida) VALUES
('Litro', '2024-05-25 10:00:00', 100, 1),
('Mililitro', '2024-05-25 10:10:00', 100, 2),
('Quilograma', '2024-05-25 10:20:00', 100, 3),
('Grama', '2024-05-25 10:30:00', 100, 4),
('Unidade', '2024-05-25 11:10:00', 100, 8),
*/
-- =================================================================== Categoria ===============================================================================

INSERT INTO categoria_item (nome) VALUES
('Ingredientes self-service'),
('Bebidas'),
('Descartáveis'),
('Produtos de limpeza'),
('Frente de caixa'),
('Condimentos'),
('Doces por encomenda'); -- Criado pelo usuário -> audit

-- =============================================================== Categoria Audit ================================================================================
/*
INSERT INTO categoria_item_audit (descricao, dataHora, fkCategoriaItem, fkUsuario) VALUES
('Criação da categoria: Doces por encomenda', '2024-05-25 10:00:00', 14, 100);
*/
-- ==================================================================== Item =====================================================================================

INSERT INTO item (fk_categoria_item, nome, perecivel, fk_unidade_medida, dias_vencimento) VALUES
(4, 'Detergente', 6, 6, NULL), -- Produtos de limpeza, Unidade (un)
(3, 'Sacola plástica', 6, 6, NULL), -- Descartáveis, Unidade (un)
(2, 'Brahma duplo malte lata', 1, 6, 30), -- Bebidas, Unidade (un)
(2, 'Coca 300', 1, 6, 30), -- Bebidas, Unidade (un)
(2, 'Coca Zero 300', 1, 6, 30), -- Bebidas,Unidade (un)
(2, 'Heineken garrafa', 1, 6, 180), -- Bebidas, Unidade (un)
(5, 'Chocolate crunch', 1, 4, 360), -- Frente de caixa, Peso (g)
(1, 'Molho de tomate', 1, 1, 720), -- Ingredientes self-s, Volume (L)
(1, 'Filé de frango', 1, 3, 5), -- Ingredientes self-s, Peso (kg)
(1, 'Camarão', 1, 4, 3), -- Ingredientes self-s, Peso (g)
(1, 'Arroz', 0, 3, 365), -- Ingredientes self-s, Peso (kg)
(1, 'Cenoura', 1, 6, 14), -- Ingredientes self-s, Unidade (un)
(1, 'Maçã', 1, 6, 30), -- Ingredientes self-s, Unidade (un)
(1, 'Batata', 1, 6, 30), -- Ingredientes self-s, Unidade (un)
(1, 'Abacaxi', 1, 6, 30), -- Ingredientes self-s, Unidade (un)
(1, 'Contra Filé', 1, 3, 30), -- Ingredientes self-s, Peso (kg)
(1, 'Feijão', 1, 3, 30), -- Ingredientes self-s, Peso (kg)
(7, 'Banoffee', 1, 6, 30), -- Doces por encomenda self-s, Unidade (un)
(1, 'Queijo mussarela', 1, 3, 30), -- Ingredientes self-s, Peso (kg)
(7, 'Bolo de chocolate', 1, 6, 7); -- Doces por encomenda, Unidade (un)

-- ==================================================================== Item audit =================================================================================
/*
INSERT INTO item_audit (descricao, dataHora, fkItem, fkUsuario) VALUES
('Adição de Detergente', '2024-01-15 10:30:00', 1, 100), -- João Silva adicionou Detergente
('Adição de Sacola plástica', '2024-01-16 11:00:00', 2, 101), -- Maria Souza adicionou Sacola plástica
('Adição de Heineken garrafa', '2024-01-17 09:45:00', 3, 102), -- Carlos Pereira adicionou Cerveja
*/
-- ================================================================== Produto =============================================================================

INSERT INTO produto (fk_item, nome, preco, qtd_produto, qtd_medida) VALUES
(1, 'Detergente Líquido OMO 500ml', 3.50, 100, 0.50), -- Detergente em frascos de 500ml
(2, 'Pacote de Sacolas Plásticas Carrefour (100 un)', 10.00, 50, 100.00), -- Pacotes com 100 sacolas plásticas
(3, 'Cerveja Lata Skol 350ml', 2.50, 200, 0.35), -- Cerveja em latas de 350ml
(4, 'Chocolate Barra Nestlé 200g', 5.00, 150, 0.20), -- Chocolate em barras de 200g
(5, 'Panela Tramontina 2L', 20.00, 30, 2.00), -- Panela com capacidade de 2 litros
(6, 'Copo Descartável Copobrás 200ml (pacote com 50)', 4.00, 80, 50.00), -- Pacotes com 50 copos descartáveis de 200ml
(7, 'Molho de Tomate Heinz 340g', 3.75, 120, 0.34), -- Molho de tomate em latas de 340g
(8, 'Filé de Frango Seara 1kg', 10.00, 60, 1.00), -- Filé de frango congelado em pacotes de 1kg
(9, 'Camarão Qualitá 400g', 12.00, 50, 0.40), -- Camarão em pacotes de 400g
(10, 'Arroz Tio João 5kg', 15.00, 70, 5.00), -- Sacos de arroz de 5kg
(10, 'Arroz Camil 5kg', 14.50, 80, 5.00), -- Sacos de arroz de 5kg
(11, 'Cenoura Orgânica 1kg', 3.00, 100, 1.00), -- Cenoura em pacotes de 1kg
(12, 'Maçã Fuji 1kg', 4.00, 80, 1.00), -- Maçã em pacotes de 1kg
(13, 'Queijo Mussarela Tirol 500g', 8.00, 90, 0.50), -- Queijo mussarela em pacotes de 500g
(14, 'Sorvete Kibon 1L', 7.00, 50, 1.00), -- Sorvete em potes de 1 litro
(15, 'Bolo de Chocolate Bauducco 1 un', 20.00, 40, 1.00); -- Bolo de chocolate, unidade

-- ============================================================= Produto Audit ======================================================================
/*
INSERT INTO produto_audit (descricao, dataHora, fkUsuario, fkProduto, fkItem) VALUES
('Adição produto OMO 500ml', NOW(), 100, 1, 1), -- João Silva adicionou Detergente OMO
('Adição produto Sacolas Carrefour', NOW(), 101, 2, 2), -- Maria Souza adicionou Sacolas Carrefour
('Adição produto Cerveja Skol', NOW(), 102, 3, 3), -- Carlos Pereira adicionou Cerveja Skol
('Adição produto Choc Nestlé 200g', NOW(), 103, 4, 4), -- Ana Oliveira adicionou Chocolate Nestlé
('Adição produto Panela Tramontina', NOW(), 104, 5, 5), -- Paulo Santos adicionou Panela Tramontina
('Adição produto Copo Copobrás', NOW(), 105, 6, 6), -- Fernanda Lima adicionou Copo Copobrás
('Adição produto Molho Heinz 340g', NOW(), 106, 7, 7), -- Ricardo Alves adicionou Molho Heinz
('Adição produto Frango Seara 1kg', NOW(), 107, 8, 8), -- Beatriz Ramos adicionou Frango Seara
('Adição produto Camarão Qualitá', NOW(), 100, 9, 9), -- João Silva adicionou Camarão Qualitá
('Adição produto Arroz Tio João 5kg', NOW(), 101, 10, 10), -- Maria Souza adicionou Arroz Tio João
('Adição produto Arroz Camil 5kg', NOW(), 101, 11, 10), -- Maria Souza adicionou Arroz Camil
('Adição produto Cenoura Orgânica', NOW(), 102, 12, 11), -- Carlos Pereira adicionou Cenoura Orgânica
('Adição produto Maçã Fuji 1kg', NOW(), 103, 13, 12), -- Ana Oliveira adicionou Maçã Fuji
('Adição produto Queijo Tirol 500g', NOW(), 104, 14, 13), -- Paulo Santos adicionou Queijo Tirol
('Adição produto Sorvete Kibon 1L', NOW(), 105, 15, 14), -- Fernanda Lima adicionou Sorvete Kibon
('Adição produto Bolo Bauducco 1 un', NOW(), 106, 16, 15); -- Ricardo Alves adicionou Bolo Bauducco
*/
-- ====================================================================== Fechamento ====================================================================

-- Inserts para fechamento_estoque
/*
INSERT INTO fechamento_estoque (data_fim, data_inicio, data_fechamento, is_manual) VALUES
('2024-05-01 00:00:00', '2024-04-01 00:00:00', '2024-05-01 00:00:00', 0),
('2024-09-01 00:00:00', '2024-08-01 00:00:00', '2024-09-01 00:00:00', 1);
*/
-- ====================================================================== Fechamento Audit ====================================================================
/*
-- Inserts para fechamento_estoque_audit
INSERT INTO fechamento_estoque_audit (descricao, dataHora, fkUsuario, fkFechamentoEstoque) VALUES
('Fechamento automático', NOW(), 100, 1),
('Fechamento manual', NOW(), 101, 3),
*/
-- ============================================================ Melhorar os inserts de Interação ===============================================================

-- Inserts para interacao_estoque
INSERT INTO interacao_estoque (fk_produto, data_hora, fk_fechamento_estoque, categoria_interacao) VALUES
(1, '2024-05-10 08:30:00', 1, 'Adição'), -- Adicionando Detergente OMO
(3, '2024-05-15 14:45:00', 1, 'Adição'), -- Adicionando Cerveja Skol
(10, '2024-05-20 10:15:00', 1, 'Retirada'), -- Retirando Arroz Tio João
(11, '2024-05-25 11:30:00', 1, 'Retirada'), -- Retirando Arroz Camil
(12, '2024-05-30 09:00:00', 1, 'Adição'); -- Adicionando Cenoura Orgânica

/*
-- Inserts para interacao_estoque_audit
INSERT INTO interacao_estoque_audit (descricao, dataHora, fkUsuario, fkInteracaoEstoque, fkProduto) VALUES
('Adição de Detergente OMO', '2024-05-10 08:30:00', 100, 1, 1), -- João Silva adicionou Detergente OMO
('Adição de Cerveja Skol', '2024-05-15 14:45:00', 101, 2, 3), -- Maria Souza adicionou Cerveja Skol
('Retirada de Arroz Tio João', '2024-05-20 10:15:00', 102, 3, 10), -- Carlos Pereira retirou Arroz Tio João
*/
-- ============================================================================================================================================================
INSERT INTO interacao_estoque (fk_produto, data_hora, fk_fechamento_estoque, categoria_interacao) VALUES
(1, '2024-01-01 08:00:00', 1, 'Adição'),
(2, '2024-01-02 10:30:00', 1, 'Adição'),
(3, '2024-01-03 14:45:00', 1, 'Retirada'),
(4, '2024-01-04 11:20:00', 1, 'Adição'),
(5, '2024-01-05 09:15:00', 1, 'Retirada'),
(6, '2024-01-06 12:00:00', 1, 'Adição'),
(7, '2024-01-07 16:30:00', 1, 'Retirada'),
(8, '2024-01-08 13:20:00', 1, 'Adição'),
(9, '2024-01-09 10:45:00', 1, 'Adição'),
(10, '2024-01-10 09:10:00', 1, 'Adição'),
(11, '2024-01-11 11:00:00', 1, 'Retirada'),
(12, '2024-01-12 14:25:00', 1, 'Adição'),
(13, '2024-01-13 16:40:00', 1, 'Retirada'),
(14, '2024-01-14 08:50:00', 1, 'Adição'),
(15, '2024-01-15 10:15:00', 1, 'Retirada'),
(16, '2024-01-16 12:30:00', 1, 'Adição'),
(1, '2024-01-17 15:20:00', 1, 'Adição'),
(2, '2024-01-18 13:35:00', 1, 'Retirada'),
(3, '2024-01-19 09:55:00', 1, 'Adição'),
(4, '2024-01-20 11:10:00', 1, 'Adição'),
(5, '2024-01-21 10:25:00', 1, 'Retirada'),
(6, '2024-01-22 12:45:00', 1, 'Adição'),
(7, '2024-01-23 14:00:00', 1, 'Adição'),
(8, '2024-01-24 16:20:00', 1, 'Retirada'),
(9, '2024-01-25 08:40:00', 1, 'Adição'),
(10, '2024-01-26 09:50:00', 1, 'Retirada'),
(11, '2024-01-27 11:15:00', 1, 'Adição'),
(12, '2024-01-28 13:00:00', 1, 'Adição'),
(13, '2024-01-29 15:30:00', 1, 'Retirada'),
(14, '2024-01-30 14:10:00', 1, 'Adição'),
(15, '2024-01-31 16:40:00', 1, 'Retirada'),
(1, '2024-02-01 08:20:00', 2, 'Adição'),
(2, '2024-02-02 10:00:00', 2, 'Adição'),
(3, '2024-02-03 11:45:00', 2, 'Retirada'),
(4, '2024-02-04 12:30:00', 2, 'Adição'),
(5, '2024-02-05 14:15:00', 2, 'Retirada'),
(6, '2024-02-06 15:20:00', 2, 'Adição'),
(7, '2024-02-07 16:10:00', 2, 'Adição'),
(8, '2024-02-08 08:55:00', 2, 'Retirada'),
(9, '2024-02-09 09:40:00', 2, 'Adição'),
(10, '2024-02-10 10:25:00', 2, 'Adição'),
(11, '2024-02-11 11:15:00', 2, 'Retirada'),
(12, '2024-02-12 13:00:00', 2, 'Adição'),
(13, '2024-02-13 14:45:00', 2, 'Retirada'),
(14, '2024-02-14 15:30:00', 2, 'Adição'),
(15, '2024-02-15 16:20:00', 2, 'Adição'),
(16, '2024-02-16 08:10:00', 2, 'Retirada'),
(1, '2024-02-17 09:50:00', 2, 'Adição'),
(2, '2024-02-18 10:35:00', 2, 'Adição'),
(3, '2024-02-19 11:25:00', 2, 'Retirada'),
(4, '2024-02-20 13:05:00', 2, 'Adição'),
(5, '2024-02-21 14:40:00', 2, 'Adição'),
(6, '2024-02-22 15:15:00', 2, 'Retirada'),
(7, '2024-02-23 16:00:00', 2, 'Adição'),
(8, '2024-02-24 08:45:00', 2, 'Retirada'),
(9, '2024-02-25 09:30:00', 2, 'Adição'),
(10, '2024-02-26 10:20:00', 2, 'Adição'),
(11, '2024-02-27 11:10:00', 2, 'Retirada');
