---------------------------
-- Default awesome theme --
---------------------------
local awful = require("awful")

theme = {}
theme.confdir       = awful.util.getdir("config")
local home          = os.getenv("HOME")

theme.font          = "Monaco 9"

theme.bg_normal     = "#222222"
theme.bg_focus      = "#535d6c"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#444444"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.border_width  = "1"
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"

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
theme.taglist_squares_sel   = theme.confdir .. "/icons/taglist/sel.png"
theme.taglist_squares_unsel = theme.confdir .. "/icons/taglist/unsel.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.confdir .. "/icons/submenu.png"
theme.menu_height = "15"
theme.menu_width  = "100"

-- {{{ Widgets                                                                  
theme.fg_widget        = "#AECF96"
theme.fg_center_widget = "#88A175"
theme.fg_end_widget    = "#FF5656"
theme.fg_off_widget    = "#494B4F"
theme.fg_netup_widget  = "#7F9F7F"
theme.fg_netdn_widget  = theme.fg_urgent
theme.bg_widget        = theme.bg_normal
theme.border_widget    = theme.bg_normal
-- }}}

-- {{{ Widget icons
theme.widget_bat    = theme.confdir .. "/icons/bat.png"
theme.widget_net    = theme.confdir .. "/icons/down.png"
theme.widget_netup  = theme.confdir .. "/icons/up.png"
theme.widget_wifi   = theme.confdir .. "/icons/wifi.png"
theme.widget_wifidown   = theme.confdir .. "/icons/wifi_down.png"
theme.widget_mail   = theme.confdir .. "/icons/mail.png"
theme.widget_mem    = theme.confdir .. "/icons/mem.png"
theme.widget_music  = theme.confdir .. "/icons/music.png"
theme.widget_cpu    = theme.confdir .. "/icons/cpu.png"
theme.widget_vol    = theme.confdir .. "/icons/vol.png"
theme.widget_date   = theme.confdir .. "/icons/time.png"
theme.widget_chat   = theme.confdir .. "/icons/chat.png"
-- }}}

-- Define the image to load
theme.titlebar_close_button_normal = theme.confdir .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.confdir .. "/icons/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.confdir .. "/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.confdir .. "/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.confdir .. "/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.confdir .. "/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.confdir .. "/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.confdir .. "/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.confdir .. "/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.confdir .. "/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.confdir .. "/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.confdir .. "/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.confdir .. "/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.confdir .. "/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.confdir .. "/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.confdir .. "/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.confdir .. "/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.confdir .. "/icons/titlebar/maximized_focus_active.png"

-- You can use your own command to set your wallpaper
theme.wallpaper = home .. "/Pictures/wallpapers/wall_120.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = theme.confdir .. "/icons/layouts/fairh.png"
theme.layout_fairv = theme.confdir .. "/icons/layouts/fairv.png"
theme.layout_floating  = theme.confdir .. "/icons/layouts/floating.png"
theme.layout_magnifier = theme.confdir .. "/icons/layouts/magnifier.png"
theme.layout_max = theme.confdir .. "/icons/layouts/max.png"
theme.layout_fullscreen = theme.confdir .. "/icons/layouts/fullscreen.png"
theme.layout_tilebottom = theme.confdir .. "/icons/layouts/tilebottom.png"
theme.layout_tileleft   = theme.confdir .. "/icons/layouts/tileleft.png"
theme.layout_tile = theme.confdir .. "/icons/layouts/tile.png"
theme.layout_tiletop = theme.confdir .. "/icons/layouts/tiletop.png"
theme.layout_spiral  = theme.confdir .. "/icons/layouts/spiral.png"
theme.layout_dwindle = theme.confdir .. "/icons/layouts/dwindle.png"

theme.awesome_icon = theme.confdir .. "/icons/arch.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
