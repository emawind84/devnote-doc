=======================================
Basic Authentication to PMIS
=======================================

The basic authentication is done using user credentials (username, password).

Starting from the new release of PMIS the following request parameters are required:

user_no
    The username

passwd
    The password of the user

auth_type (``=basic``)
    This parameter tell to our server to use the **basic** authentication (username/password).
    If you don't send this parameter, no authentication will be done.

errorPage (*optional*)
    In case the authentication fail, the user will be redirected to this page

redirectUrl (*optional*)
    On authentication the user will be redirected to this page

.. important:: 
    It's important to send all these parameters to **Login.action**, 
    in order to receive feedback on error and on success.
    
    Remember to add
    the following **input** tags to every **login.jsp** that you write::

        <input type="hidden" name="user_no" value="">
        <input type="hidden" name="pjt_cd" value="" >
        <input type="hidden" name="auth_type" value="basic" >
        <input type="hidden" name="errorPage" value="/pmis/STND_PMIS/main/LoginHidden.jsp" />
        <input type="hidden" name="redirectUrl" value="/pmis/STND_PMIS/main/LoginHidden.jsp" />
