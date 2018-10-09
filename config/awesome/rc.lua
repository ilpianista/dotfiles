-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- Lain library (extra layouts, utilities and widgets)
local lain = require("lain")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
local config = awful.util.getdir("config")
-- Themes define colours, icons, font and wallpapers.
beautiful.init(config .. "/themes/base16_dark/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier,
--    awful.layout.suit.corner.nw,
--    awful.layout.suit.corner.ne,
--    awful.layout.suit.corner.sw,
--    awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = { "*", "www", "chat", "media", "8", "9", "dev" },
    layouts = { layouts[6], layouts[7], layouts[7], layouts[1], layouts[2], layouts[2], layouts[2] }
}
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Separators
spacer    = wibox.widget.textbox()
separator = wibox.widget.textbox()
spacer:set_markup(" ")
separator:set_markup("|")

-- {{{ Wibar

-- {{{ Power menu
powermenu = awful.menu({ items = {
    { "lock", "/usr/lib/kscreenlocker_greet" },
    { "suspend", "qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement Suspend" },
    { "reboot", "systemctl reboot" },
    { "shutdown", "systemctl poweroff" }
  }
})

powerwidget = wibox.widget.textbox()
powerwidget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.fg_focus .. '"></span>')
powerwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function (c) powermenu:toggle() end)
))
-- }}}

-- {{{ CPU usage
cpuwidget = lain.widget.sysload({
  timeout = 5,
  settings = function()
    widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_cpu_fg .. '"></span> <span color="' .. beautiful.widget_cpu_fg .. '">' .. load_1 .. '</span>')
  end
})
--cpuwidget = lain.widget.cpu({
--  timeout = 2,
--  settings = function()
--    widget:set_markup('<span color="' .. beautiful.widget_cpu_fg .. '">' .. cpu_now.usage .. '</span>')
--  end
--})

cpuwidget.widget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(terminal .. " -e htop") end)))

local cpunotification
cpuwidget.widget:connect_signal("mouse::enter", function()
  local cpuusage
  lain.widget.cpu({
    settings = function()
      cpuusage = cpu_now.usage
    end
  })

  local ramtotal
  local ramusage
  local swaptotal
  local swapusage
  lain.widget.mem({
    settings = function()
      ramusage = mem_now.used
      ramtotal = mem_now.total
      swapusage = mem_now.swapused
      swaptotal = mem_now.swapf
    end
  })
  cpunotification = naughty.notify({
    text = "CPU: " .. cpuusage .. "%\nRAM: " .. ramusage .. "/" .. ramtotal .. " MB\nSWAP: " .. swapusage .. "/" .. swaptotal .. " MB",
    position = "top_right"
  })
end)
cpuwidget.widget:connect_signal("mouse::leave", function()
  if (cpunotification ~= nil) then
    naughty.destroy(cpunotification)
    cpunotification = nil
  end
end)

-- }}}


-- {{{ Battery state
local remainingtime
batwidget = lain.widget.bat({
  timeout = 60,
  battery = "BAT0",
  notify = "off",
  settings = function()
    remainingtime = bat_now.time
    if bat_now.status == "Charging" or bat_now.status == "Full" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"></span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif tonumber(bat_now.perc) > 50 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"></span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    else
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_batlow_fg .. '"></span> <span color="' .. beautiful.widget_batlow_fg .. '">' .. bat_now.perc .. '%</span>')
    end
  end
})
local batnotification
batwidget.widget:connect_signal("mouse::enter", function()
  batnotification = naughty.notify({
    text = "Remaining time: " .. remainingtime,
    position = "top_right"
  })
end)
batwidget.widget:connect_signal("mouse::leave", function()
  if (batnotification ~= nil) then
    naughty.destroy(batnotification)
    batnotification = nil
  end
end)
-- }}}

