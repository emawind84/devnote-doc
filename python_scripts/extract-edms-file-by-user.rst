.. _extract-edms-file-by-user:

==========================
Extract edms file by user 
==========================


``ex35.py``

::

	
	from java.io import *
	from pmis.common.util import *
	
	taskExec = Beans.taskExecutor
	
	res = sql('''
	select t1.*, t2.*,
		GET_USER_NM(t1.regit) as reg_name
	from comm_attch_file t1, pmis_edms t2
	where t1.revid = t2.revid
	and t1.file_seq in ( select file_seq from letter where pjt_cd = 'LCT2014' )
	and t1.regit is not null
	;''')
	
	f = File('F:\\data\\LCT\\Letter\\')
	f.mkdirs()
	
	print f.getAbsolutePath()
	
	for r in res:
	    #print r
	    
	    if r['REG_NAME'] == None:
	        continue
	    
	    efile = EdmsFile(r['FILEPATH'], r['TITLE'])
	    
	    ff = File(f.getAbsolutePath(), r['USER_NO'])
	    ff.mkdirs()
	    
	    print 'Creating path: ' + ff.getAbsolutePath()
	    
	    print 'user:' + u''.join(r['REG_NAME']).encode('utf-8')
	    File(ff.getAbsolutePath(), FileUtil.sanitizeFileName(r['REG_NAME'])).createNewFile()
	    
	    print '###' + u''.join(efile.name).encode('utf-8').strip()
	    nf = File(ff.getAbsolutePath(), FileUtil.sanitizeFileName(efile.name))
	    
	    if nf.exists():
	        print 'File already present skipping...'
	        continue
	    
	    try:
	    	#FileUtil.copy(efile, nf, taskExec)
	        print '### copy'
	    except:
	        print 'File not found, skipping file: ' + efile.toString()