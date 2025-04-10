DELIMITER $$

CREATE PROCEDURE sp_auditoria_colaboradores(
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_responsaveis VARCHAR(255)
)
BEGIN
    SELECT 
        ia.fk_usuario AS id_responsavel,
        u.nome AS responsavel_nome,
        ia.data_hora AS data_acao,
        ia.descricao AS descricao_auditoria,
        'Item' AS tipo_audit,
        CONCAT('Item: ', i.nome) AS detalhes_registro
    FROM item_audit ia
    LEFT JOIN usuario u ON ia.fk_usuario = u.id_usuario
    LEFT JOIN item i ON ia.fk_item = i.id_item
    WHERE DATE(ia.data_hora) BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.nome, p_responsaveis) > 0 OR p_responsaveis IS NULL)

    UNION ALL

    SELECT 
        iea.fk_usuario AS id_responsavel,
        u.nome AS responsavel_nome,
        iea.data_hora AS data_acao,
        iea.descricao AS descricao_auditoria,
        'Interação Estoque' AS tipo_audit,
        CONCAT('Categoria Interação: ', ie.categoria_interacao, ', Item: ', i.nome) AS detalhes_registro
    FROM interacao_estoque_audit iea
    LEFT JOIN usuario u ON iea.fk_usuario = u.id_usuario
    LEFT JOIN interacao_estoque ie ON iea.fk_interacao_estoque = ie.id_interacao_estoque
    LEFT JOIN produto p ON iea.fk_produto = p.id_produto
    LEFT JOIN item i ON p.fk_item = i.id_item
    WHERE DATE(iea.data_hora) BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.nome, p_responsaveis) > 0 OR p_responsaveis IS NULL)

    ORDER BY data_acao DESC;
END $$

DELIMITER ;


DELIMITER $$

CREATE PROCEDURE sp_entradas_saidas_por_colaborador(
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_colaboradores VARCHAR(255)
)
BEGIN
    SELECT
        u.nome AS colaborador,
        SUM(
            CASE
                WHEN ie.categoria_interacao IN ('Entrada', 'Compra de última hora') THEN 1
                ELSE 0
            END
        ) AS qtd_entradas,
        SUM(
            CASE
                WHEN ie.categoria_interacao IN 
                ('Uso no buffet ou vendas individuais (regular)', 'Ajuste por marcação anterior errada', 
                 'Passou do prazo de validade', 'Foi contaminado ou extraviado', 'Não se sabe o paradeiro') 
                THEN 1 ELSE 0
            END
        ) AS qtd_saidas
    FROM interacao_estoque ie
    JOIN interacao_estoque_audit a ON ie.id_interacao_estoque = a.fk_interacao_estoque
    JOIN usuario u ON a.fk_usuario = u.id_usuario
    WHERE DATE(ie.data_hora) BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.nome, p_colaboradores) > 0 OR p_colaboradores IS NULL)
    GROUP BY u.nome
    ORDER BY u.nome;
END $$

DELIMITER ;
