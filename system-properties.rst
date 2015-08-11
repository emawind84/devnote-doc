.. _system-properties:

System Properties
=================


Base/System Properties
-----------------------------------------------------------------

.. code-block:: properties

	# Define Common Settings
	system.domain=URL
	
	system.project.id=
	system.project.name=

	
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
	
	# ADMISSIBLE_CHECK
	# 1: lowercase letters
	# 2: capital letters
	# 3: numbers
	# 4: special characters
	system.pwd.length=8
	system.pwd.check=123,1234

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

.. code-block:: properties

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


Common Modules (appliables for each program modules)
-----------------------------------------------------------------

.. code-block:: properties

	common.path.underconst=/pmis/STND_PMIS/common/def/Unknown.jsp
	common.path.style=/ext/style

EDMS Module
-----------------------------------------------------------------

.. code-block:: properties
	
	# Define Common Options
	edms.PathLog=C:\\Users\\Disco\\workspace_egov\\log\\edms
	
	edms.PathRoot=C:/Users/Disco/workspace/edms
	edms.stPathRoot=C:/Users/Disco/workspace/edms
	edms.WebRoot2=/data/edms


Others
-------

.. code-block:: properties

	milestone.xml.root=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/data/xml/milestone
	xml.root=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/Main/assets
	devnote.home=C:\\Users\\Disco\\workspace\\devnote

Groupware Module
-----------------------------------------------------------------

.. code-block:: properties
	
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


Gmail provider
----------------
	
.. code-block:: properties

	Gmail.getAuthId=
	Gmail.getAuthPw=

ezpert Module
-----------------------------------------------------------------

.. code-block:: properties
	
	ezpert.ip=
	ezpert.port=


Pdf Converter
----------------

.. code-block:: properties
	
	# Define HTML PDF converter
	coverter.htmltopdf=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/util/pdf/


Thumbnails & Temporary Folders
-------------------------------	
	
.. code-block:: properties

	# Thumb converter temp path
	thumb.temp=C:/Users/Disco/workspace/temp
	# Main temporary path
	upload.temp=C:/Users/Disco/workspace/temp
	
	default_locale=en_US

excel & eMail & SMS template
-------------------------------
	
.. code-block:: properties

	template.home=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/data/template
	email.template.home=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/data/template
	excel.template.home=C:/Users/Disco/workspace_egov/STND_PMIS_comm_branch/web/WEB-INF/excelTemplete
	
Edms server mirroring
------------------------

.. code-block:: properties

	#mirror.server=SERVER3

Auto login for development env.
--------------------------------

.. code-block:: properties	

	autologin.user_no=
	autologin.password=
	autologin.pjt_cd=
	

Terms of Use
----------------------	
	
.. code-block:: properties

	#@@ TERMS OF SERVICE PROPERTIES
	tos.enabled=true
	tos.redirect.url=/pmis/STND_PMIS/tos/index.jsp
	tos.exclude.path=/Core/CoreUpdate.action,/pmis/STND_PMIS/tos/**
	
	
Document & Workflow
----------------------

.. code-block:: properties

	#@@ Document ID generation service availables: documentIdGnrService (default), pmisDocumentIdGnrService
	#doc.idgnr.service.name=documentIdGnrService
	
	#@@ Default ID generation service format token available: ${ENTPRS} ${FBS} ${YEAR} ${PJT_CD}
	#doc.idgnr.format=${ENTPRS}-${FBS}-${YEAR}-
	#doc.idgnr.required=true
	
	#@@ Document eMail Notification
	doc.noti.email.received=noti_doc_recv.html
	doc.noti.email.waitapprove=noti_doc_wait_app.html
	doc.noti.email.trn.waitreview=noti_trn_wait_review.html
	
	#@@ Document SMS Notification
	doc.noti.sms.received=sms_noti_doc_recv.txt
	doc.noti.sms.waitapprove=sms_noti_doc_wait_app.txt
	doc.noti.sms.trn.waitreview=sms_noti_trn_wait_rev.txt
	
	#@@ Documents/Letters/Transmittals
	#doc.authorization.type=ORG|PRIVATE
	doc.authorization.mode=ORG
	
	#@@ Drawings
	#register.authorization.type=ALL|ORG
	register.authorization.mode=ORG

Module Workflow/Transmittal Enable/Disable
-------------------------------------------

.. code-block:: properties
	
	workflow.disabled=false
	transmittal.disabled=false

Aconex Dashboard
-----------------

.. code-block:: properties
	
	#@@ Temporary authentication parameters for aconex dashboard
	aconex.auth.username=
	aconex.auth.password=
	aconex.auth.project=
	
DEPRECATED PROPERTIES
-------------------------

.. warning:: These properties will be removed soon or later...

.. code-block:: properties

	#@@ Inside jsp replace these properties with RequestUtil.getWebRoot
	#@@ ex: <%=RequestUtil.getWebRoot() %>/data/edms
	system.WebRoot=http://URL
	edms.WebRoot=http://URL/data/edms
	common.path.activex=http://URL/ext/activex
	common.path.plugin=http://URL/plugin