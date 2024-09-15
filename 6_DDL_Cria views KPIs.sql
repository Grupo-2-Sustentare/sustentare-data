-- ===========================================
-- KPI sobre item mais antigo no sistema
CREATE OR REPLACE VIEW item_parado AS
	SELECT
	i.nome,
	i.dias_vencimento,
	DATEDIFF(now(), ie.data_hora) as dias_no_estoque,
	CASE
		WHEN DATEDIFF(now(), ie.data_hora) > i.dias_vencimento THEN True
		ELSE False
	END AS vencido,
	(DATEDIFF(now(), ie.data_hora) / dias_vencimento) * 100 as porcentagem_do_prazo,
    CASE 
		WHEN DATEDIFF(now(), ie.data_hora) - dias_vencimento > 0
			THEN DATEDIFF(now(), ie.data_hora) - dias_vencimento 
        ELSE 0
    END as dias_pos_vencimento
	FROM
	produto as p 
		join item as i on p.fk_item = i.id_item
		join interacao_estoque as ie on ie.fk_produto = p.id_produto
	WHERE 
		ie.categoria_interacao = "Adição" AND
		dias_vencimento IS NOT NULL
	ORDER BY vencido DESC, dias_no_estoque DESC;
-- ===========================================

-- ===========================================
-- Ultima adição do estoque
    CREATE VIEW ultima_adicao AS
	SELECT * FROM interacao_estoque WHERE categoria_interacao <> "Retirada" ORDER BY data_hora DESC LIMIT 1;


-- KPI sobre item com maior retirada
SELECT * FROM interacao_estoque JOIN produto ON interacao_estoque.fk_produto = produto.id_produto;


-- Vencimento
    CREATE VIEW item_vencimento AS
    SELECT * FROM item WHERE dias_vencimento = 0;
