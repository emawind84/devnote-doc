.. _wrapper-for-main-page:

=====================
Wrapper for main page
=====================




The wrapper.jsp page in the inc folder will create a wrapper around body content in order to generate top, left and right menu including title.
In future projects in case the design change will be enough to change the wrapper page.

declaration to include:

.. code-block:: jsp

    <%@ include file="/ml/inc/wrapper.jsp"%>

The following wrapper will be generated around the content:

.. code-block:: jsp

    <%@ include file="/ml/main/${login.pjt_cd}/Top.jsp" %>
    <div id="load_contents" class="clearfix">
        <div id='wrap_left'>
            <script type="text/javascript">leftNaviLoad("<%=top_menu_nm%>","<%=top_menu_cd%>", "<%=menu_cd%>");</script>
        </div>
        <div id="load_subContents" class="clearfix"> 
            <div class="wrap_sub" >
                <%@ include file="/ml/main/${login.pjt_cd}/Title.jsp" %>
                [CONTENT]
            </div>
        </div>
    </div>
    <div id="quick_right">
        <img src="/pmis_html/images/right/sample.gif" alt="">
    </div>

.. note:: [NOTE Only the CONTENT is necessary in the page, the wrapper will be generated automatically around the content]

EXAMPLE::
    
    /powerpmis/web/ml/system/pwer/PwerGrp.jsp
    /powerpmis/web/ml/system/pwer/PwerMenu.jsp
    /powerpmis/web/ml/progress/designstep/DesignStepMain.jsp

