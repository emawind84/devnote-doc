.. highlight:: properties

.. _system-properties:

System Properties
=================

Development Mode
--------------------------------

    **system.devmode=false**
        Important for disable static file caching, alwasy true in development!

.. important:: Remember to set false this property to enable caching for the user!


Default Login Page
---------------------------

    **system.loginpage.home=<PROJECT>**
        Define the location where to look for the Login.jsp (<PROJECT>/main/Login.jsp)
    
.. important:: 
    If a file ``Login.jsp`` is not present inside ``<PROJECT>/main/`` folder,
    the default login page will be used ( ``STND_PMIS/main/Login.jsp`` )
    
    
Projects Select Page Style
---------------------------

    **system.pjtselect.style.home={DESIGN_FOLDER}**
        The home to the style for the project list page
        (root: ``/ext/style/{DESIGN_FOLDER}``) 
    
.. important:: Make sure the file ``/ext/style/{DESIGN_FOLDER}/pjtselect.css`` exists!


Base/System Properties
-----------------------------------------------------------------

    **system.domain=<HOST>**
    
    **system.project.id**

    **system.project.name**
    
    **system.log=C:/Users/Disco/workspace_egov/log/error**

    **system.errorpage=/pmis/STND_PMIS/common/error/Error.jsp**

    **system.endsession=/pmis/STND_PMIS/common/def/EndSession.jsp**
    
    **system.blankpage=/pmis/STND_PMIS/common/def/BlankFrame.jsp**
    
    **system.doingpage=/pmis/STND_PMIS/common/def/DoingFrame.jsp**
    
    **system.master.id=<MASTER USER>**

    **system.logout.enable=yes**
    
    **system.eis_pjt_cd=TOC**
    
    **system.std_pjt_cd=STND_PMIS**
    
    **system.pjt_cd=SANGAH**
        The project that will be used as *root* project.
    
    **system.login.attempts=5**
        Number of admissible login attempts before the user is locked.
    
    **system.maxidletime=3600**
        Max idle time a session will be valid in seconds.


Password Validation Properties
--------------------------------

    **system.pwd.length=8**

    **system.pwd.check=13,23,134,234,123,1234**
        The password required characters
        
        | ADMISSIBLE_CHECK
        | # 1: lowercase letters
        | # 2: capital letters
        | # 3: numbers
        | # 4: special characters

        | # lowercase + upper + number required
        | #system.pwd.check=123,1234
    
        | # lowercase or capital required
        | #system.pwd.check=12,13,123,1234,124,134,23,234
    
    **system.pwd.maxlife=90**
        Max life for user password (days)


Default Language (Locale)
--------------------------

    **system.locale=en_US**
        Define the default locale (language)


Zip Encoding
-----------------

    **system.zip.upload.encoding=euc-kr**
        | #@@ default language for zip file encoding
        | #   - euc-kr (Korean encoding)
        | #   - cp437 (Typical Western European encoding)
        | #   - gb437 (Chinese encoding)
        | #   - shift-jis (Japanese encoding)
        | #   - cp1252 (Windows Western European encoding)

    **system.zip.download.encoding=utf-8**
    

DB Connection Info Properties
-----------------------------------------------------------------

    **db.DriverClassName=oracle.jdbc.driver.OracleDriver**
    
    **db.Url=jdbc:oracle:thin:@URL:PORT:SID**

    **db.Username**

    **db.Password**

    **db.MinIdle=20**
    
    **db.MaxIdle=50**

    **db.MaxTotal=300**


Common Modules (appliables for each program modules)
-----------------------------------------------------------------

    **common.path.underconst=/pmis/STND_PMIS/common/def/Unknown.jsp**

    **common.path.style=/ext/style**


EDMS Module
-----------------------------------------------------------------

    **edms.PathLog=/var/log/edms**
        Deprecated location of the edms log
    
    **edms.PathRoot=/edms**
        Location of the edms folder

    **edms.stPathRoot=/edms**
        Deprecated same as above

    **edms.WebRoot2=/data/edms**
        This is the web location, should not be changed


Others
-------

    **milestone.xml.root=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/data/xml/milestone**
    
    **xml.root=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/Main/assets**


Groupware Module
-----------------------------------------------------------------

    **gw.PathWeb**
    
    **gw.AlimiServer**

    **gw.AlimiPort**

    **gw.AlimiProgram=YRPCMIS**
    
    **gw.SMSServer**

    **gw.SMSPort**

    **gw.SMSAuthorId**

    **gw.SMSAuthorPass**


System SMTP Mail Configuration
--------------------------------
    
    **system.mail.smtp.host=smtp.gmail.com**

    **system.mail.smtp.port=25**

    **system.mail.smtp.ssl.enable=false**

    **system.mail.authid**

    **system.mail.authpwd**

.. warning:: The following properties are deprecated:
    
    **Gmail.getAuthId**

    **Gmail.getAuthPw**
    
        
User Mail Module
----------------

    **user.setting.mail.enabled=true**
        # enable the link mail module

    # user email server

    **user.setting.mail.host=pop.gmail.com**

    **user.setting.mail.port=995**

    **user.setting.mail.protocol=imap**
    

ezpert Module
-----------------------------------------------------------------

    **ezpert.ip**

    **ezpert.port**


Pdf Converter
----------------

    **coverter.htmltopdf=<HTMLTOPDF HOME>**
        # Define HTML PDF converter


Thumbnails & Temporary Folders
-------------------------------    
    
    **thumb.temp=C:/Users/Disco/workspace/temp**
        # Thumb converter temp path

    **upload.temp=C:/Users/Disco/workspace/temp**
        # Main temporary path

