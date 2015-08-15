.. _preparableinterceptor:

=====================
PreparableInterceptor
=====================




Before the execution of the action method is possible to do some task, as preparing action's objects for the execution of the method.
The main point of preparable is that before prepare method is executed, parameters from jsp are set on action so is possible to use every parameter sended;
after the execution of prepare method this parameters will be set again, so existing parameters on action will be overridden with the parameters passed from jsp if they will present same signature.

Preparable comes in handy when some parameters are useless on jsp but they are required in action. 

In this situation is possible to get these parameters directly from database without directly put these parameters on jsp with 

::

    <input type="hidden" ...
    
Example

.. code-block:: java
    
    @Preparable
    public class className {
    
        public void prepare() {
            login  = (LoginForm)SessionUtil.getSession();
            if( form == null ) form = new DesignEdsForm();
            form.setPjt_cd( login.getPjt_cd() );
            DesignEdsForm obj = designEdsDao.getEdsDetail( form );
            form = obj!=null?obj:form;
        }
    }
