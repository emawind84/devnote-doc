EDMS File Server Using NFS Server
====================================

Server Side
------------------

Install the Service
^^^^^^^^^^^^^^^^^^^^^^^^^^

NFS client needs portmap service, simply install nfs-comman package as follows to fix this problem::

    $ sudo apt-get install -y nfs-common nfs-kernel-server

Make sure portmap service is running::

    $ sudo service portmap status
    portmap start/running, process 4193

If is not started just run::

    $ sudo service portmap start

One installed you can see all shared NFS directories as follows (server side and client side, try on both!)::

    $ showmount -e [remoteip or blank]
    Export list for fs2:
    /Sales
    /Web
    /Accounting
    /Recordings
    /Public
    /Network Recycle Bin 1
    /Music
    /Download
    /Games
    /Family

.. important:: 
    Open the port **2049** so the client can access the NFS Share
    Other ports might be required such as **111** and **20048**


Create and set the shared folder
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

Install required packages:

On a Red Hat Enterprise Linux or SuSE Linux server::

    sudo yum install -y nfs-utils

On an Ubuntu server::

    sudo apt-get install nfs-common


Add a new line to ``/etc/fstab`` as follow,
replacing *server_ip* and *client_name*.

::

    <server_ip>:/<client_name>/edms  /media/edms  nfs4  rsize=32768,wsize=32768,hard,intr,timeo=600,retrans=2  0 0

.. important:: The `sync` option has performance implication and might slow down the connection speed drastically, so don't use it.


Mount the volume with::

    mount -a
    df

Make sure the mount is writable::

    cd /media/edms
    touch test

You should see the new mount to */media/edms*.

.. important:: To make it work with PMIS make sure the the mount is using nfs version 4::

    mount | grep nfs
    <server>://sa83/edms on /media/edms type nfs4 (rw,relatime,sync,vers=4.0,...)

  Looking at the option **vers=4.0**, you can see the exported folder is using nfs4.