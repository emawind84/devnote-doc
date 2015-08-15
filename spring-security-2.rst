.. _spring-security-2:

=================
Spring Security 2
=================




.. seealso:: 
    
    | spring-security.xml
    | LoginAction.java
    
classes, interfaces:

::
     
     [I] org.springframework.security.Authentication
     [I] org.springframework.security.providers.AuthenticationProvider
     [I] org.springframework.security.userdetails.UserDetails
     [I] org.springframework.security.userdetails.UserDetailsService
     [I] org.springframework.security.userdetails.AuthenticationUserDetailsService
     
     // the object containing the Authentication object
     [C] org.springframework.security.context.SecurityContextHolder
     
     // credential check non required
     [C] org.springframework.security.providers.preauth.PreAuthenticatedAuthenticationProvider [I AuthenticationProvider]
     [C] org.springframework.security.providers.preauth.PreAuthenticatedAuthenticationToken [I Authentication]
     
     // credential check required
     [C] org.springframework.security.providers.dao.DaoAuthenticationProvider [I AuthenticationProvider]
     [C] org.springframework.security.providers.UsernamePasswordAuthenticationToken [I Authentication]
     
     // anonymous user access no credential check ( not used )
     [C] org.springframework.security.providers.anonymous.AnonymousAuthenticationProvider
     [C] org.springframework.security.providers.anonymous.AnonymousAuthenticationToken
     
     [C] org.springframework.security.providers.ProviderManager // the object containing the Authentication object
     
     [I] sangah.security.service.UserService
     [C] sangah.security.service.UserServiceImpl ( CRUD implementation for user )
     
     [I] sangah.security.UserProfile
     [C] sangah.security.UserProfileImpl (  )
     
     
example:

.. code-block:: java
 
    // pre authenticated user ( credential check not required )
    Authentication auth = new PreAuthenticatedAuthenticationToken([userid], [password]);
    auth = preAuthAuthenticationProvider.authenticate(auth);
    
    // user to be authenticated ( credential check required )
    auth = new UsernamePasswordAuthenticationToken( new UserProfileImpl( [userid], [password] ), [password] );
    auth = authenticationProvider.authenticate( auth );
    
    if( auth != null && auth.isAuthenticated() ){
        SecurityContextHolder.getContext().setAuthentication( auth );
    }
    
reference:

.. seealso::

    #. http://docs.spring.io/spring-security/site/reference.html
    #. http://docs.spring.io/spring-security/site/docs/2.0.7.RELEASE/reference/springsecurity.html
    #. http://docs.spring.io/spring-security/site/docs/2.0.7.RELEASE/reference/authentication-common-auth-services.html#concurrent-sessions
    #. http://docs.spring.io/spring-security/site/docs/3.0.x/reference/springsecurity.html ( recommended )
    #. http://docs.spring.io/spring-security/site/docs/3.0.x/reference/core-services.html
    #. http://docs.spring.io/spring-security/site/docs/3.0.x/reference/technical-overview.html
    #. http://docs.spring.io/spring-security/site/docs/3.0.x/reference/security-filter-chain.html
    #. http://docs.spring.io/spring-security/site/docs/3.0.x/apidocs/org/springframework/security/core/Authentication.html
    #. http://docs.spring.io/spring-security/site/docs/3.0.x/apidocs/org/springframework/security/core/userdetails/UserDetails.html
    #. http://docs.spring.io/spring-security/site/docs/3.0.x/apidocs/org/springframework/security/core/userdetails/UserDetailsService.html
    #. supplement: http://www.codeproject.com/Articles/253901/Getting-Started-Spring-Security
    

