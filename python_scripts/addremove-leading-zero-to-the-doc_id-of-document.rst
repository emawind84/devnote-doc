.. _addremove-leading-zero-to-the-doc_id-of-document:

==================================================
Add/Remove leading zero to the doc_id of document 
==================================================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex37.py``

::

	
	sqlexec('''
	
	declare
	
	    v_docid varchar2(10);
	begin
	
	for d in (
	    select * from document
	    where REGEXP_LIKE(doc_id, '(.*-)([0-9]{4}$)' )
	) loop
	
	      SELECT lpad( to_number(REGEXP_SUBSTR(D.DOC_ID, '([0-9]{4}$)') ), 5, '0' ) into v_docid from dual;
	      
	      update documentXXX set doc_id = regexp_REPLACE(doc_id, '(.*-)([0-9]{4}$)', '\1'||v_docid)
	      WHERE DOC_SEQ = D.DOC_SEQ AND OWNER_ID = D.OWNER_ID;
	      
	end loop;
	
	end
	
	;''')