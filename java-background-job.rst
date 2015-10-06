.. _java-background-job:

Background Job in Java
=============================

.. seealso:: 
	Take a look at the multi threading tutorial :ref:`java-concurrency-(multi-threading)---tutorial`

Create a new Thread and execute statements in background. 
With the ``transactionManager`` parameter the code will be executed under a new transaction inside the new thread.

.. code-block:: java

	// taskExecutor should be available in your class
	@Resource private TaskExecutor taskExecutor;

	// create a new BackgroundJob passing the TransactionManager
	taskExecutor.execute(new BackgroundJob(transactionManager){
		
		@Override
		public void doRun() {
			// this code will be executed in another thread!
		}
	});
	
	
To start a job without transaction just use the simple constructor without parameters.

.. code-block:: java

	...
	
	// create a new BackgroundJob passing the TransactionManager
	taskExecutor.execute(new BackgroundJob(){
		...
	});
	
.. note:: 
	Inside the method ``doRun`` you can access the session's user with ``SessionUtil``.
	Normally it would not work because the job is executed outside of the current request.
	With BackgroundJob class we fixed it, before executing the job, the request, 
	together with the session is saved inside a Thread context (``ThreadContextContainer``), 
	and retrieved by the ``SessionUtil`` when required.