.. highlight:: bash
.. _howto-raspi-speech-recognition-and-jasper:

========================================================
Raspberry Pi, Pocketsphinx STT and Jasper Good Stuff...
========================================================


.. note::
	
	- Part of this documentation has been taken from the `Jasper website`_.
	- Also take a look at `Wolf Paulus' Journal`_ where you can find a tutorial 
	  for installing and run your local STT with customized Language Model.
	
.. important::

	Before starting you may want to install checkinstall::
		
		$ sudo apt-get install checkinstall
		
	Checkinstall create a **deb** package that can be easily installed and removed using ``dpkg`` or ``apt-get``.

	It might happen that checkinstall fail with some recursive thing messages.
	In that case just go with the normal ``make install`` and than try again with ``checkinstall``.


Update the system
-----------------------

Before compiling and installing all the necessary packages 
let's update the system with the following commands:

::

	$ sudo apt-get update
	$ sudo apt-get dist-upgrade
	$ apt-get install rpi-update
	$ sudo rpi-update


Take a look at your sound card information
------------------------------------------------

::
	
	$ cat /proc/asound/cards

it will returns something along the line:

::

	0 [ALSA ]: bcm2835 - bcm2835 ALSA
	bcm2835 ALSA
	1 [AK5370 ]: USB-Audio - AK5370
	AKM AK5370 at usb-bcm2708_usb-1.2, full speed

...showing that the microphone is visible and its usb extension.


Installing build tools and required libraries
------------------------------------------------

::

	$ sudo apt-get update
	$ sudo apt-get upgrade
	$ sudo apt-get install bison
	$ sudo apt-get install libasound2-dev
	$ sudo apt-get install swig
	$ sudo apt-get install python-dev
	$ sudo apt-get install mplayer


Recording Test
---------------------

The current recording settings can be looked at with:

::

	$ amixer -c 1 sget 'Mic',0

	Simple mixer control 'Mic',0
	Capabilities: cvolume cvolume-joined cswitch cswitch-joined penum
	Capture channels: Mono
	Limits: Capture 0 - 78

	Mono: Capture 68 [87%] [10.00dB] [on]

alsamixer can be used to increase the capture levels. After an increase, it looks like this:

::

	$ alsamixer -c 1

	...
	Mono: Capture 68 [87%] [10.00dB] [on]


Building Sphinxbase
---------------------------

.. important:: Do not use 5prealpha with Jasper if you do not want to change Jasper source code

::

	$ wget http://downloads.sourceforge.net/project/cmusphinx/sphinxbase/0.8/sphinxbase-0.8.tar.gz
	$ tar -zxvf sphinxbase-0.8.tar.gz
	$ cd ~/sphinxbase-0.8/
	$ ./configure --enable-fixed
	$ make clean all
	$ sudo make install



Building PocketSphinx
-------------------------

::

	$ wget http://downloads.sourceforge.net/project/cmusphinx/pocketsphinx/0.8/pocketsphinx-0.8.tar.gz
	$ tar -zxvf pocketsphinx-0.8.tar.gz
	$ cd ~/pocketsphinx-0.8/
	$ ./configure
	$ make clean all
	$ sudo make install


Installing CMUCLMTK
-------------------------

Begin by installing some dependencies:

::

	$ sudo apt-get install subversion autoconf libtool automake gfortran g++ --yes

Next, move into your home (or Jasper) directory to check out and install CMUCLMTK:

::

	$ svn co https://svn.code.sf.net/p/cmusphinx/code/trunk/cmuclmtk/
	$ cd cmuclmtk/
	$ ./autogen.sh && make && sudo make install


Installing Phonetisaurus, m2m-aligner and MITLM
------------------------------------------------------


.. important::

	I had some problems compiling Phonetisaurus from Raspberry Pi 2 and this is how I resolved.
	
	Check the version of your **g++** compiler with the command:

	::
		
		$ g++ -v

		Using built-in specs.
		...
		gcc version 4.6.3 (Debian 4.6.3-14+rpi1)

	The **gcc version 4.6.3** provide experimental support for **C++0x** 
	(https://gcc.gnu.org/gcc-4.6/cxx0x_status.html) 
	but in my case the build of Phonetisaurus fail.

	The solution is to use the compiler **c++03** in this situation.

	If you have **g++ 4.7** you still might have this problem and you should try with the compiler **c++11** instead.

	To change the compiler before the **make** just give this command:

	::
		
		// for g++-4.6
		$ CPPFLAGS="-std=c++03" make

		// for g++-4.7
		$ CPPFLAGS="-std=c++11" make

	*reference: https://gcc.gnu.org/projects/cxx0x.html*


To use the Pocketsphinx STT engine, you also need to install MIT Language Modeling Toolkit, m2m-aligner and Phonetisaurus (and thus OpenFST).:

::

	$ wget http://distfiles.macports.org/openfst/openfst-1.3.3.tar.gz
	$ wget https://mitlm.googlecode.com/files/mitlm-0.4.1.tar.gz
	$ wget https://m2m-aligner.googlecode.com/files/m2m-aligner-1.2.tar.gz
	$ wget https://phonetisaurus.googlecode.com/files/is2013-conversion.tgz (phonetisaurus)

Untar the downloads:

::

	$ tar -xvf m2m-aligner-1.2.tar.gz
	$ tar -xvf openfst-1.3.3.tar.gz
	$ tar -xvf phonetisaurus-0.7.8.tgz
	$ tar -xvf mitlm-0.4.1.tar.gz



Build OpenFST:
---------------------

::

	$ cd openfst-1.3.3/
	$ ./configure --enable-compact-fsts --enable-const-fsts --enable-far --enable-lookahead-fsts --enable-pdt
	$ sudo make install # come back after a really long time


Build M2M:
---------------

::

	$ cd m2m-aligner-1.2/
	$ make


Build MITLMT:
-----------------

::

	$ cd mitlm-0.4.1/
	$ ./configure
	$ sudo make install


Build Phonetisaurus:
---------------------------

::

	$ cd phonetisaurus-0.7.8/
	$ cd src

	// for 0.7.8
	$ sudo make

	// for 0.7.8a using g++-4.6
	$ sudo CPPFLAGS="-std=c++03" make

	// for 0.7.8a using g++-4.7
	$ sudo CPPFLAGS="-std=c++11" make


Move some of the compiled files:

::

	$ sudo cp ~/m2m-aligner-1.2/m2m-aligner /usr/local/bin/m2m-aligner
	$ sudo cp ~/phonetisaurus-0.7.8/phonetisaurus-g2p /usr/local/bin/phonetisaurus-g2p


Building the Phonetisaurus FST model
---------------------------------------------

::

	$ wget https://www.dropbox.com/s/kfht75czdwucni1/g014b2b.tgz
	$ tar -xvf g014b2b.tgz
	
Build Phonetisaurus model:

::

	$ cd g014b2b/
	$ ./compile-fst.sh

[optional] Finally, rename the following folder for convenience:

::

	$ mv ~/g014b2b ~/phonetisaurus


Configuration
------------------

Follow the configuration instructions on the Jasper website 
http://jasperproject.github.io/documentation/configuration/ to set your sphinx STT service.

**Done! Enjoy!**


.. _Wolf Paulus' Journal: https://wolfpaulus.com/journal/embedded/raspberrypi2-sr/
.. _Jasper website: http://jasperproject.github.io/documentation/installation/