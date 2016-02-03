.. _pmis-framework-training:

==========================
PMIS Framework Training
==========================

TODO List
-------------------

#. Eclipse IDE
#. Subversion Control (SVN)
#. Apache Tomcat - Web Application Server
#. PMIS Source Code Tour
#. Browser Development Tools
#. Java Basic Concepts
#. Apache Maven (software project management)
#. Spring Framework
	
	- Application Context
	- Inversion of Control (IoC)
	- Dependency Injection (DI)
	- Aspect Oriented Programming (AOP)
	- Transaction Management
	
#. Struts Framework (MVC Framework)
		
	- Actions
	- Interceptors Stack
	- Results
	
#. iBatis (SQL Data Mapper)

#. Test-driven Development (TDD)

	- JUnit

#. jQuery (Javascript Library)
#. SangAh Libraries (Javascript Library)
#. jqGrid - Web Grid (Javascript Library)
#. CKEditor - Web Editor (Javascript Library)
#. PMIS Authentication System (Spring Security)
#. Building & Deployment Process
#. DB Update Process

---------------------------------------------------------------------

	
Eclipse IDE
------------------

.. note::
	- Main Download Page: https://eclipse.org/downloads/
	- Other Builds: http://download.eclipse.org/eclipse/downloads/drops4/R-4.5.1-201509040015/

.. important:: 
	**If you install the Java JDK x64 version make sure to download Eclipse 64bit as well!**

#. Install Java first! Take the JDK `HERE <http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html>`_.

#. Set ``JAVA_HOME`` to **Java JDK folder**.

#. Set ``PATH`` to the **JRE or JDK bin folder**.

#. Make sure Java is installed. Open **cmd.exe** and type ``> java -version``

Download the last release of Eclipse following this step:

#. Go to the `Eclipse Download Page <http://download.eclipse.org/eclipse/downloads/>`_.

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

Configuration Tips
^^^^^^^^^^^^^^^^^^^

#. Change encoding to UTF-8 for all the file types supported (.jsp, .html, .properties, .xml, .java, .css).
#. Change the installed Java version JRE -> JDK.
#. Change the default Java Compiler to 1.6.
#. Add a new Server Runtime Environment.
#. Change the Eclipse Perspective to a more suitable for development (``Java EE`` or ``Java``).
#. Recommended to change the Left Panel View to ``Package Explorer`` and ``Navigator``.
#. Recommended to change the **Package Presentation** for the **Package Explorer** to ``Hierarchical``. 
#. You might want to disable auto build (**Project -> Build Automatically**) 
   and change the ``Ctrl+B`` key combination to build just **one Project**.
   The default combination will build all projects in the workspace.

*todo*

---------------------------------------------------------------------


Subversion Control (SVN)
------------------------------

*todo*

.. note:: 
	| Official Website https://subversion.apache.org/
	| SVN 1.7 Documentation: http://svnbook.red-bean.com/en/1.7/index.html
	| SVN 1.8 Documentation: http://svnbook.red-bean.com/nightly/en/index.html 
	| Windows Client: https://tortoisesvn.net/
	


---------------------------------------------------------------------	
	

Apache Tomcat - Web Application Server
---------------------------------------

Deployment
	https://tomcat.apache.org/tomcat-7.0-doc/appdev/deployment.html

Apache Tomcat Versions
	http://tomcat.apache.org/whichversion.html

Standard_Directory_Layout
	https://tomcat.apache.org/tomcat-7.0-doc/appdev/deployment.html#Standard_Directory_Layout


*todo*

---------------------------------------------------------------------


Browser Development Tools
-------------------------------

.. note:: 
	| `Firefox Development Tools <https://developer.mozilla.org/en-US/Learn/Discover_browser_developer_tools>`_
	| `Chrome Development Tools <https://developers.google.com/web/tools/chrome-devtools/?hl=en>`_
	| `IE Development Tools <https://msdn.microsoft.com/en-us/library/dd565628%28v=vs.85%29.aspx>`_

*todo*
	
---------------------------------------------------------------------


Java Basic Concepts
---------------------

Object-Oriented Programming Concepts 
	<https://docs.oracle.com/javase/tutorial/java/concepts/index.html>
	
