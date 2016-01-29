.. _pmis-framework-training:

==========================
PMIS Framework Training
==========================

TODO List
---------------

#. Subversion Control (SVN)
#. Eclipse IDE
#. Browser Development Tools
#. Tomcat Web Application
#. Java Basic Concepts
#. Maven
#. Spring Framework
	
	- Application Context
	- Inversion of Control (IoC)
	- Dependency Injection (DI)
	- Aspect Oriented Programming (AOP)
	- Transaction Management
	
#. Struts Framework (MVC Framework)
	
	- Interceptor Stack
	
#. iBatis (SQL Data Mapper)

#. Test-driven Development (TDD)

	- JUnit

#. jQuery (Javascript Library)
#. SangAh Library (Javascript Library)
#. Web Grid Plugin - jqGrid (Javascript Library)
#. Web Editor - CKEditor (Javascript Library)
#. PMIS Authentication System (Spring Security)

-----------------


Subversion Control (SVN)
------------------------------

*todo*

.. note:: 
	| Official Website https://subversion.apache.org/
	| SVN 1.7 Documentation: http://svnbook.red-bean.com/en/1.7/index.html
	| SVN 1.8 Documentation: http://svnbook.red-bean.com/nightly/en/index.html 
	| Windows Client: https://tortoisesvn.net/
	
	
	
Eclipse IDE
------------------

.. note::
	| Main Download Page: https://eclipse.org/downloads/
	| Other Builds: http://download.eclipse.org/eclipse/downloads/drops4/R-4.5.1-201509040015/
		
Download & Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^

Install Java first.

Set ``JAVA_HOME`` to Java jdk folder and add the jre bin folder to the ``PATH`` variable.

Download the last release of Eclipse following this step:

#. Go to the `download page <http://download.eclipse.org/eclipse/downloads/>`_.

#. Under **Latest Release** click on the latest version and you will be redirected to another page.

#. Scroll down until you find **Platform Runtime Binary** packages and download the correct version for your system.

#. To start using this version of Eclipse with Java you need to install some plugins:

	From inside Eclipse go to ``Help`` -> ``Install New Software`` and from there you should search for these plugins:

	- ``Eclipse Platform`` [already installed] 
	- ``Eclipse Java Web Developer Tools`` under Eclipse Web Tools Platform
	- ``m2e-wtp - Maven Integration for WTP``
	- ``JST Server Adapters``
	- ``JST Server Adapters Extensions``
	- ``Marketplace Client`` under Eclipse Marketplace Client
	
	If you cannot find JST Server Adapter than after you installed the ``Marketplace Client`` 
	go to ``Help`` -> ``Eclipse Marketplace`` and from there search and install ``Eclipse JST Server Adapter``.
	
	These plugins should be enough to get started.

*todo*

Tomcat Server Setting
^^^^^^^^^^^^^^^^^^^^^^^^^

*todo*
	
	
Browser Development Tools
-------------------------------

.. note:: 
	| `Firefox Development Tools <https://developer.mozilla.org/en-US/Learn/Discover_browser_developer_tools>`_
	| `Chrome Development Tools <https://developers.google.com/web/tools/chrome-devtools/?hl=en>`_
	| `IE Development Tools <https://msdn.microsoft.com/en-us/library/dd565628%28v=vs.85%29.aspx>`_

*todo*
	

Tomcat Web Application
---------------------------

.. note:: 
	https://tomcat.apache.org/tomcat-7.0-doc/appdev/deployment.html 


`Standard_Directory_Layout <https://tomcat.apache.org/tomcat-7.0-doc/appdev/deployment.html#Standard_Directory_Layout>`_

*todo*


Java Basic Concepts
---------------------

.. note:: `Object-Oriented Programming Concepts <https://docs.oracle.com/javase/tutorial/java/concepts/index.html>`_

- :ref:`code-conventions-for-the-java`
- :ref:`checked-versus-unchecked-exceptions`
- :ref:`arguments-validation-java-class`
- :ref:`java-concurrency-(multi-threading)---tutorial`
- :ref:`java-background-job`


Maven
---------------

.. note:: https://maven.apache.org/

Download
^^^^^^^^^

.. note:: https://maven.apache.org/download.cgi

Install
^^^^^^^^^^^

.. note:: https://maven.apache.org/install.html

Run
^^^^^

.. note:: https://maven.apache.org/run.html




Spring Framework
--------------------

*todo*


Application Context
^^^^^^^^^^^^^^^^^^^^^

.. note:: https://spring.io/understanding/application-context


Inversion of Control (IoC)
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: https://en.wikipedia.org/wiki/Inversion_of_control


Dependency Injection (DI)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: http://docs.spring.io/spring/docs/current/spring-framework-reference/html/beans.html


Aspect Oriented Programming (AOP)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: http://docs.spring.io/spring/docs/current/spring-framework-reference/html/aop.html#aop-understanding-aop-proxies


Transaction Management
^^^^^^^^^^^^^^^^^^^^^^^^^

:ref:`transactioninterceptor`

.. note:: http://docs.spring.io/spring/docs/current/spring-framework-reference/html/transaction.html



Struts Framework
-----------------------

*todo*



Interceptor Stack
^^^^^^^^^^^^^^^^^^^^^^^

.. note:: https://struts.apache.org/docs/interceptors.html



iBatis SQL Data Mapper
---------------------------

.. note:: 
	New MyBatis Project Website (with some reference to the old one) http://blog.mybatis.org/

*todo*


Test-driven Development (TDD)
--------------------------------

.. note:: `Test-driven development <https://en.wikipedia.org/wiki/Test-driven_development>`_

	`More results... <https://goo.gl/nIQTWD>`_

*todo*


jQuery (Javascript Library)
---------------------------------

.. note:: https://api.jquery.com/

*todo*



SangAh Library (Javascript Library)
--------------------------------------

Give a look at the files under ``/web/ext/script/``

- ``common.js``
- ``Functionsml.js``
- ``coolMask.js``
- ``pmis_build.js``
- ``pmis_loader.js``

*todo*



Web Grid Plugin - jqGrid (Javascript Library)
-----------------------------------------------

- Flat Grid Configuration
- Tree Grid Configuration
- Pagined Grid (Asynchronous Paging)
- Fetching Server Data

*todo*



Web Editor - CKEditor (Javascript Library)
----------------------------------------------

.. note:: 
	CKEditor Website: http://ckeditor.com/

*todo*



PMIS Authentication System (Spring Security)
------------------------------------------------

.. note::
	More information here :ref:`spring-security-2`
	
*todo*