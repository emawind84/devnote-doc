.. _jqgrid-paging-example:

=====================
jqGrid Paging Example
=====================


.. code-block:: html
    
    ...
    <div class="grid_area" style="min-width: 100%; width: 100%">
        <table id="compList" cellpadding="0" cellspacing="0" width="100%" height="100%"></table>
    </div>
    <div class="paging_area">
    	<c:import url="/pmis/STND_PMIS/common/def/paging_html5.jsp"></c:import>
    </div>

.. code-block:: javascript
    
    $(function(){
        function cmdPage( pageNo ){
            pmis.trigger("complist/reload", {
                "pageNo": pageNo,
                ...
            }); 
        }
        
        $('.pmis-pageutil-link', '#complaintListForm' ).click(function(){
            cmdPage( $(this).data('page') );
        });
        
    });