-- {{{ Volume information
volwidget = lain.widget.pulse({
  settings = function()
    if volume_now.muted == "yes" or volume_now.left == "0%" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.left .. '</span>')
    elseif tonumber(volume_now.left) > 80 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.left .. '</span>')
    elseif tonumber(volume_now.left) > 40 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.left .. '</span>')
    else
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.left .. '</span>')
    end
  end
})

volwidget.widget:buttons(awful.util.table.join(
     awful.button({ }, 1,
     function() awful.util.spawn_with_shell('pactl set-sink-mute @DEFAULT_SINK@ toggle') end),
     awful.button({ }, 4,
     function() awful.util.spawn_with_shell('pactl set-sink-volume @DEFAULT_SINK@ +10%') end),
     awful.button({ }, 5,
     function() awful.util.spawn_with_shell('pactl set-sink-volume @DEFAULT_SINK@ -10%') end)
))
-- }}}

-- {{{ Wireless
wifiwidget = awful.widget.watch("bash -c 'nmcli -g ssid,active dev wifi | grep \":yes\" | sed \"s/:yes//\"'", 10, function(widget, stdout)
  if stdout ~= '' then
    widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_wifi_fg .. '"></span> <span color="' .. beautiful.widget_wifi_fg .. '">' .. stdout .. '</span>')
  else
    widget:set_markup('')
  end
end)

wifiwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("kcmshell5 kcm_networkmanagement") end)))

local wifinotification
wifiwidget:connect_signal("mouse::enter", function()
  local f = assert(io.popen("nmcli -f bssid,active dev wifi | grep ' yes' | sed 's/ yes//'"))
  local wifiaccesspoint = f:read()
  f:close()

  f = assert(io.popen("nmcli -g signal,active dev wifi | grep ':yes' | sed 's/:yes//'"))
  local wifiquality = f:read()
  f:close()

  if wifiaccesspoint ~= nil and wifiquality ~= nil then
    wifinotification = naughty.notify({
      text = "Access Point: " .. wifiaccesspoint .. "\nSignal: " .. wifiquality .. "%",
      position = "top_right"
    })
  end
end)
wifiwidget:connect_signal("mouse::leave", function()
  if wifinotification ~= nil then
    naughty.destroy(wifinotification)
    wifinotification = nil
  end
end)
-- }}}


-- Keyboard map indicator and switcher
--mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Date and time
dateicon = wibox.widget.textbox()
--dateicon:set_markup('<span font="' .. beautiful.iconFont .. '"></span> ')
datewidget = awful.widget.textclock("%A, %R")
lain.widget.cal({
  attach_to = { datewidget },
  notification_preset = { font = "Source Code Pro 9", bg = beautiful.bg_normal, fg = beautiful.fg_normal }
})
-- }}}

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )
local tasklist_buttons = gears.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
  end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag(tags.names, s, tags.layouts)

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts,  1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts,  1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.noempty, taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(s.mylayoutbox)
    left_layout:add(s.mytaglist)
    left_layout:add(s.mypromptbox)

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    if s.index == 1 then
--        right_layout:add(memicon)
--        right_layout:add(memwidget)
--        right_layout:add(dnicon)
--        right_layout:add(netwidget)
--        right_layout:add(upicon)
        right_layout:add(wifiwidget)
        right_layout:add(spacer)
        right_layout:add(volwidget.widget)
        right_layout:add(spacer)
        right_layout:add(batwidget.widget)
        right_layout:add(spacer)
