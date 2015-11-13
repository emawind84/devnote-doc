.. highlight:: rest
.. index:: REST
.. sectionauthor:: Emanuele Disco <emanuele.disco@gmail.com>
.. _restructured-text-example:

============================
Example for reStructuredText
============================

.. versionadded:: 2.5

--------------

Take a look at the rest specification at this `link <http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html>`_. ::

	To make a link you can use the embedded URI method:
	
		`link label <http://example.com/>`_
		
	or the recommended hyperlink target method:
	
		`link`_
		
		.. _link: http://example.com


This one too is a `link <http://example.com>`__ but is an `Anonymous Hyperlink`__.

.. __: http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html#anonymous-hyperlinks

--------------------

.. _thisis-a-subsection:

--------------------
This is a subsection
--------------------

We can reference this page with this link :ref:`restructured-text-example` everywhere in this documentation. ::

	:ref:`restructured-text-example`

--------------------

**Java String Object will remove the leading zero if a number is returned without formatting**

--------------------

This is a code sample ``test``.
 
fix::

	> RTRIM(TO_CHAR(PLAN_RATE, 'FM99990D99'), '.') PLAN_RATE
 
reference::

	http://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements004.htm
	http://www.techonthenet.com/oracle/functions/rtrim.php

--------------------

We can put images too!

.. image:: _images/example.gif

.. _sample-code:

##############
This is a Part
##############

This is a reference to a previous section `thisis-a-subsection`_.

---------------

This is an html code example:

.. code-block:: html

   <html>
      <body>Ciao</body>
   </html>

..and this one is a javascript code sample:

:subscript:`For code-block blocks, a linenos flag option can be given to switch on line numbers for the individual block`

.. code-block:: javascript
   :linenos:

	var ids = grid.jqGrid('getDataIDs');
	for(var i = 0; i < ids.length; i++ ){
		var ret = grid.jqGrid('getRowData', ids[i]);
		params.push({ name: "seq", value: ret.hist_seq });
	}

	$.ajax({
		url: "/Doc/RegisterAddAuth.action",
		data: params,
		type: "POST"
	}).done(function(){
		pmis.successMessage('<sangah:msg id="message.0546" />');
	});

.. This is a comment you will not see it!

.. note:: This is a note admonition.

   This is the second line of the first paragraph.

   - The note contains all indented body elements following.
   - It includes this bullet list.

.. warning:: This is a warning!!!

.. important:: This is really important!!!

.. tip:: This is a tip!

"""""""""
Paragraph
"""""""""

Lorem ipsum [Ref]_ dolor sit amet.

.. [Ref] Book or article reference, URL or whatever.


+--------------+----------+-----------+-----------+
| row 1, col 1 | column 2 | column 3  | column 4  |
+--------------+----------+-----------+-----------+
| row 2        |                                  |
+--------------+----------+-----------+-----------+
| row 3        |          |           |           |
+--------------+----------+-----------+-----------+


Link to a file
""""""""""""""""""

This is a link to a file `SAH-CI-INIT-1001(A)-D.pdf <_static/SAH-CI-INIT-1001(A)-D.pdf>`_

This is another link to a file `SAH-CI-INIT-1001(A)-D.pdf`_:

.. _SAH-CI-INIT-1001(A)-D.pdf: _static/SAH-CI-INIT-1001(A)-D.pdf


Add some index!
"""""""""""""""""

::

	.. index::
	   single: execution; context
	   module: __main__
	   module: sys
	   triple: module; search; path
	   see: entry; other
		   
	This is a normal reST :index:`paragraph` that contains several
	:index:`index entries <pair: index; entry>`.