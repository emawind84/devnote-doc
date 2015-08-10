.. _uploading-file-process:

======================
uploading file process
======================


    
<input type="hidden" name="file_seq" value="${view.FILE_SEQ}" />

function prepareUpload() {
    return document.getElementById('ifrmDetail').contentWindow.cmdUpload('docViewForm');
}

function cmdSave() {
    $("body").append('<div class="pmis-proc-loading" ></div>');
    prepareUpload().done(function(){
        $.ajax({
            ...
        }).always(function(){
            $('.pmis-proc-loading').remove();
        });
    });
    ...


[NOTE $("body").append('<div class="pmis-proc-loading" ></div>') // loading logo on]
[NOTE prepareUpload() // file upload ajax calls ( prepareUpload return a jQuery Promise object )]
[NOTE $('.pmis-proc-loading').remove(); // loading logo off]

Please take a look at:
    jQuery Deferred object: http://api.jquery.com/category/deferred-object/
    jQuery Promise object: http://api.jquery.com/deferred.promise/


