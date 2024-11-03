DELIMITER $$

CREATE PROCEDURE sp_auditoria_colaboradores (
    IN p_data_inicio DATETIME,
    IN p_data_fim DATETIME,
    IN p_responsaveis VARCHAR(255) -- Lista de IDs dos colaboradores responsáveis separados por vírgula
)
BEGIN
    SELECT 
        ua.responsavel AS id_responsavel,
        u.nome AS responsavel_nome,
        ua.dataHora AS data_acao,
        ua.descricao AS descricao_auditoria,
        'Usuário' AS tipo_audit,
        CONCAT('Usuário ID: ', u_alterado.id_usuario, ', Nome: ', u_alterado.nome) AS detalhes_registro
    FROM usuario_audit ua
    LEFT JOIN usuario u ON ua.responsavel = u.id_usuario
    LEFT JOIN usuario u_alterado ON ua.usuarioAlterado = u_alterado.id_usuario
    WHERE ua.dataHora BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.id_usuario, p_responsaveis) > 0 OR p_responsaveis IS NULL)

    UNION ALL

    SELECT 
        uma.fkUsuario AS id_responsavel,
        u.nome AS responsavel_nome,
        uma.dataHora AS data_acao,
        uma.descricao AS descricao_auditoria,
        'Unidade de Medida' AS tipo_audit,
        CONCAT('Unidade de Medida: ', um_alterado.nome) AS detalhes_registro
    FROM unidade_medida_audit uma
    LEFT JOIN usuario u ON uma.fkUsuario = u.id_usuario
    LEFT JOIN unidade_medida um_alterado ON uma.fkUnidadeMedida = um_alterado.id_unidade_medida
    WHERE uma.dataHora BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.id_usuario, p_responsaveis) > 0 OR p_responsaveis IS NULL)

    UNION ALL

    SELECT 
        ca.fkUsuario AS id_responsavel,
        u.nome AS responsavel_nome,
        ca.dataHora AS data_acao,
        ca.descricao AS descricao_auditoria,
        'Categoria de Item' AS tipo_audit,
        CONCAT('Categoria de Item: ', ci_alterado.nome) AS detalhes_registro
    FROM categoria_item_audit ca
    LEFT JOIN usuario u ON ca.fkUsuario = u.id_usuario
    LEFT JOIN categoria_item ci_alterado ON ca.fkCategoriaItem = ci_alterado.id_categoria_item
    WHERE ca.dataHora BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.id_usuario, p_responsaveis) > 0 OR p_responsaveis IS NULL)

    UNION ALL

    SELECT 
        ia.fkUsuario AS id_responsavel,
        u.nome AS responsavel_nome,
        ia.dataHora AS data_acao,
        ia.descricao AS descricao_auditoria,
        'Item' AS tipo_audit,
        CONCAT('Item: ', i_alterado.nome) AS detalhes_registro
    FROM item_audit ia
    LEFT JOIN usuario u ON ia.fkUsuario = u.id_usuario
    LEFT JOIN item i_alterado ON ia.fkItem = i_alterado.id_item
    WHERE ia.dataHora BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.id_usuario, p_responsaveis) > 0 OR p_responsaveis IS NULL)

    UNION ALL

    SELECT 
        pa.fkUsuario AS id_responsavel,
        u.nome AS responsavel_nome,
        pa.dataHora AS data_acao,
        pa.descricao AS descricao_auditoria,
        'Produto' AS tipo_audit,
        CONCAT('Produto Item Nome: ', i_alterado.nome, ', Quantidade: ', p_alterado.qtd_produto) AS detalhes_registro
    FROM produto_audit pa
    LEFT JOIN usuario u ON pa.fkUsuario = u.id_usuario
    LEFT JOIN produto p_alterado ON pa.fkProduto = p_alterado.id_produto
    LEFT JOIN item i_alterado ON p_alterado.fk_item = i_alterado.id_item
    WHERE pa.dataHora BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.id_usuario, p_responsaveis) > 0 OR p_responsaveis IS NULL)

    UNION ALL

    SELECT 
        iea.fkUsuario AS id_responsavel,
        u.nome AS responsavel_nome,
        iea.dataHora AS data_acao,
        iea.descricao AS descricao_auditoria,
        'Interação Estoque' AS tipo_audit,
        CONCAT('Interação Estoque Categoria: ', ie_alterado.categoria_interacao, ', Produto Item Nome: ', i_prod.nome) AS detalhes_registro
    FROM interacao_estoque_audit iea
    LEFT JOIN usuario u ON iea.fkUsuario = u.id_usuario
    LEFT JOIN interacao_estoque ie_alterado ON iea.fkInteracaoEstoque = ie_alterado.id_interacao_estoque
    LEFT JOIN produto p_inter ON ie_alterado.fk_produto = p_inter.id_produto
    LEFT JOIN item i_prod ON p_inter.fk_item = i_prod.id_item
    WHERE iea.dataHora BETWEEN p_data_inicio AND p_data_fim
      AND (FIND_IN_SET(u.id_usuario, p_responsaveis) > 0 OR p_responsaveis IS NULL)

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
        a.usuario AS colaborador,
        SUM(
            CASE
                WHEN ie.categoria_interacao IN ('Entrada', 'Compra de última hora') THEN 1
                ELSE 0
            END
        ) AS qtd_entradas,
        SUM(
            CASE
                WHEN ie.categoria_interacao IN ('Saída', 'Prazo de validade', 'Contaminado ou extraviado', 'Não se sabe o paradeiro') THEN 1
                ELSE 0
            END
        ) AS qtd_saidas
    FROM interacao_estoque ie
    JOIN interacao_estoque_audit a ON ie.id_interacao_estoque = a.fkInteracaoEstoque
    WHERE
        ie.data_hora BETWEEN p_data_inicio AND p_data_fim
        AND (
            FIND_IN_SET(a.usuario, p_colaboradores) > 0 
            OR p_colaboradores IS NULL
        )
    GROUP BY
        a.usuario
    ORDER BY
        a.usuario;
END $$ 
DELIMITER ;