.. highlight:: properties

.. _system-properties:

System Properties
=================


Base/System Properties
-----------------------------------------------------------------

::

	# Define Common Settings
	system.domain=URL
	
	system.project.id=
	system.project.name=
	
	# Define the default locale (language)
	system.locale=ko_KR
	
	# Define Paths
	system.log=C:/Users/Disco/workspace_egov/log/error
	system.errorpage=/pmis/STND_PMIS/common/error/Error.jsp
	system.endsession=/pmis/STND_PMIS/common/def/EndSession.jsp
	system.blankpage=/pmis/STND_PMIS/common/def/BlankFrame.jsp
	system.doingpage=/pmis/STND_PMIS/common/def/DoingFrame.jsp
	
	# Define default login magic-key and user id/password (blank to none)
	system.master.id=kspmisadmin
	system.logout.enable=yes
	system.devmode=false
	
	# Define Common Code/Key.
	system.eis_pjt_cd=TOC
	system.std_pjt_cd=STND_PMIS
	system.pjt_cd=SANGAH
	system.loginpage.home=
	
	# Define the folder that will be used to style the project select page (root: /ext/style) 
	system.pjtselect.style.home=LG_DSN1
	
	# Number of admissible login attempts before the user is locked
	system.login.attempts=5
	
	# Max idle time a session will be valid in seconds
	system.maxidletime=3600

Password Validation Properties
--------------------------------

::

	system.pwd.length=8

	# ADMISSIBLE_CHECK
	# 1: lowercase letters
	# 2: capital letters
	# 3: numbers
	# 4: special characters
	
	# lowercase or capital + number required
	system.pwd.check=13,23,134,234,123,1234
	
	# lowercase + upper + number required
	#system.pwd.check=123,1234
	
	# lowercase or capital required
	#system.pwd.check=12,13,123,1234,124,134,23,234
	
	# Max life for user password (days)
	system.pwd.maxlife=90
	
Zip Encoding
-----------------

::

	#@@ default language for zip file encoding
	#   - euc-kr (Korean encoding)
	#   - cp437 (Typical Western European encoding)
	#   - gb437 (Chinese encoding)
	#   - shift-jis (Japanese encoding)
	#   - cp1252 (Windows Western European encoding)
	system.zip.upload.encoding=euc-kr
	system.zip.download.encoding=utf-8
	

DB Connection Info Properties
-----------------------------------------------------------------

::

	db.DriverClassName=core.log.jdbc.driver.OracleDriver
	#db.DriverClassName=oracle.jdbc.driver.OracleDriver
	#db.DriverClassName=com.p6spy.engine.spy.P6SpyDriver
	
	db.Url=jdbc:oracle:thin:@URL:PORT:SID
	db.Username=
	db.Password=
	
	db.MaxIdle=20
	db.MaxActive=50
	db.RemoveAbandoned=true
	db.RemoveAbandonedTimeout=30
	db.LogAbandoned=false

Default Locale
--------------------

::

	default_locale=en_US

Common Modules (appliables for each program modules)
-----------------------------------------------------------------

::

	common.path.underconst=/pmis/STND_PMIS/common/def/Unknown.jsp
	common.path.style=/ext/style

EDMS Module
-----------------------------------------------------------------

::
	
	# Define Common Options
	edms.PathLog=C:\\Users\\Disco\\workspace_egov\\log\\edms
	
	edms.PathRoot=C:/Users/Disco/workspace/edms
	edms.stPathRoot=C:/Users/Disco/workspace/edms
	edms.WebRoot2=/data/edms


Others
-------

::

	milestone.xml.root=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/data/xml/milestone
	xml.root=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/Main/assets
	devnote.home=C:\\Users\\Disco\\workspace\\devnote

Groupware Module
-----------------------------------------------------------------

::
	
	# Define Paths
	gw.PathWeb=
	
	# Define about Cyman UDP Message Information
	gw.AlimiServer=
	gw.AlimiPort=
	gw.AlimiProgram=YRPCMIS
	
	# Define about SMS (DO NOT APPLY VALUES AT THE OPERATION SERVER)
	gw.SMSServer=
	gw.SMSPort=
	gw.SMSAuthorId=
	gw.SMSAuthorPass=


