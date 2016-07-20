.. _pmis-file-manager:

================================
Pmis File Manager jQuery Plugin
================================

This is the new file manager, no more iframe.

.. code-block:: html

	<div id='filemanager'></div>

.. code-block:: javascript

	// version with default parameters
	$('#filemanager').fileManager();
	
	// version with custom parameters
	$('#filemanager').fileManager({
		form: '#form',
		accept_filter: 'image/*',
		readonly: false,
		file_seq: 10001,
		id: 'filemanageridhere',
		custom_query: "",
		custom_params: "",
		input_prefix: 'file_',
		filetype: 'image',
		single: true,
		html5upload: true,
		btnsave: true,
		copyfromurl: true,
		hide_header: true,
		hide_webhard: true,
		hide_downall: true,
		disabledblclick: true,
		show_reg_date: true,
		hide_reg_name: false,
		hide_btns: false,
		resizable: true,
		maxfilesize: 2147483648,
		template: "/pmis/STND_PMIS/common/file/filemanager.jsp",
		show_file_log: true
	});


Available Parameters
----------------------

form
	It is the 'form id' to attach the input tag to, after files are uploaded to temporary folder.
	
	**Required** if upload is enabled or the input tags can't be generated.
	
accept_filter
	Define the file types that are visible in the file selection window 
	( ``image/*``, ``.doc,.docx,application/msword``, ``.xml`` ).
	
	.. seealso:: `File Upload state (type=file) <http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#file-upload-state-%28type=file%29>`_
	
readonly
	As it says, set the file manager in read only mode.
	
file_seq
	The file_seq that will be used to retrieve the files from ( and for uploading too ).
	
	**Required** if you want to initialize the file manager with files from the edms folder.
	You don't need to pass file_seq if plan to make an only upload file manager. Still you need to know the file_seq
	that will keep the new files to save the actual edms files.
	
id
	Set the id for the file manager, it can be used later to retrieve the DOM element with FileManager.instances['<id>'] 
	to retrieve the file manager instance. The default value is the dom id or a filemanager<random>.
	
custom_query
	If you want to use a custom query to retrieve files.
	
custom_params
	If you need custom parameters to use with the custom_query.
	
input_prefix
	How the input tag have to be prefixed. Default to ``file_``.
	
filetype
	Limit the files that can be uploaded to the passed filetype. 
	The available filetype are ``image``, ``excel``, ``word``, ``zip``.
	
single
	Limit the file manager to a single file (no more than one file can be uploaded).
	
html5upload
	Used for testing the old html4. Toggle the html5 support on/off (multi file upload).
	
btnsave
	Show a save button that on click will trigger the event ``filemng/save`` on the file manager DOM Element.
	
copyfromurl
	Enable the file upload though an URL.
	
hide_header
	Remove the grid header.

hide_webhard
	Remove the webhard upload.

hide_downall
	Remove the download button.

hide_btns
	Remove the buttons header.
	
hide_reg_name
	Remove the submitter name.
	
resizable
	The user can drag the border at the bottom and resize the container.

disabledblclick
	Disable the double click inside the grid.
	
show_reg_date
	Show the file uploaded date.

maxfilesize
	Reject the upload of files over this size limit (in byte) 

template
	This is the template of the file manager, change this if you want to change the layout

show_file_log
	Show the event log of the edms file

Available Functions & Objects
-------------------------------

Using FileManager.instances[<filemanagerid here>] the DOM element associated to the file manager is retrieved.

Inside the DOM element the following functions and objects can be used and read:

grid
	It is the grid DOM element inside the file manager.
	
settings
	All the parameters associated to the current instance.
	
resize()
	Will resize the file manager to the parent DOM element size.
	
cmdDown()
	Download one or more files inside the file manager (select the files first).
	
cmdWebhard()
	File upload through Webhard page.
	
cmdUpload()
	Upload new files into the temporary folder (on the server...).
		
getUploadCount()
	Return the number of files that have to be uploaded ( in the temporary folder ) into the server.

cmdHandleFile(obj)
	If you use an external input file tag is possible to attach that input handler to the file manager handler.::
	
		$('input[name="file"]').change(function (obj){
			// FileManager will handle the file
			FileManager.instances['<managerid>'].cmdHandleFile(obj);
		});
		
getFileCount()
	Return the number of files inside the current file manager instance.
	
*cmdThumUpload()*
	DEPRECATED. Upload new images with their thumbnails into the temporary folder.

*getID()*
	DEPRECATED. Return the id of the current file manager instance.
	
*getList()*
	DEPRECATED. Return the grid as DOM Element.
	
*getFileSeq()*
	DEPRECATED. Return the file seq linked with the file manager.

*addUploadedFile()*
	This is a private function and should not be used.
	
*initGrid()*
	This is a private function and should not be used.
	
	
Available Events
-------------------------

The following events are triggered on the File Manager instance DOM element.

You can attach an handler using this code::

	$('#filemanager').on('filemng/save', function (){
		// do something here
	});
	
You can use the global object FileManager for the same job::

	$(FileManager.instances['filemanager']).on('filemng/save', function (){
		// do something here
	});
	

filemng/downloaded
	Event triggered on file download.
	
filemng/save
	Event triggered when the save button is clicked.

filemng/ready
	Event triggered when the file manager is ready to be used.

filemng/added
	Event triggered after a file is added to the grid.

filemng/change
	Event triggered every time the file manager changes his status.

filemng/dblclick
	Event triggered after a double click on a file.

filemng/selected
	Event triggered after a file on the list is selected.

filemng/uploading
	Event triggered during the upload process.

filemng/uploaded
	Event triggered when the upload process is terminated.