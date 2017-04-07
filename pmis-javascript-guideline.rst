.. highlight:: javascript

=================================
Javascript Guideline
=================================

Below you find code examples to keep our web application as much cohesive as possible through all files.
The purpose is to rise the quality of the whole application, keep simple, bug free.


Global is Bad!
--------------------------

In order to pass to a complete ajax system without page reloads is important to keep javascript functions and variables in a private scope,
the use of ``window`` object should be restricted to only a few common functionalities.

To achieve this, before writing any javascript code, first create a `self executing anonymous functions`_::

    (function(){
        "use strict";

        // your code go here!

    })();

This will create a private scope, whatever variables or functions you make inside this functions will not be visible outside.


Mistakes
^^^^^^^^^^^^^^^^^^^

Never declare variables without ``var``::

    myvariable = 123  // wrong!
    var myvariable = 123  // good!
    // -------------------------------------

    for(i = 1; i < mylist.length; i++) {}  // wrong!
    for(var i = 1; i < mylist.length; i++) {}  // good!
    // ----------------------------------------------------



.. _self executing anonymous functions: http://markdalgleish.com/2011/03/self-executing-anonymous-functions/


Event Trigger and Event Handlers
------------------------------------

We have two functions to achieve event handlings, lets say three:

pmis.trigger(...)
    Use always this functions in order to start/trigger/broadcast an event through the DOM.

pmis.on(...)
    Use this function to handle an event instead of ``$(document).on(...)``.

pmis.off(...)
    Use this function to remove handlers attached to some event or namespace.

-----------------------------

Change this::

    $(document).on("afterDoingSomething", function(e, data){});

to this::

    pmis.on("afterDoingSomething", function(data){});

---------------------

Change this::

    $(window).resize(function(){});

to this::

    $(window).on("resize.pmis", function(){});

.. note:: 
    ``pmis.on`` cover only the ``document`` object, not ``window``, so for the ``resize`` event we still use the JQuery ``on``
    but make sure you add the namespace ``pmis`` after the event name.

---------------------

Change this::

    $(window).on("resize", function(){});

to this::

    $(window).on("resize.pmis", function(){});


When and Where to use pmis.off
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

We use pmis.off to remove old handlers from the document element.
Whenever you write ``pmis.on('event_here', function(){ handler here })`` we add an handler to the document element.
If you reload this page a new handler will be added to the **same** document element. So when the event is triggered
two handlers will be executed, not one! That's why we need pmis.off to remove the handlers previously added.

.. important:: 
    The previous handlers should be removed when the implementation refer to elements that are not part of the DOM anymore.
    This is true when we reload sub pages (we replace grid, table, div, they look the same but they are different elements).


Mistakes
^^^^^^^^^^^^^^^^^^^

What you see below is usually what you should not do::

    pmis.off('afterDoingSomething');  // it doesn't work...
    pmis.on('afterDoingSomething', function(){});

    pmis.off('afterSomeButtonClick');  // it doesn't work...
    pmis.on('afterSomeButtonClick', function(){});

    $(document).off('beforeDoingSomething');
    $(document).on('beforeDoingSomething', function(){});

    $(document).off('onJustDontDoThisBecauseIsBad');
    $(document).on('onJustDontDoThisBecauseIsBad', function(){});


The correct way of using pmis.off is the following::

    // we remove previously added handlers to this namespace
    pmis.off('myUniqueNamespaceHere');

    // we add new handlers after
    pmis.on('afterDoingSomething', 'myUniqueNamespaceHere', function(){});

    pmis.on('afterSomeButtonClick', 'myUniqueNamespaceHere', function(){});

    pmis.on('beforeDoingSomething', 'myUniqueNamespaceHere', function(){});

    pmis.on('onJustDontDoThisBecauseIsBad', 'myUniqueNamespaceHere', function(){});



Window Resize
--------------------------

First, do not add 100 handlers that do resize everywhere!
The only page that should do the window/ui resize is the main page.

So on the main page you might have something like this::

    $(window).resize(function(){
        resizeFormH();
    });

This handler will be called whenever the user change the browser window size or whenever we use ``$(window).resize();``,
that means that this handler will be called a lot of times.
This wasn't bad before writing this guide, but now is bad, so please refrain from doing this.

