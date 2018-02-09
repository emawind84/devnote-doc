Update PMIS Without Restarting Docker Container
=================================================

Is actually possible to update JSP files without restarting the service if you really need to...

**From the server shell type the following command**::

    $ docker volume ls
    DRIVER              VOLUME NAME
    local               dockerpmisapppemco_app
    local               dockerpmisapppemco_ngx
    local               dockerpmisapppemco_thumb
    local               dockerpmisapppemco_tmp


**Inspect the volume having suffix** ``_app`` **(this is the volume containing the web folder)**:

::

    $ docker inspect dockerpmisapppemco_app
    [
        {
            "CreatedAt": "2017-10-23T11:06:51+09:00",
            "Driver": "local",
            "Labels": null,
            "Mountpoint": "/var/lib/docker/volumes/dockerpmisapppemco_app/_data",
            "Name": "dockerpmisapppemco_app",
            "Options": {},
            "Scope": "local"
        }
    ]


**The folder you are looking for is located at the path set in** ``Mountpoint``::

    /var/lib/docker/volumes/dockerpmisapppemco_app/_data/ROOT


.. important::
    Remember that this folder is deleted every time the service is restarted! (the war file get unpacked everytime)