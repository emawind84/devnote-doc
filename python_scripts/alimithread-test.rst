.. _alimithread-test:

=================
AlimiThread test 
=================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex15.py``

::

	
	from pmis.common.runnable import AlimiThread
	
	alimi = AlimiThread('STND_PMIS', '123456', 'masterpmis')
	
	alimi.program = 'STND'
	
	taskexec = Beans.taskExecutor
	
	taskexec.execute( alimi )