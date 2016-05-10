.. _web-app-maven-and-eclipse:

=====================================
Web Application + Maven + Eclipse
=====================================

To make use of Maven and still test our application with Eclipse Tomcat Server module,
we need to add to the application the web module in order to add our application to the Server without much effort.

1. Project Facets Settings
------------------------------

.. figure:: _images/eclipse-webapp/ScreenClip[10].png

.. figure:: _images/eclipse-webapp/ScreenClip[11].png

.. figure:: _images/eclipse-webapp/ScreenClip[13].png


2. Deployment Assembly
-----------------------------

.. figure:: _images/eclipse-webapp/ScreenClip[8].png

.. figure:: _images/eclipse-webapp/ScreenClip[7].png

.. figure:: _images/eclipse-webapp/ScreenClip[6].png



3. Add Application to Server
-------------------------------

.. figure:: _images/eclipse-webapp/ScreenClip[12].png

.. figure:: _images/eclipse-webapp/ScreenClip[9].png


4. Web Module Settings
------------------------------

.. figure:: _images/eclipse-webapp/ScreenClip[5].png

.. figure:: _images/eclipse-webapp/ScreenClip[4].png

.. figure:: _images/eclipse-webapp/ScreenClip[3].png



5. Compile & Run
----------------------

Compile and run the application as usual and make sure the label on the right of the server name say ``Synchronized``.