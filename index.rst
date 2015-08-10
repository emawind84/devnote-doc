.. SangAh Development Note documentation master file, created by
   sphinx-quickstart on Mon Aug 10 00:04:35 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

SangAh Development Note
==============================================

.. _learn git:

.. seealso:: 
    Learn about git
    
    - http://rogerdudler.github.io/git-guide/

.. seealso:: 
    Learn about reStructuredText Markup

    - http://sphinx-doc.org/rest.html#explicit-markup
    - http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html

How to edit this documentation
-------------------------------

.. note::
    
    Start installing python version 2.7::
    
        Go here and download version 2.7 https://www.python.org/downloads/
        
    Open Windows Powershell as Administrator::
    
        Run >> powershell.exe
    
    Create a folder where you want::
    
        C:\> mkdir devnote
    
    Install the plugin virtualenv using pip::
    
        > C:\Python27\Scripts\pip.exe install -U virtualenv
    
    Go to the folder you created (*C:/devnote*)::
    
        > cd C:\devnote
        PS C:\devnote>
        
    Disable windows signature policy for local stuff, just run::
    
        PS C:\devnote> Set-ExecutionPolicy RemoteSigned
        
    Create a virtual environment for python:: 
    
        PS C:\devnote> C:\Python27\Scripts\virtualenv.exe sphinx
        
    A new folder named *sphinx* will be created, then activate the new environment, run::
    
        PS C:\devnote> .\sphinx\Scripts\activate
        
    Now if everything work you will have a shell like this::
    
        (sphinx) PS C:\devnote>
        
    Download the source from git using this URL: https://github.com/emawind84/devnote-doc.git ( see :ref:`Learn about git <learn git>` )
    and put it in a folder inside *devnote* and run::
    
        (sphinx) PS C:\devnote\doc> .\make.bat html
        
    The documentation will be built and a new folder *_build* will be created inside the current folder.
    You can edit *rst* file and then build again, the documentation will be updated.

Contents:
---------

.. toctree::
   :maxdepth: 1

   restructured-text-example
   add-leading-zero-to-query-data
   arguments-validation-java-class
   attributes-and-custom-properties-in-html
   baseaction
   cascading-order-and-inheritance-in-css
   checkduple-action
   checked-versus-unchecked-exceptions
   code-conventions-for-the-java
   comm_attch_file-specification-doc-format
   commonservice-savecontenttofile
   compress-javascript-file-(-javascript-compressor-)
   content-disposition-and-encodings
   copy-table-data-query
   coreaction---nosessioncoreaction
   cross-browser-javascript-fix
   css3-box-sizing
   daum-editor
   daum-editor-checkbox-radiobox-popup
   daum-editor-functions-and-events
   declaring-character-encodings-in-css
   declaring-variables-before-or-in-loop
   drop-table-constraints
   filecopyinterceptor
   flexgrid-remove-multiple-rows
   fluid-layout
   framework-configuration
   functions-call-bind-apply
   good-css-for-html--body-element
   grid-excel-export
   html-javascript-css-formatter
   html-compressor-online-tool
   html5-standard-specification-website
   i18ninterceptor
   ibatis-and-hashmap
   input-mask
   java-concurrency-(multi-threading)---tutorial
   java-regex-test-page
   jqgrid-custom-formatter
   jqgrid-custom-select-row
   jqgrid-default-options
   jqgrid-draggable-tree-(-change-row-position-)
   jqgrid-find-clicked-column-by-name
   jqgrid-footer-row-(-total-row-)
   jqgrid-getlocalrow-vs-getrowdata
   jqgrid-paging-example
   jqgrid-save-editing-row-before-request
   jqgrid-search
   jqgrid-settings-object-content-example
   jquery-ajax
   jquery-calendar-(-datepicker-)
   jquery-dialog
   jquery-dialog-as-qtip
   jquery-dialog-reload-page-(-useful-for-paging-in-dialog-)
   jquery-grid-(jqgrid)
   jquery-plugin-how-to-create-a-plugin
   jquery-tooltip-qtip2
   json-tags
   jsoninterceptor
   jstl-javaserver-pages-standard-tag-library
   linux-rsync-merge-folder--symbolic-link
   load-select-options-using-ajax-and-coreaction
   main-page-header-content-example
   modalwindow---jquery-dialog
   new-note
   ognl-variable-name-and-get-set-problem
   oracle-overall-result-hierarchical-query-template
   parameters-class
   pmis-z-index-settings
   pmis.trigger-(-ex-dojo-topic-)
   preparableinterceptor
   project-main-folder-creation
   sessioninterceptor
   spring-security-2
   ssl-tomcat-configuration
   strict-mode-and-immediately-invoked-function-expression
   tabs-sangah-widget
   temporaryfileaction
   temporaryfileservice
   thread-management
   top-message-box
   transactioninterceptor
   unwrapexceptionmappinginterceptor
   uploadaction
   uploading-file-process
   useful-javascript-functions
   user-info
   wrapper-for-main-page
   xmlinterceptor-(-how-to-call-another-projects-action-)
   media-types-official-list-(contenttype)



Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

