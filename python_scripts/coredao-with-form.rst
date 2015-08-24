.. _coredao-with-form:

==================
CoreDao with Form 
==================


``ex02.py``

::

	
	from java.util import *
	from java.lang import *
	from pmis.project.complaint import *
	
	coreDao = ApplicationContext.get('coreDao')
	
	param = ComplaintForm()
	param.pjt_cd = 'STND_PMIS'
	param.user_no = 'masterpmis'
	
	compl = coreDao.getList('project.complaint.getComplaintList', param)
	
	for comp in compl:
	    print comp.occu_date