DROP VIEW IF EXISTS audit_logs_view;

CREATE VIEW audit_logs_view AS
SELECT uuid() as 'id', 'item_audit' AS tabela, descricao, data_hora, fk_usuario
FROM item_audit
UNION ALL
SELECT uuid() as 'id', 'interacao_estoque_audit' AS tabela, descricao, data_hora, fk_usuario
FROM interacao_estoque_audit;	