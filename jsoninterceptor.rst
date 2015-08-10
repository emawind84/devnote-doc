.. _jsoninterceptor:

===============
JSONInterceptor
===============




Execution of action methods from javascript with the output object in json format.
 
**java:**

.. code-block:: java
    
    @Controller
    public class WorkflowAction {
        ...
        
        public String smd() {
            return Action.SUCCESS;
        }
        
        @SMDMethod
        public Map userInfo(String user_no) {
            ...
        }
    
.. note:: [The 'Controller' annotation is important for calling the action method correctly: "/rpc/workflow.action"]

**jsp:**

.. code-block:: javascript

    require(["dojo/rpc/JsonService"], function(JsonService){
        var service = new JsonService("/rpc/workflow.action");
        service.userInfo("${login.user_no}").addCallback(function( user ) {
            ...
        });
    });

MORE DETAIL: 
- WorkflowAction.java
- WorkflowEdit.jsp

reference: https://struts.apache.org/release/2.2.x/docs/json-plugin.html

