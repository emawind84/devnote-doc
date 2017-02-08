===============================
Docker Scattered Notes
===============================

Install Docker Compose
-------------------------

::

    $ curl -L "https://github.com/docker/compose/releases/download/1.10.0/docker-compose-$(uname -s)-$(uname -m)" \
      -o /usr/local/bin/docker-compose
    $ chmod +x /usr/local/bin/docker-compose
    $ docker-compose --version
    docker-compose version: 1.10.0


Install Docker Machine
---------------------------

On Linux::

    $ curl -L https://github.com/docker/machine/releases/download/v0.9.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine &&
    sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

*For Windows just install Windows Toolbox or Docker for Windows.*


Start a Jenkins container
--------------------------------

::

    $ docker run -p 8080:8080 \
    -p 50000:50000 -d \
    -v /home/ec2-user/jenkins/var/jenkins_home:/var/jenkins_home jenkins

Backup Jenkins Home Folder
--------------------------------

::

    $ docker run --rm --volumes-from 3b809ef3fe51 \
    -v /home/ec2-user/jenkins:/backup alpine \
    tar cvf /backup/jenkins-home.tar /var/jenkins_home

SVN Tunnel
--------------------------------

::

    $ ssh -f -N -i sangahdev.key -L 9001:125.141.221.126:80 sangah@dev.sangah.com

Docker Daemon tunnel
--------------------------------

::

    $ ssh -f -N -i sangahdev.key -L 2345:localhost:2376 sangah@dev.sangah.com


Start a registry web ui
------------------------------

::

    $ docker run --rm -it -p 9091:8080 \
    --name registry-web \
    --link registry-srv \
    -e REGISTRY_URL=http://registry-srv:5000/v2 \
    -e REGISTRY_NAME=localhost:5000 \
    -e REGISTRY_TRUST_ANY_SSL=true \
    -e REGISTRY_BASIC_AUTH="" \
    -e REGISTRY_READONLY=false \
    --network registry_default \
    hyper/docker-registry-web


Format New Amazon EBS Volume
-----------------------------------

# check first if is empty with::

    sudo file -s /dev/xvdf
    /dev/xvdf: data

# if return `data` create the partition::

    $ sudo mkfs -t ext4 /dev/xvdf

# create mount point::

    $ mkdir /data

# backup fstab::
    
    $ sudo cp /etc/fstab /etc/fstab.orig

# add a new line to fstab::

    /dev/xvdf  /data  ext4 defaults,nofail 0 2



AWS S3 CLI
----------------------------------

Installing AWS CLI
^^^^^^^^^^^^^^^^^^^^^^

::

    $ curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip"
    $ unzip awscli-bundle.zip
    $ ./awscli-bundle/install -b ~/bin/aws

Remove folder from s3 with
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    $ aws s3 rm s3://disco-bucket/jenkins --recursive


Start a task using AWS ECS Command
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

.. note:: This is useful if you need to start a task into a well defined instance.

::

    $ aws ecs start-task --task-definition=jenkins:1 --cluster=disco-cluster --container-instances=2c2d50c8-360f-45fb-a32c-f722ba5820a0

Restart Docker Daemon on an EC2 Instance
--------------------------------------------

In order to restart the docker daemon, use the following command::

    $ sudo service cgconfig restart
    $ sudo service docker start


.. important:: 
    After attaching a new volume to an instance and mounting the volume,
    you need to restart the docker daemon in order to mount an host directory located in that volume,
    otherwise you will see a really strange situation!
    
    The container might not see the new mounted volume instead it will read and write inside the folder 
    under the mounted volume, as a result, the container and the host will see different files and folders 
    and you might even get some Permission denied inside the container.



EC2 Instance Configuration IMPORTANT!
---------------------------------------------

Because we are going to use a private registry to pull our images
we need to add some variables to the ecs container before it start,
so to tell him, that he should login with the credentials we gave him against our private registry.
(reference: http://docs.aws.amazon.com/AmazonECS/latest/developerguide/private-auth.html)

1. First we save an ecs configuration file on an S3 bucket.
   So create a file ecs.config and it should look like this:

 ::

    ECS_ENGINE_AUTH_TYPE=dockercfg
    ECS_ENGINE_AUTH_DATA={"auths": { "dev.sangah.com:5043": { "auth": "[user:pwd in base64 format]" } }
    ECS_CLUSTER=disco-cluster

 Make sure you replace the cluster name with the right one and you put a valid auth key.
 You can use the following command to retrieve our credentials to replace into the above variables::

    $ cat ~/.docker/config.json

2. Save the file into the S3 bucket::

    $ aws s3 ecs.config s3://disco-bucket/ecs.config

3. We need to add a policy to our ec2 role, so just follow the instructions here
   http://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-agent-config.html#ecs-config-s3
   and go to the point 'Storing Container Instance Configuration in Amazon S3'.

4. Add the following script to the Instance User Data, 
   just select the instance, stop it and go to ``Action`` -> ``Instance Settings`` -> ``View/Change User Data``, 
   and put this script, replacing ``your_bucket_name`` with the right name::

    #!/bin/bash
    yum install -y aws-cli
    aws s3 cp s3://your_bucket_name/ecs.config /etc/ecs/ecs.config



Install the ECS Agent to a new ECS Instance
-------------------------------------------------

First create a cluster

SSH to the instance machine and type::

    $ sudo yum install -y ecs-init
    $ sudo yum install docker
    $ sudo service docker start
    $ sudo start ecs

Test if the ecs agent has been installed and attached to the cluster with::

    $ curl http://localhost:51678/v1/metadata


Create TLS Certificate for Docker Host machine
==================================================

CA Key/Certificate
----------------------------

::

    $ openssl genrsa -aes256 -out ca-key.pem 4096
    $ openssl req -new -x509 -days 365 -key ca-key.pem -sha256 -out ca.pem


Server Key/Certificate
-------------------------

export HOST=dev.sangah.com

::

    $ openssl genrsa -out server-key.pem 4096
    $ openssl req -subj "/CN=$HOST" -sha256 -new -key server-key.pem -out server.csr
    $ echo subjectAltName = DNS:$HOST,IP:203.239.21.121,IP:127.0.0.1 > extfile.cnf
    $ openssl x509 -req -days 365 -sha256 -in server.csr -CA ca.pem -CAkey ca-key.pem \
      -CAcreateserial -out server-cert.pem -extfile extfile.cnf


Client Key/Certificate
-------------------------

::

    $ openssl genrsa -out key.pem 4096
    $ openssl req -subj '/CN=client' -new -key key.pem -out client.csr
    $ echo extendedKeyUsage = clientAuth > extfile.cnf
    $ openssl x509 -req -days 365 -sha256 -in client.csr -CA ca.pem -CAkey ca-key.pem \
      -CAcreateserial -out cert.pem -extfile extfile.cnf


Copy required files into docker config folder::

    $ cp -v ca.pem /etc/docker && \
      cp -v server-key.pem /etc/docker && \
      cp -v server-cert.pem /etc/docker

Check the docker config file ``/etc/default/docker`` and change the docker options as below::

::

    DOCKER_OPTS='
    -H tcp://0.0.0.0:2376
    -H unix:///var/run/docker.sock
    --storage-driver aufs
    --tlsverify
    --tlscacert /etc/docker/ca.pem
    --tlscert /etc/docker/server-cert.pem
    --tlskey /etc/docker/server-key.pem
    --label provider=generic
