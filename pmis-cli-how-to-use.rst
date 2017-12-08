PMIS Command Line Interface
===================================

What the heck is PMIS cli
-------------------------------

PMIS cli is an administrator tool used for maintenance on the server.
It is like running PMIS web application just without 'web'.
**We don't need a web application server for executing the cli**.
With this tool we can **export data into excel files**, fix inconsistent data,
export edms files, monitor server status, 
**running services directly without calling actions!**

So in short, do NOT make an action just for making a one time job 
or because you don't know how to run yuor service outside 
of the web application.
**Use the CLI!**

I made this tool many years ago and still no one use it,
most of you probably don't know why you should use it, and others don't understand how to use it.
So I will go through the setup and how to make simple scripts to get started.

.. important:: 
  This cli tool is powerful as much as dangerous if not used well, so always test your script in 
  a development environment before run it in production.

And if you are wondering what I am talking about, I am sorry but I am not going to translate this in Korean...

**Language**: ``Python`` & ``Java``

You need to know just the basic of Python, 
moreover I already made lots of scrits that you can check for reference.

Check the folder inside PMIS at ``/web/pmis/STND_PMIS/test/console/example``
where you will find lots of scripts and under ``/util/scripts``.

Scripts located under ``/util/scripts`` 
are used with the cli tool,
instead the scripts under the ``console`` folder, 
are used on the web interface that you might know as `PMIS Console`.

They are slightly different because in the web interface 
we don't need to pass arguments to the script, 
we just write them right into the script,
instead if we use a shell application (the cli) 
we need to add a section to the script in order to parse 
arguments sent to the script through the shell.

Right into the code
---------------------------

...to be continued



Build and prepare the CLI tool
-----------------------------------

There is an Ant task named ``prepare-cli``, just run it
and it will create a new folder ``cli`` under the ``build`` folder.
Inside you will see two script, one for windows and one for linux, and a ``scripts`` folder
with all the scripts inside ``/util/scripts``.

Move this ``cli`` folder on the server and before running the script, 
like the web version, **we need to set a properties file (``system_config_ko.properties``)**.
When you build the cli, it will not contain the system properties file, so copy the right file (from the server) 
into the folder ``WEB-INF``.

You can test if the tool work running it without passing any script::

    $ ./launch.sh
    Buildfile: D:\workspace\STND_PMIS_egov\build\cli\build.xml

    run:
    Executing sangah.scripting.ScriptExecutor
    DEBUG: setDebug: JavaMail version 1.4.5

    BUILD SUCCESSFUL
    Total time: 7 seconds

You will see a bunch of messages but with no errors.