USE sustentare;

SET @current_user_id = 100; -- Exemplo de Usuário que está adicionando dados no banco

INSERT INTO usuario (nome, email, senha, acesso) VALUES
('João Silva', 'joao.silva@gmail.com', 'senha123', 1),
('Maria Souza', 'maria.souza@gmail.com', 'senha456', 2),
('Carlos Pereira', 'carlos.pereira@gmail.com', 'senha789', 2),
('Ana Oliveira', 'ana.oliveira@gmail.com', 'senha101', 2),
('Paulo Santos', 'paulo.santos@gmail.com', 'senha112', 2),
('Fernanda Lima', 'fernanda.lima@gmail.com', 'senha131', 2),
('Ricardo Alves', 'ricardo.alves@gmail.com', 'senha415', 2),
('Beatriz Ramos', 'beatriz.ramos@gmail.com', 'senha161',2);

Select * from usuario;
-- ============================================================== Audit usuário =============================================================================
-- Inserts para criação dos 8 usuários
/*INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado) VALUES
('Criação de usuário', '2024-05-25 08:00:00', 100, 101),
('Criação de usuário', '2024-05-25 08:10:00', 100, 102),
('Criação de usuário', '2024-05-25 08:20:00', 100, 103),
('Criação de usuário', '2024-05-25 08:30:00', 100, 104),
('Criação de usuário', '2024-05-25 08:40:00', 100, 105),
('Criação de usuário', '2024-05-25 08:50:00', 100, 106),
('Criação de usuário', '2024-05-25 09:00:00', 100, 107);

-- Inserts para 3 registros de alteração
INSERT INTO usuario_audit (descricao, dataHora, responsavel, usuarioAlterado) VALUES
('Alteração de senha', '2024-05-26 14:30:00', 102, 103),
('Alteração de email', '2024-05-27 09:15:00', 103, 104),
('Atualização de perfil de acesso', '2024-05-28 16:45:00', 104, 105);

Select * from usuario_audit;
*/
-- ============================================================ Unidade de medida =============================================================================

INSERT INTO unidade_medida (categoria, conversao_padrao, nome, simbolo) VALUES
('Volume', 1.00, 'Litro', 'L'), -- bebidas feitas na hora
('Volume', 0.01, 'Mililitro', 'mL'), -- Sobras de bebida
('Massa', 1.00, 'Quilograma', 'kg'), -- Alimentos de consumo rápido
('Massa', 0.001, 'Grama', 'g'), -- Alimentos de consumo rápido
('Volume', 3.79, 'Galão', 'gal'), -- exemplo: galão de água
('Volume', 0.24, 'Copo', 'copo'), --  Quantidade em copos
('Volume', 1.00, 'Metro cúbico', 'm³'), -- Medida do espaço ocupado pelo produto
('Unidade', 1.00, 'Unidade', 'un'), -- Quantidade de frutas - Unidade genérica
('Unidade', 0.50, 'Metade da Prateleira', '1/2 pratel'); -- unidade genérica

Select * from unidade_medida;
-- ========================================================== Unidades de medida audit ==========================================================================
/*
INSERT INTO unidade_medida_audit (descricao, dataHora, fkUsuario, fkUnidadeMedida) VALUES
('Litro (bebidas feitas na hora)', '2024-05-25 10:00:00', 100, 1),
('Mililitro (sobras de bebida)', '2024-05-25 10:10:00', 100, 2),
('Quilograma (alimentos rápidos)', '2024-05-25 10:20:00', 100, 3),
('Grama (alimentos rápidos)', '2024-05-25 10:30:00', 100, 4),
('Galão (ex: galão de água)', '2024-05-25 10:40:00', 100, 5),
('Copo (quantidade em copos)', '2024-05-25 10:50:00', 100, 6),
('Metro cúbico (espaço ocupado)', '2024-05-25 11:00:00', 100, 7),
('Unidade (quantidade de frutas)', '2024-05-25 11:10:00', 100, 8),
('Metade da prateleira', '2024-05-25 11:20:00', 100, 9);

Select * from unidade_medida_audit;
*/
-- =================================================================== Categoria ===============================================================================

INSERT INTO categoria_item (nome) VALUES
('Produtos de limpeza'),
('Frente de caixa'),
('Bebidas'),
('Doces'),
('Utensílios de cozinha'),
('Descartáveis'),
('Condimentos avulsos'),
('Carnes'),
('Peixes e frutos do mar'),
('Grãos e cereais'),
('Verduras e legumes'),
('Frutas'),
('Laticínios'),
('Congelados'), -- Criado pelo usuário -> audit
('Sobremesas'); -- Criado pelo usuário -> audit

Select * from categoria_item;
-- =============================================================== Categoria Audit ================================================================================
/*
INSERT INTO categoria_item_audit (descricao, dataHora, fkCategoriaItem, fkUsuario) VALUES
('Criação da categoria: Congelados', '2024-05-25 10:00:00', 14, 100),
('Criação da categoria: Sobremesas', '2024-05-25 10:10:00', 15, 100);

Select * from categoria_item_audit;
*/
-- ==================================================================== Item =====================================================================================

