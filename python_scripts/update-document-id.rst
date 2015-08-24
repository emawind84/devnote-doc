.. _update-document-id:

===================
Update document ID 
===================


``ex31.py``

::

	# CAUTION! This script will create additional id
	# check the table that will store the ids before running the script
	
	from pmis.common.util import CustomHashMap
	
	docServ = Beans.documentService
	
	list = sql('''
	select doc_seq, owner_id
	from document t1
	where pjt_cd = 'CCE_TEST' 
	and doc_status in ('IDLE', 'SENT') 
	and doc_id is not null
	and (select entprs_cd from pmis_user where user_no = t1.entry_id) != '506-81-02280'
	order by doc_seq asc;
	''')
	
	for _d in list:
	    dparam = CustomHashMap();
	    dparam.putAll(_d)
	    
	    d = docServ.loadDocument( dparam.get('DOC_SEQ'), dparam.get('OWNER_ID') )
	    
	    docid = docServ.getNextDocId( d )
	    
	    d.put( 'doc_id', docid )
	    print 'update: ' + d.get('doc_seq')
	    
	    rlist = sql('''
	    select doc_seq, owner_id
	    from document 
	    where 1=1
	    and doc_seq = ?
	    order by doc_seq asc;
	    ''', dparam.get('DOC_SEQ'))
	    
	    print 'updating: ' + d.get('doc_seq')
	    for _dd in rlist:
	        dparam = CustomHashMap();
	        dparam.putAll(_dd)
	    
	        dd = docServ.loadDocument( dparam.get('DOC_SEQ'), dparam.get('OWNER_ID') )
	        dd.put('doc_id', docid)        
	        print '  > user: ' + dd.get('owner_id')
	        
	        # remove the comment to save the document
	        #docServ.updateDocument(dd.get('doc_seq'), dd.get('owner_id'), dd)
	        
	print 'Script terminated!'