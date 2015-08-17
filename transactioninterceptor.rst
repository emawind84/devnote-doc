.. _transactioninterceptor:

======================
TransactionInterceptor
======================




'Action methods' annotated with Transactional will be enveloped in a transaction state; 
if exception arise the Transaction interceptor will do rollback automatically.
Note the difference between pmis Transactional and spring Transactional annotation!

.. code-block:: java
    
    @pmis.system.spring.Transactional
    public String methodName(){ 
        ...
        return SUCCESS; 
    }
    
    // NOT REQUIRED ANYMORE
    @org.springframework.transaction.annotation.Transactional
    public String methodName(){
        try{
            ...
        } catch (Exception e) {
            TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
            ...
        }



.. seealso:: Spring TransactionInterceptor valid for 'non action class' ( service class )

.. seealso:: http://docs.spring.io/spring/docs/2.0.x/reference/transaction.html


.. important:: To make the rolling back procedure work correctly a RuntimeException have to be thrown!!!

.. node::
    Using TransactionInterceptor, is not required to explicitly throw a RuntimeException inside an action method,
    every exception will be catched and a rollback will be executed anyway.

However if you plan to execute a service without a web request (no action) you have to explicitly throw
an unchecked exception (RuntimeException) in order to rollback the transaction in case of errors.

.. code-block:: java

    @org.springframework.transaction.annotation.Transactional( propagation = Propagation.REQUIRED )
    public void transTest() throws Exception{
        throw new RuntimeException(); // roolback WORK
        //throw new Exception(); // roolback NOT WORK
    }

.. note:: The interceptor used for service classes is the native Spring class: 
    org.springframework.transaction.interceptor.TransactionInterceptor

.. note:: The interceptor used for action classes is the class: 
    pmis.common.struts.interceptor.TransactionInterceptor