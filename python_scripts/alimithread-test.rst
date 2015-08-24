.. _alimithread-test:

=================
AlimiThread test 
=================


``ex15.py``

::

	
	from pmis.common.runnable import AlimiThread
	
	alimi = AlimiThread('STND_PMIS', '123456', 'masterpmis')
	
	alimi.program = 'STND'
	
	taskexec = Beans.taskExecutor
	
	taskexec.execute( alimi )