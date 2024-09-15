/*=============================================*/
/*========= Interações entrada/saída por mês ==*/

create or replace view vw_interacoes_por_mes as
	select tbEntr.mes, entradas, saidas from(
		select 
		count(ie.fk_produto) as entradas, MONTHNAME(data_hora) as mes
		from interacao_estoque as ie
		where ie.categoria_interacao = "Adição"
		group by MONTHNAME(data_hora)
	) as tbEntr 
	join (
		select 
		count(ie.fk_produto) as saidas, MONTHNAME(data_hora) as mes
		from interacao_estoque as ie
		where ie.categoria_interacao = "Retirada"
		group by MONTHNAME(data_hora)
	) as tbSaid
	on tbEntr.mes = tbSaid.mes;
    
/*=============================================*/
/*========= A vencer nessa semana =============*/
#SET @inicio_semana = (
#	SELECT DATE_SUB(CURDATE(), INTERVAL (WEEKDAY(CURDATE()) + 1) DAY) AS start_of_week
#);
#select @inicio_semana;

select i.nome, count(id_produto)
from produto as p
join interacao_estoque as ie on ie.fk_produto = p.id_produto
join item as i on i.id_item = p.fk_item
where DATEDIFF(now(), ie.data_hora) >= i.dias_vencimento
group by i.nome;