System SMTP Mail Configuration
--------------------------------
	
::
	
	system.mail.transport.protocol=smtp
	system.mail.smtp.host=smtp.gmail.com
	system.mail.smtp.port=465
	system.mail.smtp.socketFactory.class=
	system.mail.authid=
	system.mail.authpwd=

.. warning:: The following properties are deprecated:
	
	::
	
		Gmail.getAuthId=
		Gmail.getAuthPw=
		
User Mail Module
----------------

::
	
	# enable the link mail module
	user.setting.mail.enabled=true
	
	# user email server
	user.setting.mail.host=pop.gmail.com
	user.setting.mail.port=995
	user.setting.mail.protocol=imap
	

ezpert Module
-----------------------------------------------------------------

::
	
	ezpert.ip=
	ezpert.port=


Pdf Converter
----------------

::
	
	# Define HTML PDF converter
	coverter.htmltopdf=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/util/pdf/


Thumbnails & Temporary Folders
-------------------------------	
	
::

	# Thumb converter temp path
	thumb.temp=C:/Users/Disco/workspace/temp
	# Main temporary path
	upload.temp=C:/Users/Disco/workspace/temp

excel & eMail & SMS template
-------------------------------
	
::

	template.home=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/data/template
	email.template.home=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/data/template
	excel.template.home=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/WEB-INF/excelTemplete
	
Edms server mirroring
------------------------

::

	mirror.server=SERVER3

Auto login for development env.
--------------------------------

::

	autologin.user_no=
	autologin.password=
	autologin.pjt_cd=
	

Terms of Use
----------------------	
	
::

	#@@ TERMS OF SERVICE PROPERTIES
	tos.enabled=true
	tos.redirect.url=/pmis/STND_PMIS/tos/index.jsp
	tos.exclude.path=/Core/CoreUpdate.action,/pmis/STND_PMIS/tos/**
	
	
Document & Workflow
----------------------

::

	#@@ Document ID generation service availables: documentIdGnrService (default), pmisDocumentIdGnrService
	doc.idgnr.service.name=documentIdGnrService
	
	#@@ Default ID generation service format token available: ${ENTPRS} ${FBS} ${YEAR} ${PJT_CD}
	doc.idgnr.format=${ENTPRS}-${FBS}-${YEAR}-
	doc.idgnr.required=true
	
	#@@ View by Organization or Private
	#doc.authorization.mode=ORG|PRIVATE
	doc.authorization.mode=ORG
	
	#@@ Drawings View by Organization or All
	#register.authorization.mode=ALL|ORG
	register.authorization.mode=ORG
	
	#@@ Register Doc. No. generation service
	register.idgnr.service.name=registerIdGnrService
	
Document Notification Template
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

	#@@ Document eMail Notification Template
	doc.noti.email.received=noti_doc_recv.html
	doc.noti.email.waitapprove=noti_doc_wait_app.html
	doc.noti.email.trn.waitreview=noti_trn_wait_review.html
	
	#@@ Document SMS Notification Template
	doc.noti.sms.received=sms_noti_doc_recv.txt
	doc.noti.sms.waitapprove=sms_noti_doc_wait_app.txt
	doc.noti.sms.trn.waitreview=sms_noti_trn_wait_rev.txt

Module Workflow/Transmittal Enable/Disable
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::
	
	workflow.disabled=false
	transmittal.disabled=false

Aconex Dashboard
-----------------

::
	
	#@@ Temporary authentication parameters for aconex dashboard
	aconex.auth.username=
	aconex.auth.password=
	aconex.auth.project=
	
DEPRECATED PROPERTIES
-------------------------

.. warning:: These properties will be removed soon or later...

::

	#@@ Inside jsp replace these properties with RequestUtil.getWebRoot
	#@@ ex: <%=RequestUtil.getWebRoot() %>/data/edms
	system.WebRoot=http://URL
	edms.WebRoot=http://URL/data/edms
	common.path.activex=http://URL/ext/activex
	common.path.plugin=http://URL/plugin
	
	Gmail.getAuthId=
	Gmail.getAuthPw=