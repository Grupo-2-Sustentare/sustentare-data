DELIMITER $$ CREATE PROCEDURE sp_logs_operacoes(
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_colaboradores VARCHAR(1000)
) BEGIN
SELECT
    u.nome AS nome_colaborador,
    CASE
        WHEN ai.tipo_interacao = 'Entrada' THEN 'Entrada'
        ELSE 'Saída'
    END AS tipo_operacao,
    ai.qtd_produto AS quantidade,
    ai.data_hora AS data_operacao
FROM
    audit_interacao_estoque ai
    JOIN usuario u ON ai.fk_usuario = u.id_usuario
WHERE
    ai.data_hora BETWEEN p_data_inicio
    AND p_data_fim
    AND (
        FIND_IN_SET(u.nome, p_colaboradores) > 0
        OR p_colaboradores IS NULL
    )
ORDER BY
    ai.data_hora DESC;

END $$ DELIMITER;

DELIMITER $$ CREATE PROCEDURE sp_saldo_atual_estoque_filtrado(IN p_itens VARCHAR(255)) BEGIN
SELECT
    i.nome AS nome_item,
    SUM(
        CASE
            WHEN ie.categoria_interacao = 'Entrada' THEN p.qtd_produto
            WHEN ie.categoria_interacao = 'Saída' THEN - p.qtd_produto
            ELSE 0
        END
    ) AS saldo_atual
FROM
    interacao_estoque ie
    JOIN produto p ON ie.fk_produto = p.id_produto
    JOIN item i ON p.fk_item = i.id_item
WHERE
    (
        FIND_IN_SET(i.nome, p_itens) > 0
        OR p_itens IS NULL
    )
GROUP BY
    i.id_item;

END $$ 
DELIMITER;

DELIMITER $$ 
CREATE PROCEDURE sp_entradas_saidas_por_colaborador(
    IN p_data_inicio DATE,
    IN p_data_fim DATE,
    IN p_colaboradores VARCHAR(255)
) BEGIN
SELECT
    ie.usuario AS colaborador,
    SUM(
        CASE
            WHEN ie.categoria_interacao = 'Entrada' THEN 1
            ELSE 0
        END
    ) AS qtd_entradas,
    SUM(
        CASE
            WHEN ie.categoria_interacao = 'Saída' THEN 1
            ELSE 0
        END
    ) AS qtd_saidas
FROM
    interacao_estoque ie
WHERE
    ie.data_hora BETWEEN p_data_inicio
    AND p_data_fim
    AND (
        FIND_IN_SET(ie.usuario, p_colaboradores) > 0
        OR p_colaboradores IS NULL
    )
GROUP BY
    ie.usuario
ORDER BY
    ie.usuario;

END $$ 
