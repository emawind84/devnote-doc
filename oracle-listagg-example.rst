.. _oracle-listagg-example:

=====================================
Oracle LISTAGG Example
=====================================


.. code-block:: sql
	
	select 'found!'
	from dual
	where
	regexp_like(
	
	(select LISTAGG(doc_cd, ',') WITHIN GROUP(ORDER BY DOC_CLSS_NAME) as fbs_cds
		FROM	DOC_CLSS A
		CONNECT BY PRIOR A.DOC_CD = A.UP_DOC_CD 
		AND		A.PJT_CD    = 'GLB_PMIS'
		AND		A.DOC_DIV   = '6' 
		START WITH A.PJT_CD	= 'GLB_PMIS'
		AND		A.DOC_CD  = '0000' 
		AND		A.DOC_DIV   = '6')
	
	, replace('17782,12345', ',', '|') );
	
	
.. code-block:: sql

	<!-- fbs names list as string separated by comma -->
	SELECT LISTAGG(DOC_CLSS_NAME, ', ') WITHIN GROUP(ORDER BY DOC_CLSS_NAME)
	FROM DOC_CLSS 
	WHERE PJT_CD = #pjt_cd# AND DOC_DIV = '6' AND DOC_CD IN (
		SELECT REGEXP_SUBSTR(A.FBS_CDS,'[^,]+', 1, level) FROM DUAL
		CONNECT BY REGEXP_SUBSTR(A.FBS_CDS, '[^,]+', 1, level) IS NOT NULL
	);
	
.. seealso:: Reference:

	| http://www.techonthenet.com/oracle/regexp_like.php
	| http://www.techonthenet.com/oracle/functions/listagg.php