.. SangAh Development Note documentation master file, created by
   sphinx-quickstart on Mon Aug 10 00:04:35 2015.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

SangAh Development Note
==============================================

.. _learn git:

.. seealso:: Learn about git
    
    - http://rogerdudler.github.io/git-guide/

.. seealso:: Learn about reStructuredText Markup

    - http://sphinx-doc.org/rest.html#explicit-markup
    - http://docutils.sourceforge.net/docs/ref/rst/restructuredtext.html
    - http://docutils.sourceforge.net/docs/user/rst/quickref.html

How to edit this documentation
-------------------------------

.. note::
    
    Start installing python version 2.7 from here https://www.python.org/downloads/
        
    Open Windows Powershell as Administrator::
    
        Run >> powershell.exe
    
    Create a folder where you want::
    
        C:\> mkdir devnote
    
    Install the plugin virtualenv using pip::
    
        > C:\Python27\Scripts\pip.exe install -U virtualenv
    
    Go to the folder you created (*C:/devnote*)::
    
        > cd C:\devnote
        PS C:\devnote>
        
    Create a virtual environment for python:: 
    
        PS C:\devnote> C:\Python27\Scripts\virtualenv.exe sphinx
    
    A new folder named *sphinx* is created and will contains an isolated working Python environments ready to use.
    See `Virtualenv <https://virtualenv.pypa.io/en/latest/>`_ for more info.
        
    Disable Windows signature policy in order to run the next command or you might get an exception::
    
        PS C:\devnote> Set-ExecutionPolicy RemoteSigned
     
    Then activate the new environment with the following command::
    
        PS C:\devnote> .\sphinx\Scripts\activate
        
    Install `Sphinx`_ with pip command::
    
        PS C:\devnote> pip.exe install -U Sphinx        
        
    Now if everything is good you will have a shell like this::
    
        (sphinx) PS C:\devnote>
        
    Using Subversion or Git ( :ref:`Learn about git <learn git>` ) copy the documentation from here 
    https://github.com/emawind84/devnote-doc.git inside the folder you created and then from that folder type::
    
        (sphinx) PS C:\devnote\doc> .\make.bat html
        
    The documentation will be built and a new folder *_build* will be created inside the current folder.
    You can edit *rst* file and then build again, the documentation will be updated.
    
    After the powershell is closed the virtual environment will be lost, 
    the next time you open the powershell, if you want to build the doc, make sure you run the following command inside *devnote*::
    
        PS C:\devnote> .\sphinx\Scripts\activate
        (sphinx) PS C:\devnote\doc> .\make.bat html

.. seealso:: `[Python] 스핑크스(sphinx)를 이용한 파이썬 API 문서화 <http://egloos.zum.com/mcchae/v/11080328>`_

Contents:
---------

.. toctree::
   :maxdepth: 1

   pmis-framework-training
   howto-oracledb-user-import&export
   pmis-manual-howto
   tomcat-conf-howto
   java-session-user-hasrole
   java-background-job
   aconex-basic-training-agenda
   oracle-listagg-example
   oracle-install-centos
   pmis-file-manager
   oracle-tablespace-schema-howto
   doc-list-main-readme
   db-backup-script
   ckeditor-how-to
   db-version-control-update-script
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
   ognl-variable-name-and-get-set-problem
   oracle-overall-result-hierarchical-query-template
   parameters-class
   pmis-z-index-settings
   pmis.trigger-(-ex-dojo-topic-)
   preparableinterceptor
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
   system-properties

Python Scripts:
-----------------

.. note::

    .. include:: python-example-header.txt

.. toctree::
   :maxdepth: 1
   :glob:
   
   python_scripts/*
   
   

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

.. _Sphinx: http://sphinx-doc.org/