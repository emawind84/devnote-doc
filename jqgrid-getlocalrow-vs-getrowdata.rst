.. _jqgrid-getlocalrow-vs-getrowdata:

================================
jqGrid getLocalRow vs getRowData
================================

.. js:function:: getRowData

   Use this function when data is local (set by the user)
   
.. js:function:: getLocalRow

   Use this function when the data is from the server (fetched from the server by jqGrid)

.. note:: If jqGrid use datatype *json* (ajax request with *url* and *postData*) and loadonce is false use :js:func:`getRowData` !

.. note:: If jqGrid use datatype *json* (ajax request with *url* and *postData*) and loadonce is true use :js:func:`getLocalRow` !

.. note:: if jqGrid use datatype *local* use :js:func:`getLocalRow`