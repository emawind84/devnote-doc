.. highlightlang:: rest

.. _restructured-text-example:

============================
Example for reStructuredText
============================

.. versionadded:: 2.5

--------------

Take a look at the rest specification at this `link <http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html>`_. ::

	`link label <http://example.com/>`_

.. _thisis-a-subsection:

--------------------
This is a subsection
--------------------

We can reference this page with this link :ref:`restructured-text-example` everywhere in this documentation. ::

	:ref:`restructured-text-example`


**Java String Object will remove the leading zero if a number is returned without formatting**

This is a paragraph that contains `a link`_.

.. _a link: http://example.com

This one too is a `link <http://example.com>`_.

This is a code sample ``test``.
 
fix::

	> RTRIM(TO_CHAR(PLAN_RATE, 'FM99990D99'), '.') PLAN_RATE
 
reference::

	http://docs.oracle.com/cd/B19306_01/server.102/b14200/sql_elements004.htm
	http://www.techonthenet.com/oracle/functions/rtrim.php


.. _sample-code:

##############
This is a Part
##############

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
