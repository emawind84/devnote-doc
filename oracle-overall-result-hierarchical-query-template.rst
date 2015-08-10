.. _oracle-overall-result-hierarchical-query-template:

=================================================
Oracle Overall Result Hierarchical Query Template
=================================================


WITH     universe     AS
(
     SELECT     
		cost_cd
		,up_cost_cd
		,cash
		,connect_by_isleaf leaf
		,ROWNUM AS r_num
     FROM     (
                 -- query
     )
     START WITH up_cost_cd = '!0!'
     CONNECT BY up_cost_cd = PRIOR cost_cd
     order siblings by seq
)
,     bottom_up     AS
(
     SELECT     
		u.*
		, '0' || SYS_CONNECT_BY_PATH ( TO_CHAR (cash), ' + '  ) as cash_string
     FROM     universe     u
     START WITH     cash     IS NOT NULL
     CONNECT BY     cost_cd     = PRIOR up_cost_cd
)

-- FINAL QUERY
SELECT
    r_num
	,cost_cd
	,up_cost_cd
	,sum(dbms_aw.eval_number(cash_string)) as cash
FROM       bottom_up
group by cost_cd, up_cost_cd, r_num

ORDER BY  r_num;