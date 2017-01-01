.. highlight:: bash

================================
Creating an ad hoc Wi-Fi network
================================

The purpose of this tutorial is to create a direct access 
to the Raspberry Pi 2 using a wireless connection,
without the need of using a router or access point.

This tutorial has been tested on **Raspbian wheezy** distribution.

.. seealso:: Some reference:
	
	| https://wiki.debian.org/BridgeNetworkConnections#Setting_up_your_Bridge
	| https://wiki.gentoo.org/wiki/Network_management_using_DHCPCD
	| https://www.raspberrypi.org/forums/viewtopic.php?f=36&t=125139

First of all we need to edit the network interfaces configuration,
and what we are going to do is to assign a static address to our wifi interface
and tell to the networking service to invoke the wpa_supplicant with custom parameters when the wifi go up
and to kill the wpa_supplicant when the wifi go down.

Your configuration might be something like this if you are using Raspbian Jessie::

    ...
    source-directory /etc/network/interfaces.d

    auto lo
    iface lo inet loopback

    iface eth0 inet manual

    allow-hotplug wlan0
    iface wlan0 inet manual
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf

    allow-hotplug wlan1
    iface wlan1 inet manual
        wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf


Let's open the configuration and start editing.

::

	$ sudo nano /etc/network/interfaces

Replace the configuration of ``wlan0`` 
or whatever interface you want to use with the configuration below::

    allow-hotplug wlan0
    iface wlan0 inet static
    pre-up wpa_supplicant -Dwext -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf -B
    post-down killall -q wpa_supplicant
    #wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
    address 192.168.10.1
    netmask 255.255.255.0

``iface wlan0 inet static``
    Define a static ip address, and doing this we don't bother dhcp services.

``pre-up wpa_supplicant -Dwext -i wlan0 -c /etc/wpa_supplicant/wpa_supplicant.conf -B``
    The networking service call wpa_supplicant
    with ``-D nl80211,wext``, telling to the service to use the first driver that works for him.
    Unfortunately it picks ``nl80211`` that doesn't work in Ad-Hoc mode, at least on my system.
    So we leave only ``wext`` as available driver and it should works.

``post-down killall -q wpa_supplicant``
    We kill wpa_supplicant when the interface go down. 
    The networking service doesn't kill it if we don't use ``wpa-conf`` property so we have to do it.

``address 192.168.10.1``
    The ip address we want to set for this machine.

``netmask 255.255.255.0``
    The netmask we want to set for the network.


.. important::
	In case your distribution are running the DHCP client **dhcpcd** (Debian Jessie) 
	the above static address (might) not work.
	
	Check if this service is running with the command:
	
	::
	
		$ ps -ef | grep -v grep | grep dhcpcd
		
	If the DHCP client is running you need to edit the configuration ``/etc/dhcpcd.conf``.
	You should have something like:
	
	::
	
		interface wlan0
		static domain_name_servers=8.8.8.8
		static domain_search=8.8.4.4
		
	Add the following lines below the **interface wlan0**:
	
	::
		
		interface wlan0
		static domain_name_servers=8.8.8.8
		static domain_search=8.8.4.4
		
		# set your address and gateway here
		static ip_address=192.168.10.1
		static routers=192.168.10.1
		
Now the other step to do is editing the Wi-Fi configuration file **wpa_supplicant**
and add your ad hoc network.

Open the file with::

	$ sudo nano /etc/wpa_supplicant/wpa_supplicant.conf
	
Comment your previously access point if you have one, we need to disable it
and add the new network as below::

	ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
	update_config=1

	ap_scan=2
	network={
		ssid="RaspiHoc"
		mode=1
		frequency=2432
		proto=WPA
		key_mgmt=WPA-NONE
		pairwise=NONE
		group=CCMP
		psk="myraspihoc"
		#id_str="raspihoc"
	}
	
You might want to change **ssid**, **psk** and **id_str** before saving.

Bring the wifi down and reload the networking configuration::

	$ sudo ifdown --force wlan0
	$ sudo service networking reload
	
Bring the wifi up again and check if the new ad hoc network has been set with::

	$ sudo ifup wlan0
	$ iwconfig
	
	wlan0	IEEE 802.11bg  ESSID:"RaspiHoc"  Nickname:"<WIFI@REALTEK>"
			Mode:Ad-Hoc  Frequency:2.412 GHz  Cell: 02:11:87:88:50:13
			...
			
Check if **Mode** is set as ``Ad-Hoc`` and **ESSID** has the ssid you set.
Then you might want to connect to the new network with your device.

.. note::
	The other device should have a different address such as 192.168.10.2
	and netmask 255.255.255.0 as set before.

After your device has been connected to the network you can check the next step with::
		
	$ ip addr
	
	...
	3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP qlen 1000
	link/ether 64:e5:99:fb:ff:66 brd ff:ff:ff:ff:ff:ff
	inet 192.168.10.1/24 brd 192.168.10.255 scope global wlan0
		valid_lft forever preferred_lft forever

With **ip addr** you shoud be able to see if the network has been set with the right address,
looking at my output **inet 192.168.10.1/24**, you can see my network has the address I set before.
	
Now you can connect directly to your Raspberry Pi 2 using his local address **192.168.10.1**.

----------------------

.. important: 
    *The following part need to be revised cause it doesn't work as intended.*

You will see that you can not use this network to access Internet.
In case you want to be able to use internet using this network
you have to install a new service **bridge-utils**, that will bridge the Internet connection
on eth0 to wlan0::

	$ sudo apt-get install bridge-utils
	
Then you need to add some lines on the network configuration file
``/etc/network/interfaces`` as below::

	auto br0
	iface br0 inet dhcp
	bridge_ports eth0 wlan0
	
Bring down the wifi interface and reload the network configuration::

	$ sudo ifdown --force wlan0
	$ sudo service networking reload
	$ sudo ifup wlan0
	
And you should be able to connect directly to your Raspberry Pi 
and using Internet connection all together.