Cohesion & Coupling 
	<http://www.tutorialspoint.com/software_engineering/software_design_basics.htm>
	
[Logging] Java Util Logging
	https://docs.oracle.com/javase/7/docs/technotes/guides/logging/overview.html
	
[Logging] Apache Log4j 2
	http://logging.apache.org/log4j/2.x/

- :ref:`code-conventions-for-the-java`
- :ref:`checked-versus-unchecked-exceptions`
- :ref:`arguments-validation-java-class`
- :ref:`java-concurrency-(multi-threading)---tutorial`
- :ref:`java-background-job`

--------------------------------------------------------------------


Apache Maven (software project management)
----------------------------------------------

.. note:: 
	- `Apache Maven Website <https://maven.apache.org/>`_
	- 'Maven Repository <http://mvnrepository.com/>'_


#. Download
	https://maven.apache.org/download.cgi

#. Install
	https://maven.apache.org/install.html

#. Run
	https://maven.apache.org/run.html


---------------------------------------------------------------------


Spring Framework
--------------------

.. note:: `Book Spring in Action <https://www.manning.com/books/spring-in-action-third-edition>`_

**Book Spring in Action (3rd)** useful chapters:

	- 1, 2, 3 Basic concepts
	- 4 AOP
	- 5.2 ~ 5.3 Datasource & JDBC
	- 6 Managing Transactions
	- 7 MVC

Below some online documentations:

Application Context
	https://spring.io/understanding/application-context

Inversion of Control (IoC)
	https://en.wikipedia.org/wiki/Inversion_of_control

Dependency Injection (DI)
	http://docs.spring.io/spring/docs/current/spring-framework-reference/html/beans.html

Aspect Oriented Programming (AOP)
	http://docs.spring.io/spring/docs/current/spring-framework-reference/html/aop.html#aop-understanding-aop-proxies

Transaction Management
	http://docs.spring.io/spring/docs/current/spring-framework-reference/html/transaction.html
	
	:ref:`transactioninterceptor`



---------------------------------------------------------------------


Struts Framework
-----------------------

.. note::
	- `Struts 2 Documentation - Interceptors <https://struts.apache.org/docs/interceptors.html>`_
	- `Book Struts 2 in Action <https://www.manning.com/books/struts-2-in-action>`_

**Book Struts 2 in Action** useful chapters:
		
	- 1, 2, 3, 4 Fundamental
	- 8 Results
	- 9 Struts 2 + Spring
	
---------------------------------------------------------------------


iBatis SQL Data Mapper
---------------------------

.. note:: 
	- `New MyBatis Project Website (with some reference to the old one) <http://blog.mybatis.org/>`_
	- `Books iBATIS in Action <https://www.manning.com/books/ibatis-in-action>`_


---------------------------------------------------------------------


Test-driven Development (TDD)
--------------------------------

.. note:: 
	- `Test-driven development <https://en.wikipedia.org/wiki/Test-driven_development>`_
	- `More results here <https://goo.gl/nIQTWD>`_
	
Junit - Java Testing Tool
	http://junit.org/

*todo*

---------------------------------------------------------------------


jQuery (Javascript Library)
---------------------------------

.. note:: https://api.jquery.com/

*todo*

---------------------------------------------------------------------


SangAh Library (Javascript Library)
--------------------------------------

Give a look at the files under ``/web/ext/script/``

- ``common.js``
- ``Functionsml.js``
- ``coolMask.js``
- ``pmis_build.js``
- ``pmis_loader.js``

*todo*

---------------------------------------------------------------------


Web Grid Plugin - jqGrid (Javascript Library)
-----------------------------------------------

- Flat Grid Configuration
- Tree Grid Configuration
- Pagined Grid (Asynchronous Paging)
- Fetching Server Data

.. note:: `Wiki Documentation <http://www.trirand.com/jqgridwiki/doku.php?id=wiki:jqgriddocs>`_


*todo*

---------------------------------------------------------------------


Web Editor - CKEditor (Javascript Library)
----------------------------------------------

.. note:: 
	`CKEditor Website <http://ckeditor.com/>`_

*todo*

---------------------------------------------------------------------


PMIS Authentication System (Spring Security)
------------------------------------------------

.. note::
	More information here :ref:`spring-security-2`
	
*todo*