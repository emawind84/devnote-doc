.. _jqgrid-save-editing-row-before-request:

======================================
jqGrid Save Editing Row Before Request
======================================


// required before send jqgrid data to the server or the editing cell value will not be passed!
// 이거 안 하면 마지막 셀 입력된값 전송안됨.

::

    $('#dtCodeList').jqGrid('saveEditingCell'); /* save cell first! IMPORTANT! */

.. seealso:: common.js  saveEditingCell function