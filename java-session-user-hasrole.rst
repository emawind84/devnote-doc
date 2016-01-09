.. _java-session-user-hasrole:

Session User Role Management
================================

.. seealso::
		| ``class`` sangah.security.SessionUserProfile
		| ``class`` pmis.main.login.LoginForm
		
SessionUserProfile.hasRole(String role)
	Check if the user in session has the passed role.
	The method check first through the pmis groups and second through the granted authorities on authentication.

java usage:

.. code-block:: java

	SessionUtil.getSessionProfile().hasRole("DOC_MGR")
	

jsp usage:
	
.. code-block:: jsp

	<c:if test="${login.hasRole('DOC_MGR')}" >
	...
	</c:if>

.. note:: The only granted authorities used at this time are ``ROLE_MASTER`` and ``ROLE_ADMIN``.

	