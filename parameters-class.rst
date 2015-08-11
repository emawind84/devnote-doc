.. _parameters-class:

================
Parameters class
================




The Parameters class is useful when you need to pass a Map to ibatis query. Parameters class contains the parameters from the request.
The parameters from the request are all Array String and can't be used in ibatis query as a normal java beans object.
Parameters class has a getMap() method that change every parameters in String if the length of the array is 1.

To use Parameters class in an Action class simply extends BaseAction abstract class

.. code-block:: java
    
    public class WorkflowAction extends BaseAction {
    
        ...
        
        public String executeWorkflow() throws Exception{
            Map params = parameters.getMap();        
            params.put("user_id", SessionUtil.getSession().getUser_no());
            params.put("pjt_cd", SessionUtil.getSession().getPjt_cd());
            
            coreDao.getView("core.sql.pmisUserInfo", params );
            
            for (int i=0; i < parameters.get("wf_user_ids").length; i++) {
                ...
            
        
In a service class is possible to inizialize a Parameters class in this way:

.. code-block:: java
    
    public String generateWorkflow(HttpServletRequest request) {
        Parameters parameters = new Parameters(request);
        ...
    
    
.. note:: [IMPORTANT! the method getMap() will return a new Map 'without array with a single value', 
  so in case is expected an array of length 1 is important to NOT USE the getMap() method;
  instead use get(String key) method that will return an array even if the array has length 1 ]
    
.. note:: parameters.get("ids").length // ids will be an array even if the array has length 1
    
.. note:: parameters.getMap().get("ids") // ids will be an array if the original array had length > 1 otherwise will be a String and ClassCastException will be thrown.
    

