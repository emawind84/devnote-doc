.. _linux-rsync-merge-folder--symbolic-link:

========================================
linux rsync merge folder + symbolic link
========================================

::

    rsync -abviuzP src/ dest/
    
        -i turns on the itemized format, which shows more information than the default format
        -b makes rsync backup files that exist in both folders, appending ~ to the old file. You can control this suffix with --suffix .suf
        -u makes rsync transfer skip files which are newer in dest than in src
        -z turns on compression, which is useful when transferring easily-compressible files over slow links
        -P turns on --partial and --progress
        --partial makes rsync keep partially transferred files if the transfer is interrupted
        --progress shows a progress bar for each transfer, useful if you transfer big files
    
    symbolic link
    
        sudo ln -s /home/sangah/edms/ /home/sangah/SAPP/DEV_PMIS/web/data/edms

.. seealso::
    https://superuser.com/questions/547282/which-is-the-rsync-command-to-smartly-merge-two-folders