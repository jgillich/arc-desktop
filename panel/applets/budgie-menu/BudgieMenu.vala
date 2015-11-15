/*
 * BudgieMenu.vala
 *
 * Copyright 2014 Ikey Doherty <ikey.doherty@gmail.com>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 */

const string BUDGIE_STYLE_MENU_ICON = "menu-icon";
const int icon_size = 32;

public class BudgieMenu : Arc.Plugin, Peas.ExtensionBase
{
    public Arc.Applet get_panel_widget()
    {
        return new BudgieMenuApplet();
    }
}

public class BudgieMenuApplet : Arc.Applet
{

    protected Gtk.EventBox widget;
    protected BudgieMenuWindow? popover;
    protected Settings settings;
    protected Settings ksettings;
    Gtk.Image img;
    Gtk.Label label;
    private string modifier;

    HashTable<Gtk.Widget?,Gtk.Popover> popovers;

    public BudgieMenuApplet()
    {
        Object();

        popovers = new HashTable<Gtk.Widget?,Gtk.Popover>(direct_hash, direct_equal);

        settings = new Settings("com.evolve-os.budgie.panel");
        ksettings = new Settings("org.gnome.mutter");
        settings.changed.connect(on_settings_changed);
        ksettings.changed.connect(on_settings_changed);

        widget = new Gtk.EventBox();
        img = new Gtk.Image.from_icon_name("view-grid-symbolic", Gtk.IconSize.INVALID);
        img.pixel_size = icon_size;

        var layout = new Gtk.Box(Gtk.Orientation.HORIZONTAL, 0);
        layout.pack_start(img, false, false, 3);
        label = new Gtk.Label("");
        label.halign = Gtk.Align.START;
        layout.pack_start(label, true, true, 3);

        widget.add(layout);

        // Better styling to fit in with the budgie-panel
        var st = widget.get_style_context();
        st.add_class(BUDGIE_STYLE_MENU_ICON);
        popover = new BudgieMenuWindow(widget);

        widget.button_press_event.connect((e)=> {
            if (e.button != 1) {
                return Gdk.EVENT_PROPAGATE;
            }
            if (popover.get_visible()) {
                popover.hide();
            } else {
                popover.show_all();
            }
            return Gdk.EVENT_STOP;
        });

        popovers.insert(widget, popover);

        // This enables us to respond to the "overlay-key" action
        /*action_invoked.connect((t) => {
            if (t != Budgie.ActionType.INVOKE_MAIN_MENU) {
                return;
            }
            Idle.add(()=> {
                if (!popover.get_visible()) {
                    popover.show_all();
                } else {
                    popover.hide();
                }
                return false;
            });
        });*/

        add(widget);
        show_all();
        on_settings_changed("enable-menu-label");
        on_settings_changed("menu-icon");
        on_settings_changed("menu-label");
        on_settings_changed("overlay-key");

        /*icon_size_changed.connect((i,s)=> {
            img.pixel_size = (int)i;
        });*/

        popover.key_release_event.connect((e)=> {
            var human = Gdk.keyval_name(e.keyval);
            if (human == modifier) {
                popover.hide();
                return Gdk.EVENT_STOP;
            }
            return Gdk.EVENT_PROPAGATE;
        });
    }

    protected void on_settings_changed(string key)
    {
        switch (key)
        {
            case "menu-icon":
                if ("/" in settings.get_string(key)) {
                    Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file(settings.get_string(key));
                    img.set_from_pixbuf(pixbuf.scale_simple(32, 32, Gdk.InterpType.BILINEAR));
                } else {
                    img.set_from_icon_name(settings.get_string(key), Gtk.IconSize.INVALID);
                }
                break;
            case "menu-label":
                label.set_label(settings.get_string(key));
                break;
            case "enable-menu-label":
                label.set_visible(settings.get_boolean(key));
                break;
            case "overlay-key":
                /* Reset modifiers.. */
                modifier = ksettings.get_string(key);
                break;
            default:
                break;
        }
    }

    public override unowned HashTable<Gtk.Widget?,Gtk.Popover?>? get_popovers()
    {
        return popovers;
    }

} // End class

[ModuleInit]
public void peas_register_types(TypeModule module)
{
    // boilerplate - all modules need this
    var objmodule = module as Peas.ObjectModule;
    objmodule.register_extension_type(typeof(Arc.Plugin), typeof(BudgieMenu));
}