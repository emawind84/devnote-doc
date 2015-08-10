.. _jqgrid-paging-example:

=====================
jqGrid Paging Example
=====================




<div class="grid_area" style="min-width: 100%; width: 100%">
    <table id="compList" cellpadding="0" cellspacing="0" width="100%" height="100%"></table>
</div>
<div class="paging_area">
    <table border="0" style="width:100% ;height: 30px">
    <tr>
        <td style="height:1px; padding-top:0px; padding-bottom:0px; border:1px solid #CDCDCD; border-top-width:0px; background-color: #F7F6DA; ">
            <c:import url="/ml/common/def/paging_html5.jsp"></c:import>
        </td>
    </tr>
    </table>
</div>


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

