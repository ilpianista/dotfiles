---------------------------
-- Solarized Light awesome theme --
---------------------------
local awful = require("awful")

theme = {}

theme.confdir       = awful.util.getdir("config")
theme.name          = "solarized_light"
theme.path          = theme.confdir .. "/themes/" .. theme.name

theme.font          = "Monaco 9"

theme.bg_normal     = "#fdf6e3"
theme.bg_focus      = "#eee8d5"
theme.bg_urgent     = "#d33682"
theme.bg_minimize   = "#fdf6e3"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#657b83"
theme.fg_focus      = "#657b83"
theme.fg_urgent     = "#586e75"
theme.fg_minimize   = "#93a1a1"

theme.border_width  = "1"
theme.border_normal = "#fdf6e3"
theme.border_focus  = "#eee8d5"
theme.border_marked = "#d33682"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
theme.taglist_squares_sel   = theme.path .. "/icons/taglist/sel.png"
theme.taglist_squares_unsel = theme.path .. "/icons/taglist/unsel.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.path .. "/icons/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- {{{ Widgets                                                                  
theme.fg_bat_widget  = theme.fg_urgent
theme.fg_netup_widget  = theme.fg_normal
theme.fg_netdn_widget  = theme.fg_urgent
-- }}}

-- {{{ Widget icons
theme.widget_bat    = theme.path .. "/icons/bat.png"
theme.widget_netdown = theme.path .. "/icons/down.png"
theme.widget_netup  = theme.path .. "/icons/up.png"
theme.widget_wifi   = theme.path .. "/icons/wifi.png"
theme.widget_wifidown = theme.path .. "/icons/wifidown.png"
theme.widget_wifilow = theme.path .. "/icons/wifilow.png"
theme.widget_mail   = theme.path .. "/icons/mail.png"
theme.widget_mem    = theme.path .. "/icons/mem.png"
theme.widget_music  = theme.path .. "/icons/music.png"
theme.widget_cpu    = theme.path .. "/icons/cpu.png"
theme.widget_vol    = theme.path .. "/icons/vol.png"
theme.widget_date   = theme.path .. "/icons/time.png"
theme.widget_chat   = theme.path .. "/icons/chat.png"
-- }}}

-- Define the image to load
theme.titlebar_close_button_normal = theme.path .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.path .. "/icons/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.path .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.path .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.path .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.path .. "/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.path .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.path .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.path .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.path .. "/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.path .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.path .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.path .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.path .. "/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.path .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.path .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.path .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.path .. "/icons/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper = theme.confdir .. "/themes/wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = theme.path .. "/icons/layouts/fairh.png"
theme.layout_fairv = theme.path .. "/icons/layouts/fairv.png"
theme.layout_floating  = theme.path .. "/icons/layouts/floating.png"
theme.layout_magnifier = theme.path .. "/icons/layouts/magnifier.png"
theme.layout_max = theme.path .. "/icons/layouts/max.png"
theme.layout_fullscreen = theme.path .. "/icons/layouts/fullscreen.png"
theme.layout_tilebottom = theme.path .. "/icons/layouts/tilebottom.png"
theme.layout_tileleft   = theme.path .. "/icons/layouts/tileleft.png"
theme.layout_tile = theme.path .. "/icons/layouts/tile.png"
theme.layout_tiletop = theme.path .. "/icons/layouts/tiletop.png"
theme.layout_spiral  = theme.path .. "/icons/layouts/spiral.png"
theme.layout_dwindle = theme.path .. "/icons/layouts/dwindle.png"

theme.awesome_icon = theme.path .. "/icons/arch.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = elementary

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
