arc-desktop
==========

The Arc Desktop is the successor to the Budgie Desktop, with a focus
on modern style and function.

Note that this work will be merged *back* into the Budgie Desktop
repo on GitHub upon completion - the name-change is SOLELY to make
it parallel installable and help me with debugging.

Enormous thanks go to horst3180 for all the design work, contributions
and overseeing of the project to ensure it meets his mockups. The
project would not be possible without him.


![screenshot1](https://raw.githubusercontent.com/solus-project/arc-desktop/master/screenshots/Raven_Main.png)

![screenshot2](https://raw.githubusercontent.com/solus-project/arc-desktop/master/screenshots/Raven_Settings.png)

License
-------

arc-desktop is available under a split license model. This enables
developers to link against the libraries of arc-desktop without
affecting their choice of license and distribution.

The shared libraries are available under the terms of the LGPL-2.1,
allowing developers to link against the API without any issue, and
to use all exposed APIs without affecting their project license.

The remainder of the project (i.e. installed binaries) is available
under the terms of the GPL 2.0 license. This is clarified in the headers
of each source file.

Building
--------

arc-desktop has a number of build dependencies that must be present
before attempting configuration. The names are different depending on
distribution, so the pkg-config names, and the names within the Solus
Operating System, are given:

    - gobject-2.0 >= 2.44.0
    - gio-2.0 >= 2.44.0
    - gtk+-3.0 >= 3.16.0
    - gio-unix-2.0 >= 2.44.0
    - uuid
    - libpeas-gtk-1.0 >= 1.8.0
    - libgnome-menu-3.0 >= 3.10.1
    - gobject-introspection-1.0 >= 1.44.0
    - libpulse >= 2
    - mutter >= 3.18.0
    - gnome-desktop-3.0 >= 3.18.0
    - libwnck >= 3.14.0

And:

    - vala >= 0.28

To install these on Solus:

```bash

    sudo eopkg it glib2-devel libgtk-3-devel libpeas-devel gobject-introspection-devel util-linux-devel pulseaudio-devel libgnome-menus-devel libgnome-desktop-devel mutter-devel libwnck-devel vala
    sudo eopkg it -c system.devel
```

Clone the repository:

```bash

    git clone https://github.com/solus-project/arc-desktop.git
```

Now build it:
```bash

    cd arc-desktop
    ./autogen.sh --prefix=/usr
    make -j$(($(getconf _NPROCESSORS_ONLN)+1))
    sudo make install
```

Theming
------

Please look at `./data/theme/theme.css` to override aspects of the default
theming.

Alternatively, you may invoke the panel with the GTK Inspector to
analyse the structure::

```bash

    arc-panel --gtk-debug=interactive --replace
```

If you are validating changes from a git clone, then::

```bash

    ./panel/arc-panel --gtk-debug=interactive --replace
```

Note that for local changes, GSettings schemas and applets are expected
to be installed first with `make install`.

Note that it is intentional for the toplevel `ArcPanel` object to
be transparent, as it contains the `ArcMainPanel` and `ArcShadowBlock`
within a singular window.

Also note that by default Arc overrides all theming with the stylesheet,
and in future we'll also make it possible for you to set a custom theme.
To do this, test your changes in tree first. When you have a reasonable
theme put together, please open an issue and we'll enable setting of
a custom theme (no point until they exist.)

Testing
------

As and when new features are implemented - it can be helpful to reset
the configuration to the defaults to ensure everything is still working
ok. To reset the entire configuration tree, issue::

```bash

    dconf reset -f /com/solus-project/arc-panel/  
```

Porting
------

If using a tarball, note that the distributed tarball includes the generated
.c and .h files. This means any Vala conditionals are invalidated. To
combat this, simply issue the following before doing any configure::

```bash

    make maintainer-clean
```

This ensures all the autogenerated `*.{c,h}` files are cleaned, and conditionals
will work with your build.

Known Issues
-----------

Currently the GtkPopover can *randomly* glitch when the panel is at the
bottom of the screen. It is expected to be fixed in a later commit, however
let's be fair, it does kinda look better up top.

*Update*: This only happens on the *first* show of the applet.

TODO
----

 - [ ] Fix Raven glitch when adding a new panel
 - [ ] Add applet manipulation
 - [ ] Port old applets into tree
 - [ ] Convert Raven modules into actual modules
 - [ ] Complete WM
 - [ ] Add defaults file for vendors to specify default configuration.
 - [ ] Merge into Budgie (preserving git history)
 - [ ] Tag release
 - [ ] Get translations in order
 - [ ] Second release

Authors
=======

Copyright (C) 2015 Ikey Doherty <ikey@solus-project.com>
