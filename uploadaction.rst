.. _uploadaction:

============
UploadAction
============




Utility Action for uploading file

jsp:
-----------------------------------------------------------------------------------

.. code-block:: jsp
    
    <form method="post" enctype="multipart/form-data">
        ...
        <input type="file" name="upload" class="input_text" style="width: 380px">
    


java:
-----------------------------------------------------------------------------------

.. code-block:: java
    
    public abstract class UploadAction extends ActionSupport {
    
        @Resource protected TemporaryFileService temporaryFileService;
        protected File upload;
        protected String uploadContentType;
        protected String uploadFileName;
        ...
        
    public class DesignEdsAction extends UploadAction ...
    
        ...
    
        public String importResult() throws Exception {
            list = designEdsDao.importEds(upload);
            return SUCCESS;
        }
