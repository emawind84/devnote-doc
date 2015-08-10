.. _filecopyinterceptor:

===================
FileCopyInterceptor
===================




.. note:: Every file with the passed file_seq will be copied from sourceUrl to destinationFolder before the result of the request is processed.

.. code-block:: java
    
    @FileCopy( "fileForm.file_seq" )
    public String list() throws Exception
    {
        fileList = fileDao.getFileList(fileForm);
        return SUCCESS;
    }
    
