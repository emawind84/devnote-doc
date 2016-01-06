==============================================
Disk Input/Output Performance Test with Linux
==============================================

Looking aroung on Internet I found really good tools for testing read 
and write speed of storage devices on Linux
and I am going to leave these commands here for future use.

.. note::
	The ``dd`` command as the reference manual say is a tool 
	for copy a file and we are going to use it for doing the test.
	

Write Speed
---------------------

``sync`` ensures that the filesystem cache is flushed to have more realistic data.

if=INPUTFILE
	read bytes from this file
	
of=OUTPUTFILE
	write bytes to this file

bs=BYTES
	the number of bytes that are written and read at a time
	
count=BLOCKS
	the number of time the reading and writing is repeated

.. code-block:: shell

	$ sync; dd if=/dev/zero of=~/test.tmp bs=500K count=1024
	
	256+0 records in
	256+0 records out
	131072000 bytes (131 MB) copied, 4.05327 s, 32.3 MB/s



Read Speed
--------------------

With the first command the memory is flushed in order to have more reliable test.
For the reading test ``dd`` copy the file in the special filesystem object ``/dev/null``.

.. code-block:: shell

	$ sync; echo 3 | sudo tee /proc/sys/vm/drop_caches
	$ sync; time dd if=~/test.tmp of=/dev/null bs=500K count=1024

	256+0 records in
	256+0 records out
	131072000 bytes (131 MB) copied, 6.789 s, 19.3 MB/s
