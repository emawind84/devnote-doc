.. _sessioninterceptor:

==================
SessionInterceptor
==================




If NoAuth annotation is used the existance of LoginForm in Session will not be checked.
If NoAuth annotation is used on class definition, every methods will not have session check.
If NoAuth annotation is used on method definition the annotated method will not have session check. 

@NoAuth
public class NoSessionCoreAction extends CoreAction {

    @NoAuth
    public methodName() {...}
    
IMPORTANT: Is not needed to put session check in every action method implementation; the check will be done by SessionInterceptor if required.
public String methodName(){ 
    if (!SessionUtil.setValidate()) return ActionSupport.NONE; // NOT REQUIRED
    ...
}
