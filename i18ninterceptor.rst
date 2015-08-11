.. _i18ninterceptor:

===============
I18nInterceptor
===============




This interceptor set the locale specified in a session.
parameterName: the name of the HTTP request parameter
attributeName: the name of the session key to store

::

    <interceptor-ref name="i18n" >
        <param name="parameterName">login_locale</param>
        <param name="attributeName">org.apache.struts.action.LOCALE</param>
    </interceptor-ref>

.. note:: Globals.LOCALE_KEY is equal to 'org.apache.struts.action.LOCALE', that's why the attributeName has this value]
.. note:: session.getAttribute(Globals.LOCALE_KEY) will return the correct locale]
.. note:: Is not needed anymore to implement an action for setting the locale, the interceptor will do the job.]

reference: https://struts.apache.org/release/2.2.x/docs/i18n-interceptor.html
