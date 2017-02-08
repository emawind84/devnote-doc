Get Started With Docker & Docker Machine
=============================================

How to install Docker and how to use Docker Machine to manage Docker instances
-----------------------------------------------------------------------------------

The easy way is to not install Docker, just let Docker Machine do the job, in order to do that
we need to install Docker Machine.

.. important::
  First of all let's remove stupid issue with Windows bash console that I do not want to cover, in order to resolve
  this issue we will use Linux machine only. 

From an Linux console install Docker Machine with the following commands::

    $ curl -L https://github.com/docker/machine/releases/download/v0.9.0/docker-machine-`uname -s`-`uname -m` >/tmp/docker-machine &&
    chmod +x /tmp/docker-machine &&
    sudo cp /tmp/docker-machine /usr/local/bin/docker-machine

Take some scripts from our Github account::

    $ git clone https://github.com/sangahco/docker-machine-cli.git
    $ cd docker-machine-cli
    $ chmod a+x *.sh


In order to manage Amazon EC2 Instances we need to set two environment variables::

    export AWS_ACCESS_KEY=myaccesskey
    export AWS_SECRET=mysecretkey

you can put the previous code inside the ``.bashrc`` file inside the user home folder
and than update the user environment with the following command::

    $ source ~/.bashrc


Create an Amazon EC2 Instance with the following script::

    $ /bin/sh create-aws-machine.sh <MACHINE NAME>


List the available machines with::

    $ docker-machine ls


Connect to a machine with the following command, 
replacing ``aws1`` with the machine name from the previous command::

    $ docker-machine env aws1
    $ eval $(docker-machine env aws1)


Check what machine is active::

    $ docker-machine active


Stop a machine::

    $ docker-machine stop aws1


Remove (Terminate) a machine:

.. important:: This command will terminate the instance and will be removed from the Amazon EC2

::

    $ docker-machine rm aws1