.. _uploading-file-process:

======================
uploading file process
======================


.. code-block:: javascript
    
    <input type="hidden" name="file_seq" value="${view.FILE_SEQ}" />
    
    function prepareUpload() {
        return document.getElementById('ifrmDetail').contentWindow.cmdUpload('docViewForm');
    }
    
    function cmdSave() {
        cmdDoingView(true);
        prepareUpload().done(function(){
            $.ajax({
                ...
            }).always(function(){
                cmdDoingView(false);
            });
        });
        ...

.. code-block:: javascript

    cmdDoingView(true);
    prepareUpload() // file upload ajax calls ( prepareUpload return a jQuery Promise object )]
    cmdDoingView(false);

Please take a look at::

    jQuery Deferred object: http://api.jquery.com/category/deferred-object/
    jQuery Promise object: http://api.jquery.com/deferred.promise/