excel & eMail & SMS template
-------------------------------

    **template.home=<PROJECT>/web/data/template**

    **email.template.home=<PROJECT>/web/data/template**
    
    **excel.template.home=<PROJECT>/web/WEB-INF/excelTemplete**


File Upload Handler
-----------------------------

    **system.upload.handler=nginx**
        The only value available is ``nginx``, leave empty for default


Edms server mirroring
------------------------

    **mirror.server=SERVER3**


Auto login for development env.
--------------------------------

    **autologin.user_no**

    **autologin.password**

    **autologin.pjt_cd**
    

Terms of Use
----------------------    
    
    **tos.enabled=true**

    **tos.redirect.url=/pmis/STND_PMIS/tos/index.jsp**
    
    **tos.exclude.path=/Core/CoreUpdate.action,/pmis/STND_PMIS/tos/**

    
Document
----------------------

    **doc.idgnr.service.name=documentIdGnrService**
        Document ID generation service availables: documentIdGnrService (default), pmisDocumentIdGnrService
    
    **doc.idgnr.format=${ENTPRS}-${FBS}-${YEAR}-**
        Default ID generation service format token available: 
        ``${ENTPRS}`` ``${FBS}`` ``${YEAR}`` ``${PJT_CD}``

    **doc.idgnr.required**
        Define if auto numbering is mandatory.
        Accepted values are ``false``, ``0``, ``no``, ``<empty>`` for false and any other for true.
    
    **doc.authorization.mode=ORG**
        | View by Organization or Private
        | values: ``ORG``, ``PRIVATE``
    
    **register.authorization.mode=ORG**
        | Register view by Organization or All
        | values: ``ALL``, ``ORG``
    
    **register.idgnr.service.name=registerIdGnrService**
        #@@ Register Doc. No. generation service
        
    **register.module.wbslink.enabled**
        Enable WBS/Activity Link Module for Document Register
    
    **doc.tags.enabled**
        Enable Tags for document (User can add tags/labels to the document)

Document Notification Template
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    Document eMail Notification Template

    **doc.noti.email.received=noti_doc_recv.html**

    **doc.noti.email.waitapprove=noti_doc_wait_app.html**

    **doc.noti.email.trn.waitreview=noti_trn_wait_review.html**

    Document SMS Notification Template

    **doc.noti.sms.received=sms_noti_doc_recv.txt**

    **doc.noti.sms.waitapprove=sms_noti_doc_wait_app.txt**

    **doc.noti.sms.trn.waitreview=sms_noti_trn_wait_rev.txt**


Workflow & Transmittal
----------------------------------------

    **workflow.disabled=false**
        Disable the workflow module

    **transmittal.disabled=false**
        Disable transmittal module
    
    **workflow.autoskip.timeout=30**
        The workflow is moved to the next step after the specified timespan in days.
        The counter for the defined period start after the step enter in overdue state.

    **workflow.autoskip.exclude_groups=WF_HOLDER**
        If a reviewer belongs to one of the specified groups, 
        the workflow is not moved automatically to the next step
        after the specified timespan with **workflow.autoskip.timeout**.


PhantomJS Document HTML Content Builder
------------------------------------------

    **phantomjs.executable=<PHANTOM HOME>/bin/phantomjs.exe**
        PhantomJS executable

    **phantomjs.script.docexport=<PROJECT>/web/pmis/STND_PMIS/doc2/script/pmis_doc_export.js**
        PhantomJS script for document PDF conversion process


Aconex Dashboard
-----------------

    #@@ Temporary authentication parameters for aconex dashboard

    **aconex.auth.username**

    **aconex.auth.password**

    **aconex.auth.project**

Activities Group & Sort
-----------------------------
    
    **group.use.default**
        Define whether to use global setting (set by master user).

    **group.use.menu_cd**
        Define whether to use profile per menu or one common profile amongst every menu.


SSL/TLS KeyStore Properties
------------------------------

    **ssl.keystore.password**
        The keystore password (shared between keystore and truststore file!).
        The keystore password should be the same as the private key password.

    **ssl.keystore.path**
        The path to the keystore containing client certificate and private key.

    **ssl.truststore.path**
        The path to the certificate authority in keystore format.


Elasticsearch Properties
--------------------------------

    **elasticsearch.ssl.enabled**
    
    **elasticsearch.host**

    **elasticsearch.port**

    **elasticsearch.username**

    **elasticsearch.password**


Biztalk Kakao Service Properties
--------------------------------------

    **biztalk.noti.doc.received**

    **biztalk.noti.msg.received**

    **biztalk.noti.doc.review**

    **biztalk.noti.doc.approval**

    **biztalk.noti.pw.change**

    **biztalk.noti.pw.reset**

    **biztalk.noti.workflow.status.change**

    **biztalk.noti.actmulti.weekly.app**

    **biztalk.noti.actmulti.monthly.app**

    **biztalk.domain**

    **biztalk.accessToken**

    **biztalk.senderKey**


DEPRECATED PROPERTIES
-------------------------

.. warning:: These properties will be removed soon or later...

    #@@ Inside jsp replace these properties with RequestUtil.getWebRoot
    #@@ ex: <%=RequestUtil.getWebRoot() %>/data/edms
    
    **system.WebRoot=http://URL**

    **edms.WebRoot=http://URL/data/edms**

    **common.path.activex=http://URL/ext/activex**

    **common.path.plugin=http://URL/plugin**

    **Gmail.getAuthId=**

    **Gmail.getAuthPw=**
