.. _check-edms-file-existance:

==========================
Check EDMS File Existance
==========================



.. note::

    .. include:: ../python-example-header.txt

filename => ``ex40.py``

::
    
    from java.io import File
    
    serv = Beans.documentService
    coreDao = ApplicationContext.get('coreDao')
    
    list = sql('''
    select distinct file_seq from comm_attch_file where REG_DATE > sysdate - 10;
    ''')
    
    if list.size() == 0:
        print 'Nothing found!'
    
    for doc in list:
        
        param = HashMap()
        param.put('file_seq', str(doc['FILE_SEQ']))
    
        list = coreDao.getList('core.sql.commAttchFileDetail', param)
        for file in list:
            filepath = PmisConfig.get("edms.PathRoot") + str(file["FILEPATH"])
            f = File( filepath )
            if not f.exists():
                print(u''.join( file["title"] ).encode('utf-8'), doc['doc_id'], doc['DOC_TYPE'], doc['file_seq'], file['REG_DATE'])