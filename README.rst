===========
AUR-builder
===========

A simple docker receipt to build AUR packages.

How
===

Prerequisites
-------------

You'll need just docker (and git to clone this repo).

Build
-----

Clone this repo and create a local mount for the packages:

.. code:: bash

    git clone https://github.com/leophys/AUR-builder
    cd AUR-builder
    mkdir reservoir
    docker build --tag aurbuilder .

Now look for the name of your sought AUR package (it should resolve to an existing
https://aur.archlinux.org/the_package.git). Then build it:

.. code:: bash

    docker run -v $PWD/reservoir/:/home/builder/workshop -ti aurbuilder <the_package>

If everything went smooth, you should find your build in ``reservoir/the_package/the_package.x.y.z.pkg.tar.xz``.


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
