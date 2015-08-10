.. _commonservice-savecontenttofile:

===============================
CommonService saveContentToFile
===============================




[NOTE This method only create a new file with the content passed, it doesn't delete the old file!]
[NOTE If file_seq is not passed a new file_seq will be generated and returned to the jsp together with revid]

.. code-block:: javascript

    $.ajax({
        url: "/Common/File/saveContentToFile.action",
        data: {
            "content" : "content test",
            "file_seq": "${view.content_seq}", // if not passed a new file_seq will be generated
            "forward": "/ml/doc2/Data.jsp" // response jsp
        },
        type: "POST",
        dataType: "json"
    }).done(function(data) {
        // available data:
        // data.html.file_seq
        // data.html.revid
    });

