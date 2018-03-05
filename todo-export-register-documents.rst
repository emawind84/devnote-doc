TO-DO Checklist for exporting register data
=================================================

**Fix EDMS file size (EDMS 파일 크기 수정).**
  Use the script 'Update edms filesize with real file length' (ex63.py)

**Check for documents in IDLE or SENT state with empty ID**
  Use the script 'Update document ID that has not doc_id' (ex31.py)

**Check Documents with empty html file and build them. (빈HTML 파일 문서를 확인하고 다시 빌드한다).**
  Use the script 'Delete document html file with length 0' (ex62.py) 
  to fix transmittal and workflow transmittal (need tuning for other types)

**Check Workflow in progress and close them. (진행중 Workflow 확인하고 닫다).**
  We need to use the method WorkflowServiceImpl.skipOverdueReviewer()

**Generate register document for every missing documents.**
  Use the script 'Update Document & Generate Register Document' (ex43.py)

**Delete register document if the actual document has been deleted.**

**Check for documents with really high version number.**

**Generate materialized code for register documents.**
  Use the script 'generate_register_mat_code.py', you need the CLI tool.

**Export FBS with materialized codes.**
  Using the scripts https://goo.gl/H2rmBc

**Export register files.**
  Done with PMIS CLI

**Export register review files.**
  Done with PMIS CLI

**Export picture files.**
  Done with PMIS CLI


.. important:: The scripts found in /web/pmis/STND_PMIS/test/console/example can be executed using /Test/Console/console.action

.. important:: The scripts found in /util/scripts should be executed using PMIS CLI


