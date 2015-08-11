.. _unwrapexceptionmappinginterceptor:

=================================
UnwrapExceptionMappingInterceptor
=================================


    

요격을 이용하여 PmisLog.log method를 자동이 호출한다 예시: 

::

    try{ ... }catch(Exception e) { PmisLog.log(e); ... } // 이 구문은 필요 없다

.. note:: If try catch statement is required in action method, is always good to throw again the exception every time, unless different action is required on exception raised.

.. code-block:: java
    
    try{
        ...
    } catch(Exception ex) {
        ...
        PmisLog.log(...); //NOT GOOD!
    }
    
    try{
        ...
    } catch(Exception ex) {
        ...
        PmisLog.log(...);
        throw ex; //GOOD!
    }

.. note:: [Please note that on action methods PmisLog.log(...) is not needed anymore! 
    The UnwrapExceptionMappingInterceptor will handle the exception and PmisLog.log() will be called.]


.. warning:: IMPORTANT: If on action method is not requested try catch statement, don't use it. 

.. warning:: If exception arise, the UnwrapExceptionMappingInterceptor will handle it, and PmisLog.log() will be called, don't worry!


.. code-block:: java
    
    public class NameAction {
    
        public String boringMethodName() {
            String result = "ERROR";
            try{
                ...
                result = "SUCCESS";
            }catch(Exception e) {
                ...
                PmisLog.log(...);
            }
            return result;
        }
        
        [The result ERROR is not needed; if exception arise the request will be redirected automatically on the error page, 
        as defined on struts.xml configuration file under <global-results> tag]
    
        public String notGoodMethodName() {
            try{
                ...
            }catch(Exception e) {
                ...
                PmisLog.log(...);
            }
            return SUCCESS;
        }
        
        public String goodMethodName() throws Exception {
            try{
                ...
            }catch(Exception e) {
                // Some action before throw again the exception!
                ...
                throw e;
            }
            return SUCCESS;
        }
        
        public String anotherGoodMethodName() throws Exception {
            ...
            return SUCCESS;
        }
        
        public String anotherMoreGoodMethodName() {
            try{
                ...
            }catch(Exception e) {
                // Some action before throw again the exception!
                ...
                Errors.lower(e);
            }
            return SUCCESS;
        }   
    }

.. note:: [Errors.lower(e) will hide the exception on the current method, so you don't need to put throws Exception on the class definition; 
    the Errors.lower(e) will throw a RuntimeException.
    Take a look at Errors class for more methods!]