INSERT INTO item (fk_categoria_item, nome, perecivel, fk_unidade_medida, dias_vencimento) VALUES
(1, 'Detergente', 0, 9, NULL), -- Produtos de limpeza, Comprimento (1/2 pratel)
(2, 'Sacola plástica', 0, 8, NULL), -- Frente de caixa, Unidade (un)
(3, 'Cerveja', 1, 2, 365), -- Bebidas, Volume (mL)
(4, 'Chocolate', 1, 4, 180), -- Doces, Peso (g)
(5, 'Panela', 0, 8, NULL), -- Utensílios de cozinha, Unidade (un)
(6, 'Copo descartável', 0, 8, NULL), -- Descartáveis, Unidade (un)
(7, 'Molho de tomate', 1, 1, 720), -- Molhos e temperos, Volume (L)
(8, 'Filé de frango', 1, 3, 5), -- Carnes, Peso (kg)
(9, 'Camarão', 1, 4, 3), -- Peixes e frutos do mar, Peso (g)
(10, 'Arroz', 0, 3, 365), -- Grãos e cereais, Peso (kg)
(11, 'Cenoura', 1, 8, 14), -- Verduras e legumes, Unidade (un)
(12, 'Maçã', 1, 8, 30), -- Frutas, Unidade (un)
(13, 'Queijo', 1, 3, 30), -- Laticínios, Peso (kg)
(14, 'Sorvete', 1, 6, 180), -- Congelados, Volume (copo)
(15, 'Bolo de chocolate', 1, 8, 7); -- Sobremesas, Unidade (un)

Select * from item;

-- ==================================================================== Item audit =================================================================================
/*
INSERT INTO item_audit (descricao, dataHora, fkItem, fkUsuario) VALUES
('Adição de Detergente', '2024-01-15 10:30:00', 1, 100), -- João Silva adicionou Detergente
('Adição de Sacola plástica', '2024-01-16 11:00:00', 2, 101), -- Maria Souza adicionou Sacola plástica
('Adição de Cerveja', '2024-01-17 09:45:00', 3, 102), -- Carlos Pereira adicionou Cerveja
('Adição de Chocolate', '2024-01-18 14:20:00', 4, 103), -- Ana Oliveira adicionou Chocolate
('Adição de Panela', '2024-01-19 16:55:00', 5, 104), -- Paulo Santos adicionou Panela
('Adição de Copo descartável', NOW(), 6, 105), -- Fernanda Lima adicionou Copo descartável
('Adição de Molho de tomate', NOW(), 7, 106), -- Ricardo Alves adicionou Molho de tomate
('Adição de Filé de frango', NOW(), 8, 107), -- Beatriz Ramos adicionou Filé de frango
('Adição de Camarão', NOW(), 9, 100), -- João Silva adicionou Camarão
('Adição de Arroz', NOW(), 10, 101), -- Maria Souza adicionou Arroz
('Adição de Cenoura', NOW(), 11, 102), -- Carlos Pereira adicionou Cenoura
('Adição de Maçã', NOW(), 12, 103), -- Ana Oliveira adicionou Maçã
('Adição de Queijo', NOW(), 13, 104), -- Paulo Santos adicionou Queijo
('Adição de Sorvete', NOW(), 14, 105), -- Fernanda Lima adicionou Sorvete
('Adição de Bolo de chocolate', NOW(), 15, 106); -- Ricardo Alves adicionou Bolo de chocolate

Select * from item_audit;
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

Select * from produto;

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

Select * from produto_audit;
*/
-- ====================================================================== Fechamento ====================================================================

-- Inserts para fechamento_estoque
INSERT INTO fechamento_estoque (data_fim, data_inicio, data_fechamento, is_manual) VALUES
('2024-05-01 00:00:00', '2024-04-01 00:00:00', '2024-05-01 00:00:00', 0),
('2024-06-01 00:00:00', '2024-05-01 00:00:00', '2024-06-01 00:00:00', 0),
('2024-07-01 00:00:00', '2024-06-01 00:00:00', '2024-07-01 00:00:00', 1),
('2024-08-01 00:00:00', '2024-07-01 00:00:00', '2024-08-01 00:00:00', 1),
('2024-09-01 00:00:00', '2024-08-01 00:00:00', '2024-09-01 00:00:00', 1);

Select * from fechamento_estoque;
-- ====================================================================== Fechamento Audit ====================================================================
/*
-- Inserts para fechamento_estoque_audit
INSERT INTO fechamento_estoque_audit (descricao, dataHora, fkUsuario, fkFechamentoEstoque) VALUES
('Fechamento automático', NOW(), 100, 1),
('Fechamento automático', NOW(), 101, 2),
('Fechamento manual', NOW(), 102, 3),
('Fechamento manual', NOW(), 103, 4),
('Fechamento manual', NOW(), 104, 5);

Select * from fechamento_estoque_audit;
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
('Retirada de Arroz Camil', '2024-05-25 11:30:00', 103, 4, 11), -- Ana Oliveira retirou Arroz Camil
('Adição de Cenoura Orgânica', '2024-05-30 09:00:00', 104, 5, 12); -- Paulo Santos adicionou Cenoura Orgânica
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
