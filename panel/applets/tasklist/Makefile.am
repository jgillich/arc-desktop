if ENABLE_TASKLIST_PLUGIN

-include $(top_srcdir)/common.mk

EXTRA_DIST =
pkglib_LTLIBRARIES =
plugindir = $(MODULEDIR)
plugin_DATA =


plugin_DATA += \
	TasklistApplet.plugin

EXTRA_DIST += \
	$(plugin_DATA)

plugin_LTLIBRARIES = libtasklistapplet.la

libtasklistapplet_la_SOURCES = \
	TasklistApplet.vala

libtasklistapplet_la_CFLAGS = \
	$(ARC_BASE_CFLAGS) \
	$(ARC_PLUGIN_CFLAGS) \
	$(TASKLIST_PLUGIN_CFLAGS) \
	-DWNCK_I_KNOW_THIS_IS_UNSTABLE \
	$(DECLARATIONS)

libtasklistapplet_la_LIBADD = \
	${top_builddir}/plugin/libarc-plugin.la \
	$(ARC_BASE_LIBS) \
	$(ARC_PLUGIN_LIBS) \
	$(TASKLIST_PLUGIN_LIBS)

libtasklistapplet_la_LDFLAGS = \
	$(MODULE_FLAGS) \
	$(AM_LDFLAGS)

libtasklistapplet_la_VALAFLAGS = \
	--pkg gtk+-3.0 \
	--pkg libwnck-3.0 \
	--pkg gio-unix-2.0 \
	--pkg libpeas-1.0 \
	--pkg PeasGtk-1.0 \
	--pkg arc-1.0 \
	--vapidir=${top_srcdir}/plugin

endif
