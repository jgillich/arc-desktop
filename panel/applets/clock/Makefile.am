-include $(top_srcdir)/common.mk

EXTRA_DIST =
pkglib_LTLIBRARIES =
plugindir = $(MODULEDIR)
plugin_DATA =


plugin_DATA += \
	ClockApplet.plugin

EXTRA_DIST += \
	$(plugin_DATA)

plugin_LTLIBRARIES = libclockapplet.la

libclockapplet_la_SOURCES = \
	ClockApplet.vala

libclockapplet_la_CFLAGS = \
	$(ARC_BASE_CFLAGS) \
	$(ARC_PLUGIN_CFLAGS) \
	$(DECLARATIONS)

libclockapplet_la_LIBADD = \
	${top_builddir}/plugin/libarc-plugin.la \
	$(ARC_BASE_LIBS) \
	$(ARC_PLUGIN_LIBS)

libclockapplet_la_LDFLAGS = \
	$(MODULE_FLAGS) \
	$(AM_LDFLAGS)

libclockapplet_la_VALAFLAGS = \
	--pkg gtk+-3.0 \
	--pkg gio-unix-2.0 \
	--pkg libpeas-1.0 \
	--pkg PeasGtk-1.0 \
	--pkg arc-1.0 \
	--vapidir=${top_srcdir}/plugin