--        right_layout:add(chaticon)
        right_layout:add(cpuwidget.widget)
        right_layout:add(spacer)
        right_layout:add(wibox.widget.systray())
        right_layout:add(spacer)
    end
    right_layout:add(dateicon)
    right_layout:add(datewidget)
    right_layout:add(spacer)
    right_layout:add(powerwidget)

    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    layout:set_middle(s.mytasklist)
    layout:set_right(right_layout)

    s.mywibox:set_widget(layout)
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () menu = awful.menu.clients({ theme = { width = 300 } }) end),
    awful.button({ }, 3, nil, function () menu:hide() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
              {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
              {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),

    awful.key({ "Mod1",           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ "Mod1", "Shift"   }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
--    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
--              {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", function () powermenu:show() end,
              {description = "Show powermenu", group = "awesome"}),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts, 1)        end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1)       end,
              {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                      client.focus = c
                      c:raise()
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
              {description = "run prompt", group = "launcher"}),

--    awful.key({ modkey }, "x",
--              function ()
--                  awful.prompt.run {
--                    prompt       = "Run Lua code: ",
--                    textbox      = awful.screen.focused().mypromptbox.widget,
--                    exe_callback = awful.util.eval,
--                    history_path = awful.util.get_cache_dir() .. "/history_eval"
--                  }
--              end,
--              {description = "lua execute prompt", group = "awesome"}),
    -- Menubar
--    awful.key({ modkey }, "p", function() menubar.show() end,
--              {description = "show the menubar", group = "launcher"})

    -- Application Switcher
    --awful.key({ "Mod1" }, "Escape", function ()
    --  awful.menu.clients({ theme = { width = 500 } })
    --end),

    -- Print screen
    awful.key({ }, "Print", function () awful.util.spawn("spectacle") end),

    -- Volume
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ +10%") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("pactl set-sink-volume @DEFAULT_SINK@ -10%") end),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end),
    awful.key({ }, "XF86AudioMicMute", function () awful.util.spawn("pactl set-source-mute @DEFAULT_SOURCE@ toggle") end),

    -- Brightness
    awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn_with_shell("qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl setBrightness $(expr $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightness) - $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightnessMax) / 5)") end),
    awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn_with_shell("qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl setBrightness $(expr $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightness) + $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightnessMax) / 5)") end),

    -- Lock screen
    awful.key({ "Mod1", "Control" }, "l", function () awful.util.spawn("/usr/lib/kscreenlocker_greet") end),
    awful.key({ }, "XF86ScreenSaver", function () awful.util.spawn("/usr/lib/kscreenlocker_greet") end),

    -- Launcher
    awful.key({}, "XF86Launch1", function () awful.util.spawn(terminal) end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "(un)maximize", group = "client"}),
    awful.key({ modkey, "Control" }, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({ modkey, "Shift"   }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

keynumber = {1, 2, 3, 4, 8, 9, 10}
-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i, k in next, keynumber do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. k + 9,
                  function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag "..tags.names[i], group = "tag"}),
        -- Toggle tag display.
        awful.key({ modkey, "Control" }, "#" .. k + 9,
                  function ()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag " .. tags.names[i], group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. k + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag "..tags.names[i], group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. k + 9,
                  function ()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag " .. tags.names[i], group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = clientkeys,
                     buttons = clientbuttons,
                     screen = awful.screen.preferred,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                     size_hints_honor = false,
                     floating = false,
                     maximized = false
      }
    },
    { rule = { type = "dialog" },
      properties = { floating = true } },
    { rule = { instance = "kontact" },
        properties = { tag = tags.names[2] } },
    { rule_any = { class = { "mpv", "Clementine" } },
        properties = { tag = tags.names[4] } },
    { rule_any = { class = { "konversation" } },
        properties = { tag = tags.names[3] } },
    { rule_any = { class = { "Eclipse", "jetbrains-studio", "QtCreator", "Designer"} },
        except = { type = "dialog" },
        callback = function(c) awful.client.movetotag(tags[mouse.screen][0], c) end,
        properties = { maximized = true } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)

-- {{{ Autostart
-- Autostart apps after login
awful.util.spawn_with_shell("xrdb -quiet -merge -nocpp $HOME/.Xresources")
awful.util.spawn("xsetroot -cursor_name left_ptr")
--awful.util.spawn("dockd --daemon")
awful.util.spawn("start-pulseaudio-x11")
awful.util.spawn("/usr/lib/org_kde_powerdevil")
-- }}}
