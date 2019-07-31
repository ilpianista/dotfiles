---------------------------
-- Base16 Default Dark awesome theme --
---------------------------
local awful = require("awful")
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local theme = {}


theme.confdir       = awful.util.getdir("config")
theme.name          = "base16_dark"
theme.path          = theme.confdir .. "/themes/" .. theme.name

theme.font          = "Source Code Pro 9"
theme.iconFont      = "Ionicons 9"

-- Base16 colors
theme.base16_base00 = "#181818"
theme.base16_base01 = "#282828"
theme.base16_base02 = "#383838"
theme.base16_base03 = "#585858"
theme.base16_base04 = "#b8b8b8"
theme.base16_base05 = "#d8d8d8"
theme.base16_base06 = "#e8e8e8"
theme.base16_base07 = "#f8f8f8"
theme.base16_base08 = "#ab4642"
theme.base16_base09 = "#dc9656"
theme.base16_base0A = "#f7ca88"
theme.base16_base0B = "#a1b56c"
theme.base16_base0C = "#86c1b9"
theme.base16_base0D = "#7cafc2"
theme.base16_base0E = "#ba8baf"
theme.base16_base0F = "#a16946"

theme.bg_normal     = theme.base16_base00
theme.bg_focus      = theme.base16_base00
theme.bg_urgent     = theme.base16_base08
theme.bg_minimize   = theme.base16_base03
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = theme.base16_base0B
theme.fg_focus      = theme.base16_base05
theme.fg_urgent     = theme.base16_base01
theme.fg_minimize   = theme.base16_base07

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(2)
theme.border_normal = theme.base16_base02
theme.border_focus  = theme.base16_base0B
theme.border_marked = theme.base16_base08

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = theme.path .. "/icons/submenu.png"
theme.menu_height = dpi(15)
theme.menu_width  = dpi(100)

-- {{{ Widgets
theme.widget_bat_fg     = theme.base16_base09
theme.widget_batlow_fg  = theme.bg_urgent
theme.widget_netdown_fg = theme.bg_urgent
theme.widget_netup_fg   = theme.base16_base0D
theme.widget_wifi_fg    = theme.base16_base0D
theme.widget_mem_fg     = theme.base16_base0A
theme.widget_cpu_fg     = theme.base16_base0A
theme.widget_vol_fg     = theme.base16_base0E
theme.widget_date_fg    = theme.base16_base0B
-- }}}

-- Define the image to load
theme.titlebar_close_button_normal = theme.path .. "/icons/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = theme.path .. "/icons/titlebar/close_focus.png"

theme.titlebar_minimize_button_normal = theme.path.."/icons/titlebar/minimize_normal.png"
theme.titlebar_minimize_button_focus  = theme.path.."/icons/titlebar/minimize_focus.png"

theme.titlebar_ontop_button_normal_inactive = theme.path.."/icons/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = theme.path.."/icons/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = theme.path.."/icons/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = theme.path.."/icons/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = theme.path.."/icons/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = theme.path.."/icons/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = theme.path.."/icons/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = theme.path.."/icons/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = theme.path.."/icons/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = theme.path.."/icons/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = theme.path.."/icons/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = theme.path.."/icons/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = theme.path.."/icons/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = theme.path.."/icons/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = theme.path.."/icons/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = theme.path.."/icons/titlebar/maximized_focus_active.png"

theme.wallpaper = theme.confdir .. "/themes/wallpaper.jpg"

-- You can use your own layout icons like this:
theme.layout_fairh = theme.path.."/icons/layouts/fairhw.png"
theme.layout_fairv = theme.path.."/icons/layouts/fairvw.png"
theme.layout_floating  = theme.path.."/icons/layouts/floatingw.png"
theme.layout_magnifier = theme.path.."/icons/layouts/magnifierw.png"
theme.layout_max = theme.path.."/icons/layouts/maxw.png"
theme.layout_fullscreen = theme.path.."/icons/layouts/fullscreenw.png"
theme.layout_tilebottom = theme.path.."/icons/layouts/tilebottomw.png"
theme.layout_tileleft   = theme.path.."/icons/layouts/tileleftw.png"
theme.layout_tile = theme.path.."/icons/layouts/tilew.png"
theme.layout_tiletop = theme.path.."/icons/layouts/tiletopw.png"
theme.layout_spiral  = theme.path.."/icons/layouts/spiralw.png"
theme.layout_dwindle = theme.path.."/icons/layouts/dwindlew.png"
theme.layout_cornernw = theme.path.."/icons/layouts/cornernww.png"
theme.layout_cornerne = theme.path.."/icons/layouts/cornernew.png"
theme.layout_cornersw = theme.path.."/icons/layouts/cornersww.png"
theme.layout_cornerse = theme.path.."/icons/layouts/cornersew.png"

-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

theme.tasklist_disable_icon = true

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
