===========
AUR-builder
===========

A simple docker receipt to build AUR packages.

How
===

Prerequisites
-------------

You'll need just:
    - docker
    - GNU make
    - git (to clone this repo).

Build
-----

Clone this repo and run make: 

.. code:: bash

    git clone https://github.com/leophys/AUR-builder
    cd AUR-builder
    make compile
    sudo make install

If you want to use the go package for the juicy stuff you'll need also go installed and you may eventually run:

.. code:: bash

    git clone --recursive https://github.com/leophys/AUR-builder
    cd AUR-builder
    make TECH=go compile
    sudo make install


Now look for the name of your sought AUR package (it should resolve to an existing
https://aur.archlinux.org/the_package.git). Then build it:

.. code:: bash

    aurbuilder the_package

If everything went smooth, you should find your build in ``/tmp/aurbuilder/the_package/the_package.x.y.z.pkg.tar.xz``.

In case you are nasty, and chose the go path, you'll be given some more subcommands. Just ask for help:

.. code:: bash

    aurbuilder --help


Why
===

I used to love pacaur_. It is a great piece of software. Unfortunately it has been discontinued.
Other AUR helpers wasn't as satisfactory as pacaur (I used ``bauerbill`` and ``pikaur``, that
are nice anyway, but they broke badly sometimes). Moreover I wanted ad environment to build
packages that did not conflict with some other sistem-wide installed package (my case is the
conflict between ``nodejs`` and ``nodejs-lts-carbon`` that is needed to build ``code``).


Licence
=======

I enjoyed very much GLWTS_Public_Licence_. I'll stick to that (see LICENCE for details).


.. _pacaur: https://github.com/rmarquis/pacaur
.. _GLWTS_Public_Licence: https://github.com/me-shaon/GLWTPL
