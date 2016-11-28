.. _web_application_build_and_deploy:

============================================
How to Build and Deploy our Web Application
============================================

Build
--------------------

.. important:: Always change the ``build.properties`` file with the correct Tomcat directory before running Ant tasks


The project has a ``build.xml`` file, that is the task configuration file for Ant and that we use to build the application.

1. Make sure you edit the file ``build.properties`` and change the property 
   ``tomcat.home`` to match the tomcat in your system.

2. Add the **Ant View** window to Eclipse going to the menu ``Window`` -> ``Show View`` -> ``Ant``.

3. From the **Ant View** click the first button/icon **Add Buildfiles** and choose the ``build.xml`` inside your project

   .. figure:: _images/antbuild/ScreenClip.png

4. Depending from the option 'Hide Internal Targets' you will see several tasks. 
   What we need are: ``build-js`` and ``web`` tasks.
   If ``build.properties`` configuration is correct after you click the ``web`` task, 
   Ant will start copying all the compiled java classes with all the rest of the files 
   inside a new folder named 'build' under your project.

When Ant has finished his operation, you will see a new folder ``build/web``, 
this folder contains the final web application that should be deployed to the server.

   .. figure:: _images/antbuild/ScreenClip2.png

.. note:: The new build process create a unique jar file containing all the compiled java classes,
  what it means is that you will not upload lots of class files anymore, but just one jar file located
  inside the lib folder of the application named ``stnd_pmis.jar``.
  So the first time you build with the new process, on sync is **important** that you delete all the classes, 
  WinSCP will show lots of classes to delete, just delete them!


Deploy
----------------------

#. Always stop the Web Application Server (Tomcat) First!

#. To deploy the application use **WinSCP** and not other tools like Filezilla or any other ftp tools just **W I N S C P**.

#. Open **WinSCP** go to ``Options`` -> ``Preferences`` -> ``Transfer``, select ``Default`` as preset and click on ``Edit`` and again ``Edit``.

   In the **exclude files section** add the following lines::

		*/system_config_ko.properties
		*/system_config_local.properties
		*/struts.properties
		*/log4j.properties

   In the **exclude directories** add the following lines::

		*/WEB-INF/python/cachedir
		*/data/edms
		*/old
		*/pmis_html
		*/.svn
		*/cachedir
		*/ckeditor-dev
		*/src
		*/.git

   .. figure:: _images/winscp/Image.png

#. As a final touch **uncheck** ``Calculate total size`` from Common options in the Transfer settings window, we don't need it and takes too long. 
   Click OK and we finished setting the mask for synchonize our project.

   .. figure:: _images/winscp/Image3.png

#. IMPORTANT before deploying the web folder always check that the **Transfer Settings** at the top of the application says ``Default`` as the selected mask.

#. On the left select the build/web folder on your computer

#. On the right select the project web folder on the server

#. Click the button ``Synchronize``

#. Choose ``Remote`` as Target Directory

#. Choose ``Mirror Files`` as Mode

#. Choose ``Modification time`` as Comparison criteria.

#. Choose ``Preview changes`` under Synchronize options.

#. And finally check the box ``Use same options next time`` so you don't have to go through 7~10 again next time.
   
   .. figure:: _images/winscp/Image2.png

#. Click OK and a new window **Synchronization checklist** show up, check what files are going to be updated, deleted.

#. Click on ``Check all`` and then OK, the application will do his job and its done.

#. You can start again the Web Application Server (Tomcat).


----------------------


What is build-js task?
-----------------------

We have lots of javascript files! And the users can not load 30 files every times he change menu!
Moreover our servers can not handle 30 requests per user every time he change page.

So what ``build-js`` task does is compressing lots of javascript files into one file ``pmis_build.js``,
reducing requests per user so we should have more happy users and more happy servers.

If you execute this task you will find the final file inside the folder ``build/js``.

Now take in consideration that if you execute the ``web`` task you do NOT need to execute ``build-js``,
because the ``web`` task will execute the ``build-js`` task anyway.

But if for some situation you just want to compress our javascript libraries then feel free to run the ``build-js`` task only,
and make sure you copy this file inside the folder ``ext/script`` inside the ``web`` folder of the application on the server machine.


.. important:: As a side note to make this task really useful make sure the system property ``system.devmode`` is false.