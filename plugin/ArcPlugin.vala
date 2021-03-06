/*
 * This file is part of arc-desktop.
 *
 * Copyright (C) 2015 Ikey Doherty
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 */

namespace Arc
{

/** Name of the plugin */
public static const string APPLET_KEY_NAME      = "name";
public static const string APPLET_KEY_ALIGN     = "alignment";
public static const string APPLET_KEY_POS       = "position";
public static const string APPLET_KEY_PAD_START = "padding-start";
public static const string APPLET_KEY_PAD_END   = "padding-end";


public interface PopoverManager : GLib.Object
{
    /**
     * arc_popover_manager_register_popover:
     * @widget: Widget that the popover is associated with
     * @popover: a #GtkPopover to assicate with @widget
     * 
     * Register a popover with this manager instance
     */
    public abstract void register_popover(Gtk.Widget? widget, Gtk.Popover? popover);

    /**
     * arc_popover_manager_unregister_popover:
     * @widget: Widget that the popover is associated with
     *
     * Unregister a widget that was previously registered
     */
    public abstract void unregister_popover(Gtk.Widget? widget);

    public abstract void show_popover(Gtk.Widget? parent);

}

/**
 * ArcPlugin
 */
public interface Plugin : GLib.Object
{
    /**
     * arc_plugin_get_panel_widget:
     * 
     * Returns: (transfer full): A Gtk+ widget for use on the ArcPanel
     */
    public abstract Arc.Applet get_panel_widget();
}

/**
 * ArcApplet
 */
public class Applet : Gtk.Bin
{

    /**
     * arc_applet_construct:
     *
     * Construct a new BudgieApplet
     *
     * Returns: (transfer full): A new BudgieApplet instance
     */
    public Applet() { }

    /**
     * arc_applet_update_popovers:
     * @manager: a valid #ArcPopoverManager
     *
     * Inform the applet it needs to register it's popovers. The #PopoverManager
     * is always valid
     */
    public virtual void update_popovers(Arc.PopoverManager? manager) { }
}

/**
 * Used to track Applets in a sane way
 */
public class AppletInfo : GLib.Object
{

    /** Applet instance */
    public Arc.Applet applet { public get; private set; }

    public unowned GLib.Settings? settings;

    /** Known icon name */
    public string icon {  public get; protected set; }

    /** Instance name */
    public string name { public get; protected set; }

    public string uuid { public get; protected set; }

    /** Which panel region to use */
    public string alignment { public get ; public set ; default = "start"; }

    /** Start padding */
    public int pad_start { public get ; public set ; default = 0; }

    /** End padding */
    public int pad_end { public get ; public set; default = 0; }

    /** Position (packging index */
    public int position { public get; public set; default = 0; }

    /**
     * Construct a new AppletInfo. Simply a wrapper around applets
     */
    public AppletInfo(Peas.PluginInfo? plugin_info, string uuid, Arc.Applet? applet, GLib.Settings? settings)
    {
        if (applet != null) {
            this.applet = applet;
        }
        if (plugin_info != null) {
            icon = plugin_info.get_icon_name();
            this.name = plugin_info.get_name();
        }
        this.uuid = uuid;
        if (settings != null) {
            this.settings = settings;
            this.bind_settings();
        }
    }

    void bind_settings()
    {
        settings.bind(Arc.APPLET_KEY_NAME, this, "name", SettingsBindFlags.DEFAULT);
        settings.bind(Arc.APPLET_KEY_POS, this, "position", SettingsBindFlags.DEFAULT);
        settings.bind(Arc.APPLET_KEY_ALIGN, this, "alignment", SettingsBindFlags.DEFAULT);
        settings.bind(Arc.APPLET_KEY_PAD_START, this, "pad-start", SettingsBindFlags.DEFAULT);
        settings.bind(Arc.APPLET_KEY_PAD_END, this, "pad-end", SettingsBindFlags.DEFAULT);

        /* Automatically handle margins */
        this.bind_property("pad-start", applet, "margin-start", BindingFlags.DEFAULT);
        this.bind_property("pad-end", applet, "margin-end", BindingFlags.DEFAULT);
    }
}

}

/*
 * Editor modelines  -  https://www.wireshark.org/tools/modelines.html
 *
 * Local variables:
 * c-basic-offset: 4
 * tab-width: 4
 * indent-tabs-mode: nil
 * End:
 *
 * vi: set shiftwidth=4 tabstop=4 expandtab:
 * :indentSize=4:tabSize=4:noTabs=true:
 */
