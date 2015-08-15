.. _sessioninterceptor:

==================
SessionInterceptor
==================




.. note:: If NoAuth annotation is used the existance of LoginForm in Session will not be checked.
.. note:: If NoAuth annotation is used on class definition, every methods will not have session check.
.. note:: If NoAuth annotation is used on method definition the annotated method will not have session check. 

.. code-block: java

    @NoAuth
    public class NoSessionCoreAction extends CoreAction {
    
        @NoAuth
        public methodName() {...}

.. important:: 
    IMPORTANT: Is not needed to put session check in every action method implementation; the check will be done by SessionInterceptor if required.
    
.. code-block: java
    
    public String methodName(){ 
        if (!SessionUtil.setValidate()) return ActionSupport.NONE; // NOT REQUIRED
        ...
    }