Instead we should use the new event ``resize::resize`` much less invasive and smarter. 
Don't search on internet because it's a custom event, you find the implementation in ``functionsml.js``.

We need to resize the window? Let's attach an handler to the ``body`` element that listen to the event ``resize::resize``.

To do this just add the attribute ``resize`` to the body element::

    <body resize>
    
    </body>

...and attach the handler to it::

    $('body').on('resize::resize', function(){
        // call the ui resize here
    });

That's it!

Then we need to resize a grid? Let's attach an handler to the grid!

So instead of doing this::

    $(window).on('resize.mysubpage', function(){
        $('#mygrid').jqGrid('resizeGrid', '.data_area');
    });

Add the attribute ``resize`` to the jqGrid table element::

    <table id="mygrid" resize ></table>

...and attach the handler to it::

    $('#mygrid').on('resize::resize', function(){
        $(this).jqGrid('resizeGrid', '.data_area');
    });

So if an element want to resize himself he can do it now, we do not need anymore to give all the work to the poor ``window`` object.
In this way we reduce coupling between elements and they should be more happy.


Indentation...
------------------------


'Oh my god what the hell is this' Indentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: html

    <html>
        <head>
            <script></script>
                <link />

                    <script>
                        (function(){

                            var something;

                            function(){
                                    var something2;

                                    for(something here) {
                                                if(blablabla){
                                                    var indentation_is_my_friend;
                                                        for(what the hell am I doing here) {
                                                            
                                                        }
                                                }
                                    }
                            }

                        })();
                    </script>
        </head>

        <body>
                            <div>
                                    <table>
                                            <tr><td>what a good indentation 
                                            here
                                            </td></tr>
                            </table>
                        </div>
        </body>
    </html>

Better Indentation
^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. code-block:: html

    <html>

    <head>

    <script></script>
    <link />

    <script>
    (function(){

        var something;

        function(){
            var something2;

            for(something here) {
                if(blablabla){
                    var indentation_is_my_friend;
                    for(what the hell am I doing here) {
                    }
                }
            }
        }

    })();
    </script>

    </head>

    <body>
    
    <div>
        <table>
            <tr>
                <td>what a good indentation here</td>
            </tr>
        </table>
    </div>

    </body>

    </html>


How To Use Google Chart Libraries
------------------------------------

Before
^^^^^^^^^^^^^

The script tags are correctly loaded only if the document is not ready yet. 
In this situation the google libraries and d3 library are loaded first and then the script below them is executed. 
This is a scenario that we can NOT use.

::

    <script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript" src="/ext/d3/d3.v3.min.js" ></script>

    <script type="text/javascript">
    // this script is executed after the google libraries and d3 library are loaded
    google.load("visualization", "1", {packages:["corechart"]});
    google.setOnLoadCallback(drawVisualization);

    function drawVisualization(){
        ...
    }
    </script>

After
^^^^^^^^^^^^^^^^^^^

When we execute this script the document will be already loaded so we need to change the previous code with the following,
in order to correctly load the necessary libraries before executing any functions declared inside them.
We use *PmisJsLoader* and we attach an handler that is executed only after the required libraries are loaded.

::

    PmisJsLoader.loadModule(["https://www.google.com/jsapi", "/ext/d3/d3.v3.min.js"], 
    // the handler
    function(){
        // initialize google chart and on callback create the chart
        google.load('visualization', '1', {packages: ['corechart'], callback: function(){

            // do something here
            drawVisualization();

        }});
    });


.. note:: 
    These are some changes required to correct some of the problems above:

    | ``\$\(document\)(\.on\(["'].*["'],[\s]*function\()(?:[\s]*e,[\s]*)?(.*\))`` => ``pmis$1$2``
    | ``(\$\([\s]*window[\s]*\)\.on\(["'])resize(?!\.pmis)(\..*)?(["'],[\s]*function\(.*\))`` => ``$1resize.pmis$3``
    | ``(\$\([\s]*window[\s]*\)\.)resize\(([\s]*function[\s]*\(\))`` => ``$1on('resize.pmis', $2``

    You should replace the left regular expression with the right replacement string