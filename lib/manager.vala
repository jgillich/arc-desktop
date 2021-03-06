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

public abstract class DesktopManager : GLib.Object
{

    public signal void panels_changed();

    public virtual GLib.List<Arc.Toplevel?> get_panels()
    {
        return new GLib.List<Arc.Toplevel?>();
    }

    public abstract uint slots_available();
    public abstract uint slots_used();
    public abstract void set_placement(string uuid, Arc.PanelPosition position);
    public abstract void set_size(string uuid, int size);

    public abstract void create_new_panel();
    public abstract void delete_panel(string uuid);
}


} /* End namespace */

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
