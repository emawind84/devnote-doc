.. _add-organization-authorization-to-every-document-inside-the-project-set:

========================================================================
Add organization authorization to every document inside the project set 
========================================================================

.. note::
	
	.. include:: ../python-example-header.txt

``ex23.py``

::

	
	project = 'GLB_PMIS'
	
	serv = Beans.registerService;
	
	list = sql("""
	select (select entprs_cd from pmis_user where user_no = t1.regit) as entprs_cd, t1.* from doc_hist t1, doc_dgn_cat t2 where t1.doc_seq = t2.doc_seq and t2.pjt_cd = ? and t1.pjt_cd = ?
	;""", project, project);
	
	
	for doc in list:
	    print str(doc['hist_seq'])
	    #serv.addEntprsAuthorization( str(doc['hist_seq']), doc['entprs_cd'] )