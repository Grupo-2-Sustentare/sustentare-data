DROP VIEW IF EXISTS audit_logs_view;

CREATE VIEW audit_logs_view AS
SELECT 'produto_audit' AS tabela, descricao, dataHora as data_hora, fkUsuario as fk_usuario
FROM produto_audit
UNION ALL
SELECT 'unidade_medida_audit' tabela, descricao, dataHora as data_hora, fkUsuario as fk_usuario
FROM unidade_medida_audit
UNION ALL
SELECT 'usuario_audit' AS tabela, descricao, dataHora as data_hora, responsavel as fk_usuario 
FROM usuario_audit
UNION ALL
SELECT 'categoria_item_audit' AS tabela, descricao, dataHora as data_hora, fkUsuario as fk_usuario
FROM categoria_item_audit
UNION ALL
SELECT 'item_audit' AS tabela, descricao, dataHora as data_hora, fkUsuario as fk_usuario
FROM item_audit
UNION ALL
SELECT 'interacao_estoque_audit' AS tabela, descricao, dataHora as data_hora, fkUsuario as fk_usuario
FROM interacao_estoque_audit;