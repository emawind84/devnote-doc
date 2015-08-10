.. _transactioninterceptor:

======================
TransactionInterceptor
======================




'Action methods' annotated with Transactional will be enveloped in a transaction state; 
if exception arise the Transaction interceptor will do rollback automatically.
Note the difference between pmis Transactional and spring Transactional annotation!
 
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



// TEST Spring TransactionInterceptor valid for 'non action class' ( service class )
// reference: http://docs.spring.io/spring/docs/2.0.x/reference/transaction.html
@org.springframework.transaction.annotation.Transactional( propagation = Propagation.REQUIRED )
public void transTest() throws Exception{
    // to make the rolling back procedure work correctly a RuntimeException have to be thrown!!!
    throw new RuntimeException(); // roolback WORK
    //throw new Exception(); // roolback NOT WORK
}
