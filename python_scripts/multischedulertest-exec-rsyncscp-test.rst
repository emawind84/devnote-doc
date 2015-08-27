.. _multischedulertest-exec-rsyncscp-test:

=======================================
MultiSchedulerTest exec rsync&scp test 
=======================================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex16.py``

::

	
	import jarray
	from java.lang import *
	from test import MultiSchedulerTest
	
	#envps = jarray.array(['sh','/opt/temp/rsync'], String )
	#envps = jarray.array(['rsync','-avz', '-e', 'ssh -i /home/disco/mirror.key  -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null', 'sangah@203.239.21.121:/home/sangah/edms/STND_PMIS/', '/opt/edms/STND_PMIS/'], String )
	envps = jarray.array(['scp','-i', '/home/disco/mirror.key', '-o StrictHostKeyChecking=no', '-o UserKnownHostsFile=/dev/null', 'sangah@203.239.21.121:/home/sangah/edms/STND_PMIS/201407/1407182674737531.png', '/opt/edms/STND_PMIS/201407/'], String )
	
	print type(envps)
	
	MultiSchedulerTest.getExecuteCommand(envps);
	#MultiSchedulerTest.getExecuteCommand('rsync -h')
	#MultiSchedulerTest.getExecuteCommand('scp -i /home/disco/mirror.key  -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null sangah@203.239.21.121:/home/sangah/edms/STND_PMIS/201407/1407294135657256.wmv /opt/edms/STND_PMIS/201407');
	
	print "end"