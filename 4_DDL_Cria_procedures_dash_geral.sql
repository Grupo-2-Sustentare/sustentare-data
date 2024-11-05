DELIMITER $$

CREATE PROCEDURE sp_valor_entradas_saidas_mes (
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_categorias VARCHAR(255),
    IN p_itens VARCHAR(255)
)
BEGIN
    SELECT
        i.data_hora AS data,
        SUM(CASE WHEN i.categoria_interacao = 'Entrada' THEN p.preco * p.qtd_produto ELSE 0 END) AS valor_entradas,
        SUM(CASE WHEN i.categoria_interacao <> 'Entrada' THEN p.preco * p.qtd_produto ELSE 0 END) AS valor_saidas
    FROM
        interacao_estoque i
    JOIN produto p ON i.fk_produto = p.id_produto
    JOIN item it ON p.fk_item = it.id_item
    JOIN categoria_item c ON it.fk_categoria_item = c.id_categoria_item
    WHERE
        i.data_hora BETWEEN p_data_inicio AND p_data_fim
        AND (FIND_IN_SET(c.nome, p_categorias) > 0 OR p_categorias IS NULL)
        AND (FIND_IN_SET(it.nome, p_itens) > 0 OR p_itens IS NULL)
    GROUP BY i.data_hora ORDER BY i.data_hora;
END $$

DELIMITER $$

CREATE PROCEDURE sp_perdas_por_mes (
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_categorias VARCHAR(255),
    IN p_itens VARCHAR(255)
)
BEGIN
    SELECT
        i.categoria_interacao AS tipo_perda,
        SUM(p.qtd_produto) AS qtd_perda
    FROM
        interacao_estoque i
    JOIN produto p ON i.fk_produto = p.id_produto
    JOIN item it ON p.fk_item = it.id_item
    JOIN categoria_item c ON it.fk_categoria_item = c.id_categoria_item
    WHERE
        i.data_hora BETWEEN p_data_inicio AND p_data_fim
        AND (FIND_IN_SET(c.nome, p_categorias) > 0 OR p_categorias IS NULL)
        AND (FIND_IN_SET(it.nome, p_itens) > 0 OR p_itens IS NULL)
        AND i.categoria_interacao IN ('Prazo de validade', 'Contaminado ou extraviado', 'Não se sabe o paradeiro')
    GROUP BY i.categoria_interacao;
END $$

DELIMITER $$

CREATE PROCEDURE sp_compras_regulares_vs_nao_planejadas (
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_categorias VARCHAR(255),
    IN p_itens VARCHAR(255)
)
BEGIN
    SELECT
        i.categoria_interacao AS tipo_compra,
        COUNT(i.id_interacao_estoque) AS qtd_compras
    FROM
        interacao_estoque i
    JOIN produto p ON i.fk_produto = p.id_produto
    JOIN item it ON p.fk_item = it.id_item
    JOIN categoria_item c ON it.fk_categoria_item = c.id_categoria_item
    WHERE
        i.data_hora BETWEEN p_data_inicio AND p_data_fim
        AND i.categoria_interacao IN ('Entrada', 'Compra de última hora')
        AND (FIND_IN_SET(c.nome, p_categorias) > 0 OR p_categorias IS NULL)
        AND (FIND_IN_SET(it.nome, p_itens) > 0 OR p_itens IS NULL)
    GROUP BY tipo_compra;
END $$

DELIMITER $$
CREATE PROCEDURE sp_kpi_perdas(
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_categorias VARCHAR(255),
    IN p_itens VARCHAR(255),
    OUT total_perdas INT,
    OUT situacao VARCHAR(10)
)
BEGIN
    SELECT COUNT(*) INTO total_perdas
    FROM
        interacao_estoque ie
    JOIN item i ON ie.fk_produto = i.id_item
    JOIN categoria_item ci ON i.fk_categoria_item = ci.id_categoria_item
    WHERE
        ie.categoria_interacao IN ('Prazo de validade', 'Contaminado ou extraviado', 'Não se sabe o paradeiro')
        AND ie.data_hora BETWEEN p_data_inicio AND p_data_fim
        AND (FIND_IN_SET(ci.nome, p_categorias) > 0 OR p_categorias IS NULL)
        AND (FIND_IN_SET(i.nome, p_itens) > 0 OR p_itens IS NULL);

    IF total_perdas <= 1 THEN
        SET situacao = 'Bom';
    ELSEIF total_perdas BETWEEN 2 AND 3 THEN
        SET situacao = 'Mediano';
    ELSE
        SET situacao = 'Ruim';
    END IF;
END $$

DELIMITER $$

CREATE PROCEDURE sp_kpi_compras_nao_planejadas(
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_categorias VARCHAR(255),
    IN p_itens VARCHAR(255),
    OUT total_compras_nao_planejadas INT,
    OUT situacao VARCHAR(10)
)
BEGIN
    SELECT COUNT(*) INTO total_compras_nao_planejadas
    FROM
        interacao_estoque ie
    JOIN produto p ON ie.fk_produto = p.id_produto
    JOIN item i ON p.fk_item = i.id_item
    JOIN categoria_item ci ON i.fk_categoria_item = ci.id_categoria_item
    WHERE
        ie.categoria_interacao = 'Compra de última hora'
        AND ie.data_hora BETWEEN p_data_inicio AND p_data_fim
        AND (FIND_IN_SET(ci.nome, p_categorias) > 0 OR p_categorias IS NULL)
        AND (FIND_IN_SET(i.nome, p_itens) > 0 OR p_itens IS NULL);

    IF total_compras_nao_planejadas <= 9 THEN
        SET situacao = 'Bom';
    ELSEIF total_compras_nao_planejadas BETWEEN 10 AND 19 THEN
        SET situacao = 'Mediano';
    ELSE
        SET situacao = 'Ruim';
    END IF;
END $$

DELIMITER $$

CREATE PROCEDURE sp_kpi_valor_total_entradas(
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_categorias VARCHAR(255),
    IN p_itens VARCHAR(255),
    OUT total_entradas DECIMAL(12, 2)
)
BEGIN
    SELECT SUM(p.qtd_produto * p.preco) INTO total_entradas
    FROM 
        interacao_estoque ie
    JOIN 
        produto p ON ie.fk_produto = p.id_produto
    JOIN 
        item i ON p.fk_item = i.id_item
    JOIN 
        categoria_item ci ON i.fk_categoria_item = ci.id_categoria_item
    WHERE 
        ie.categoria_interacao = 'Entrada'
        AND ie.data_hora BETWEEN p_data_inicio AND p_data_fim
        AND (FIND_IN_SET(ci.nome, p_categorias) > 0 OR p_categorias IS NULL)
        AND (FIND_IN_SET(i.nome, p_itens) > 0 OR p_itens IS NULL);
END $$

DELIMITER ;
