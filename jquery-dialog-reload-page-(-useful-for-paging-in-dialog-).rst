.. _jquery-dialog-reload-page-(-useful-for-paging-in-dialog-):

=========================================================
jQuery Dialog Reload Page ( useful for paging in dialog )
=========================================================




.. note:: [IMPORTANT For jQuery Dialog implementation see: JQUERY Dialog paragraph.]

In case a list with paging is loaded into a jQuery Dialog is possible to reload the list with the following function: 

popdialog.cmdReload({ ... });

popdialog object is implemented in CommonPopDiaolog.jsp


Example:
------------------------------------------------------------------

.. code-block:: javascript

    var params = {
        "pageNo": [pageNo],
        "srchDiv": [srchDiv],
        "srchText": [srchText]
    };
    if( typeof popdialog !== "undefined" && popdialog.cmdReload && $.isFunction(popdialog.cmdReload)) {
        // used in case this jsp is loaded into a jQuery Dialog ( CommonPopDialog.jsp will reload this jsp )
        popdialog.cmdReload(params);
    } else {
        // used in case this jsp is loaded as normal page ( the main jsp will reload this page )
        pmis.trigger("conscomplist/reload", params);
    }

.. note:: [NOTE CommonPopDialog already know how to call this jsp so is enough to send only new parameters ( pageNo, srch... )]

REFERENCE::
 
    PopConsCompList.jsp
    CommonPopDiaolog.jsp

