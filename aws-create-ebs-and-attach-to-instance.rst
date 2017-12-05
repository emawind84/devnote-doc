Create an EBS Volume on AWS and attach it to an instance EC2
==============================================================

Create a New Volume on AWS
--------------------------------

Just follow the instruction to the website is not so hard

http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-creating-volume.html


Attach the Volume to an EC2 Instance
----------------------------------------

Same here just follow the instruction

http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-attaching-volume.html


Format New Amazon EBS Volume
-----------------------------------

#. **Find the new volume with the following command**::

    $ lsblk

#. **Check if the volume is empty**::

    sudo file -s /dev/xvdf
    /dev/xvdf: data

#. **Only if return `data`, create the partition with the following command**::

    $ sudo mkfs -t ext4 /dev/xvdf

#. **Create mount point**::

    $ mkdir /data

#. **Backup fstab**::

    $ sudo cp /etc/fstab /etc/fstab.orig

#. **Add a new line to the file** ``/etc/fstab``::

    /dev/xvdf  /data  ext4 defaults,nofail 0 2

#. **Test and mount the volume with**::

    $ sudo mount -a

[optional] Replace the device name with its UUID
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 With the following command find the volume::

    $ df

 Find the UUID with the following command::

    $ sudo file -s /dev/xvda1

 Than replace the device name in ``/etc/fstab`` with the UUID::

    UUID=ba3a79ef-e4b6-413a-82e7-35955888302f  /data  ext4 defaults,nofail 0 2