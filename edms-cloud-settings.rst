EDMS File Server Configuration
================================

Server Side
------------------

Create a new ``edms`` folder that will be used by the client,
replace the *client_name* with a meaningful name 
and change the permission of the folder to *nfsnobody* user:

::

    mkdir -p /home/sangah/nfsshare/<client_name>/edms
    chown -R nfsnobody: /home/sangah/nfsshare/<client_name>


Modify the file ``/etc/exports`` and add the new created edms folder,
replacing *client_ip* with the right client ip address
and the *client_name* with the right client name.

::

    echo "/home/sangah/nfsshare/<client_name>/edms <client_ip>(rw,sync,no_subtree_check)" >> /etc/exports

Check that everything is in order inside the file with::

    more /etc/exports

Export the nfs shares::

    exportfs -a

Usually not required but you can restart the service with::

    systemctl restart nfs-server


Client Side
------------------


Add a new line to ``/etc/fstab`` as follow,
replacing *server_ip* and *client_name*.

::

    <server_ip>:/home/sangah/nfsshare/<client_name>/edms  /media/edms  nfs  rw,sync,hard,intr  0 0

Then mount the volume with::

    mount -a
    df

You should see the new mount to */media/edms*.