.. _copy-edms-file-from-one-fileseq-to-another:

===========================================
Copy edms file from one fileseq to another 
===========================================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex38.py``

::

	
	from pmis.common.util import *
	from pmis.core import CoreUtil
	
	# SET PARAMETERS HERE!
	fromSeq = ""
	toSeq = ""
	toUser = ""
	
	coreDao = Beans.coreDao
	commonServ = Beans.commonService
	
	p = HashMap();
	p.put("file_seq", fromSeq);
	
	file = coreDao.getList("core.sql.commAttchFileDetail", p );
	for f in file:
		commonServ.copyEdmsFile( f, toUser, toSeq, CoreUtil.getRevid() );