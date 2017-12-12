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

.. important:: The following code is based on Python 2.7 (NOT 3.x)

.. code-block:: python

    import jarray
    from pmis.core import CoreUtil

These lines tell to python to import some modules that we require for the execution of the script.
You can see there is a python module ``jarray`` and a PMIS module ``CoreUtil``, 
so whenever you need to use some java class always import the class first.

.. code-block:: python

    temp = Beans.temporaryFileService
    newfile = temp.getNewFile('.html')

With this line we can import the TemporaryFileService instance into the python script 
and use it like if it was inside a Java class.

``Beans`` is a special class that we defined inside ``spring-scripting.xml`` 
that use the Spring ApplicationContext to retrieve the instance of a service.
Since we provide the ApplicationContext as a builtin object, 
we can achieve the same purpose writing the following::

    temp = ApplicationContext.get('temporaryFileService')
    newfile = temp.getNewFile('.html')

So if you need other services like ``UserService`` or ``CoreDao`` just do like this:

.. code-block:: python

    user_srv = Beans.userService
    coredao = Beans.coreDao

If you want to know the type of a variable you can use the ``type`` module:

.. code-block:: python

    print type(ApplicationContext.getContainer())
    print type(Beans.userService)


Another function that you should know about is ``sql``:

.. code-block:: python

    ret = sql('''
    select * from pmis_user
    ;''')

With ``sql`` you can execute queries directly on the database, 
only ``select`` queries, if you want to insert, update or delete you need to use
``sqlexec``:

.. code-block:: python

    sqlexec('''
    update work_report set file_seq= ? where seq = ?
    ;''', value1, value2)

``sqlexec`` should be used with cautions!


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