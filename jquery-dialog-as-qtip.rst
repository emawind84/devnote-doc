.. _jquery-dialog-as-qtip:

=====================
jQuery Dialog As Qtip
=====================

.. code-block:: css
    
    .dialogtip_wrapper{position: absolute;top:0;left:0}
    .dialogtip_wrapper .pos{display: inline-block;margin: 10px;}
    .dialogtip{display: inline-block !important;left: 0 !important;position: relative;top: 0 !important;}

.. code-block:: javascript
    
    var wrp = $('.dialogtip_wrapper');
    if( !wrp.length ) {    
        wrp = $('<div class="dialogtip_wrapper"></div>').appendTo('body');
    }
    
    var pos = $('<div class="pos">').appendTo( wrp );
    pmis.openDialog({ modal: false, appendTo: pos, dialogClass: "dialogtip", 
        close: function(){
            $(this).closest('.pos').remove();
        } 
    });
