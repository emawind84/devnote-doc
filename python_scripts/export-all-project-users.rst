.. _export-all-project-users:

=========================
Export all project users 
=========================


``ex36.py``

::

	# A temporary file will be created, look into your temporary folder!
	
	# SET PROJECT CODE 
	pjt_cd = 'GLB_PMIS'
	
	from java.util import *
	from java.io import *
	from java.lang import *
	from pmis.common.util import *
	from pmis.common.excel import *
	
	temporaryFileService = Beans.temporaryFileService
	coreDao = Beans.coreDao
	userService = Beans.userService
	
	list = sql('''
	select * from pmis_user t1, work_obs t2 where t1.user_no = t2.obs_cd and t2.pjt_cd = ?
	;''', pjt_cd)
	
	writer = XSSFSheetWriter();
	writer.newSheet('users')
	writer.selectSheet(0)
	
	header = False
	
	for u in list:
	    
	    cu = CustomHashMap()
	    cu.setLowerKeyMode(True)
	    cu.putAll(u)
	
	    userService.decryptUserData(cu);
	    print cu
	    print '\n'
	    
	    if header == False:
	    	for entry in cu.entrySet():
	        	writer.newCell(entry.key)
	        	header = True
	    
	    writer.newRow()
	    
	    for entry in cu.entrySet():
	        writer.newCell(entry.value)
	    
	outputFile = temporaryFileService.getNewFile(".xlsx")
	output = FileOutputStream(outputFile)
	writer.write(output)