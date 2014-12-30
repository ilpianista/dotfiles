-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
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
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
local config = awful.util.getdir("config")
-- Themes define colours, icons, font and wallpapers.
beautiful.init(config .. "/themes/base16_dark/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = os.getenv("TERMINAL") or "konsole"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
--    awful.layout.suit.fair,
--    awful.layout.suit.fair.horizontal,
--    awful.layout.suit.spiral,
--    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
--    awful.layout.suit.max.fullscreen,
--    awful.layout.suit.magnifier,
--    lain.layout.termfair,
--    lain.layout.centerfair,
--    lain.layout.cascade,
--    lain.layout.cascadetile,
--    lain.layout.centerwork,
--    lain.layout.uselessfair
--    lain.layout.uselesspiral,
    lain.layout.uselesstile
}

-- gaps width
theme.useless_gap_width = 15
-- }}}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {
    names = { "*", "www", "media", "chat", "8", "9", "dev" },
    layouts = { layouts[7], layouts[6], layouts[6], layouts[2], layouts[2], layouts[2], layouts[2] }
}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tags.names, s, tags.layouts)
end
-- }}}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Separators
spacer    = wibox.widget.textbox()
separator = wibox.widget.textbox()
spacer:set_markup(" ")
separator:set_markup("|")

-- {{{ Wibox

-- {{{ Power menu
powermenu = awful.menu({ items = {
    { "lock", "qdbus org.kde.ksmserver /ScreenSaver Lock" },
    { "suspend", "qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement Suspend" },
    { "reboot", "qdbus org.kde.ksmserver /KSMServer logout 0 1 0" },
    { "shutdown", "qdbus org.kde.ksmserver /KSMServer logout 0 2 0" }
  }
})

powerwidget = wibox.widget.textbox()
powerwidget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.fg_focus .. '"></span>')
powerwidget:buttons(awful.util.table.join(
  awful.button({ }, 1, function (c) powermenu:toggle() end)
))
-- }}}

-- {{{ CPU usage
cpuwidget = lain.widgets.sysload({
  timeout = 5,
  settings = function()
    widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_cpu_fg .. '"></span> <span color="' .. beautiful.widget_cpu_fg .. '">' .. load_1 .. '</span>')
  end
})
--cpuwidget = lain.widgets.cpu({
--  timeout = 2,
--  settings = function()
--    widget:set_markup('<span color="' .. beautiful.widget_cpu_fg .. '">' .. cpu_now.usage .. '</span>')
--  end
--})

cpuwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(terminal .. " -e htop") end)))

local cpunotification
cpuwidget:connect_signal("mouse::enter", function()
  local cpuusage
  lain.widgets.cpu({
    settings = function()
      cpuusage = cpu_now.usage
    end
  })

  local ramtotal
  local ramusage
  local swaptotal
  local swapusage
  lain.widgets.mem({
    settings = function()
      ramusage = mem_now.used
      ramtotal = mem_now.total
      swapusage = mem_now.swapused
      swaptotal = mem_now.swapf
    end
  })
  cpunotification = naughty.notify({
    text = "CPU: " .. cpuusage .. "%\nRAM: " .. ramusage .. "/" .. ramtotal .. " MB\nSWAP: " .. swapusage .. "/" .. swaptotal .. " MB",
    position = "top_right",
    timeout = 0
  })
end)
cpuwidget:connect_signal("mouse::leave", function()
  if (cpunotification ~= nil) then
    naughty.destroy(cpunotification)
    cpunotification = nil
  end
end)

-- }}}


-- {{{ Battery state
local remainingtime
batwidget = lain.widgets.bat({
  timeout = 60,
  battery = "BAT0",
  notify = "off",
  settings = function()
    remainingtime = bat_now.time
    if bat_now.status == "Charging" or bat_now.status == "Full" then
      widget:set_markup('<span font="' ..  beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"></span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif tonumber(bat_now.perc) > 60 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"></span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif tonumber(bat_now.perc) > 20 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"></span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    else
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_batlow_fg .. '"></span> <span color="' .. beautiful.widget_batlow_fg .. '">' .. bat_now.perc .. '%</span>')
    end
  end
})
local batnotification
batwidget:connect_signal("mouse::enter", function()
  batnotification = naughty.notify({
    text = "Remaining time: " .. remainingtime,
    position = "top_right",
    timeout = 0
  })
end)
batwidget:connect_signal("mouse::leave", function()
  if (batnotification ~= nil) then
    naughty.destroy(batnotification)
    batnotification = nil
  end
end)
-- }}}

-- {{{ Volume information
volwidget = lain.widgets.alsa({
  timeout = 2,
  channel = "Master",
  settings = function()
    if volume_now.status == "off" or volume_now.level == "0" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.level .. '</span>')
    elseif tonumber(volume_now.level) > 80 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.level .. '</span>')
    elseif tonumber(volume_now.level) > 40 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.level .. '</span>')
    else
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg .. '"></span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.level .. '</span>')
    end
  end
})

volwidget:buttons(awful.util.table.join(
     awful.button({ }, 1,
     function() awful.util.spawn_with_shell("amixer -q set Master toggle") end),
     awful.button({ }, 4,
     function() awful.util.spawn_with_shell("amixer -q set Master 5%+ unmute") end),
     awful.button({ }, 5,
     function() awful.util.spawn_with_shell("amixer -q set Master 5%- unmute") end)
))
-- }}}

-- {{{ Wireless
wifiwidget = lain.widgets.base({
  cmd = "iwgetid -r",
  settings = function()
    if output ~= nil and output ~= '' then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_wifi_fg .. '"></span> <span color="' .. beautiful.widget_wifi_fg .. '">' .. output .. '</span>')
    else
      widget:set_markup('')
    end
  end
})

wifiwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("kde5-nm-connection-editor") end)))

local wifinotification
wifiwidget:connect_signal("mouse::enter", function()
  local f = assert(io.popen("iwgetid -ar"))
  local wifiaccesspoint = f:read()
  f:close()

  f = assert(io.popen("iwconfig wlan0 | grep 'Link Quality' | awk '{print $2}' | awk -F'=' '{print $2}'"))
  local wifiquality = f:read()
  f:close()

  wifinotification = naughty.notify({
    text = "Access Point: " .. wifiaccesspoint .. "\nLink Quality: " .. wifiquality,
    position = "top_right",
    timeout = 0
  })
end)
wifiwidget:connect_signal("mouse::leave", function()
  if (wifinotification ~= nil) then
    naughty.destroy(wifinotification)
    wifinotification = nil
  end
end)
-- }}}

-- {{{ Date and time
dateicon = wibox.widget.textbox()
--dateicon:set_markup('<span font="' .. beautiful.iconFont .. '"></span> ')
datewidget = awful.widget.textclock("%A, %R")
lain.widgets.calendar:attach(datewidget, { icons = '', font = "Anonymous Pro", font_size = 10 })
-- }}}

-- {{{ Launcher
--app1icon = wibox.widget.imagebox()
--app1icon:set_image(beautiful.widget_chat)
--app1icon:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn("ktp-contactlist") end)))
-- }}}

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, awful.tag.viewonly),
                    awful.button({ modkey }, 1, awful.client.movetotag),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, awful.client.toggletag),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
                    )
mytasklist = {}
--mytasklist.buttons = awful.util.table.join(
--                     awful.button({ }, 1, function (c)
--                                              if c == client.focus then
--                                                  c.minimized = true
--                                              else
--                                                  -- Without this, the following
--                                                  -- :isvisible() makes no sense
--                                                  c.minimized = false
--                                                  if not c:isvisible() then
--                                                      awful.tag.viewonly(c:tags()[1])
--                                                  end
--                                                  -- This will also un-minimize
--                                                  -- the client, if needed
--                                                  client.focus = c
--                                                  c:raise()
--                                              end
--                                          end),
--                     awful.button({ }, 3, function ()
--                                              if instance then
--                                                  instance:hide()
--                                                  instance = nil
--                                              else
--                                                  instance = awful.menu.clients({
--                                                    theme = { width = 250 }
--                                                  })
--                                              end
--                                          end),
--                     awful.button({ }, 4, function ()
--                                              awful.client.focus.byidx(1)
--                                              if client.focus then client.focus:raise() end
--                                          end),
--                     awful.button({ }, 5, function ()
--                                              awful.client.focus.byidx(-1)
--                                              if client.focus then client.focus:raise() end
--                                          end))

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
                           awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.focused)
    theme.tasklist_disable_icon = true

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", height = "20", screen = s })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(mylayoutbox[s])
    left_layout:add(mytaglist[s])
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()

    if s == 1 then
--        right_layout:add(memicon)
--        right_layout:add(memwidget)
--        right_layout:add(dnicon)
--        right_layout:add(netwidget)
--        right_layout:add(upicon)
        right_layout:add(wifiwidget)
        right_layout:add(spacer)
        right_layout:add(volwidget)
        right_layout:add(spacer)
        right_layout:add(batwidget)
        right_layout:add(spacer)
--        right_layout:add(chaticon)
        right_layout:add(cpuwidget)
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
    layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () menu = awful.menu.clients({ theme = { width = 300 } }) end),
    awful.button({ }, 3, nil, function () menu:hide() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

    awful.key({ "Mod1",           }, "Tab",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ "Mod1", "Shift"   }, "Tab",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
--    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
--    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ "Control", "Mod1" }, "Escape", function () awful.util.spawn("xkill") end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

--    awful.key({ modkey }, "x",
--              function ()
--                  awful.prompt.run({ prompt = "Run Lua code: " },
--                  mypromptbox[mouse.screen].widget,
--                  awful.util.eval, nil,
--                  awful.util.getdir("cache") .. "/history_eval")
--              end),
    -- Menubar
--    awful.key({ modkey }, "p", function() menubar.show() end),

    -- Application Switcher
    --awful.key({ "Mod1" }, "Escape", function ()
    --  awful.menu.clients({ theme = { width = 500 } })
    --end),

    -- Print screen
    awful.key({ }, "Print", function () awful.util.spawn("ksnapshot") end),

    -- Volume
    awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -q set Master 5%+ unmute") end),
    awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -q set Master 5%- unmute") end),
    awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -q set Master toggle") end),
    awful.key({ }, "XF86AudioMicMute", function () awful.util.spawn("amixer -q set Capture toggle") end),

    -- Brightness
  --awful.key({ }, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end),
  --awful.key({ }, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end),

  -- Lock screen
  --awful.key({ }, "XF86ScreenSaver", function () awful.util.spawn("slock") end),

    -- Launcher
    awful.key({}, "XF86Launch1", function () awful.util.spawn("firefox") end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
--keynumber = 0
--for s = 1, screen.count() do
--   keynumber = math.min(10, math.max(#tags[s], keynumber));
--end
keynumber = {1, 2, 3, 4, 8, 9, 10}

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i, k in next, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. k + 9,
                  function ()
                        local screen = mouse.screen
                        local tag = awful.tag.gettags(screen)[i]
                        if tag then
                           awful.tag.viewonly(tag)
                        end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. k + 9,
                  function ()
                      local screen = mouse.screen
                      local tag = awful.tag.gettags(screen)[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. k + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.movetotag(tag)
                          end
                      end
                  end),
        -- Toggle tag.
        awful.key({ modkey, "Control", "Shift" }, "#" .. k + 9,
                  function ()
                      if client.focus then
                          local tag = awful.tag.gettags(client.focus.screen)[i]
                          if tag then
                              awful.client.toggletag(tag)
                          end
                      end
                  end))
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
                     floating = false,
                     maximized = false } },
    { rule = { type = "dialog" },
      properties = { floating = true } },
    { rule = { instance = "kontact" },
        properties = { tag = tags[1][2] } },
    { rule_any = { instance = { "gimp" } },
        except = { type = "dialog" },
        properties = { maximized = true } },
    { rule_any = { instance = { "choqok", "dia", "kruler" } },
        properties = { floating = true,
          maximized = false } },
    { rule_any = { class = { "Amarok", "cantata" } },
        properties = { tag = tags[1][3] } },
    { rule = { class = "Vlc" },
        callback = function(c) awful.client.movetotag(tags[mouse.screen][3], c) end,
        properties = { floating = true } },
    { rule_any = { class = { "Firefox" } },
       callback = function(c) awful.client.movetotag(tags[mouse.screen][2], c) end },
    { rule_any = { class = { "Konversation", "Ktp-contactlist", "Ktp-text-ui", "Skype" } },
        properties = { tag = tags[1][4] } },
    { rule = { class = "Gvim" },
        except = { type = "dialog" },
        callback = function(c) awful.client.movetotag(tags[mouse.screen][7], c) end,
        properties = { size_hints_honor = false,
          maximized = true } },
    { rule_any = { class = { "jetbrains-idea", "Kdevelop", "Kate", "QtCreator",
          "Designer-qt4", "Designer-qt5", "JavaFXSceneBuilder" } },
        except = { type = "dialog" },
        callback = function(c) awful.client.movetotag(tags[mouse.screen][7], c) end,
        properties = { maximized = true } }
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    local titlebars_enabled = false
    if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
        -- buttons for the titlebar
        local buttons = awful.util.table.join(
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

        -- Widgets that are aligned to the left
        local left_layout = wibox.layout.fixed.horizontal()
        left_layout:add(awful.titlebar.widget.iconwidget(c))
        left_layout:buttons(buttons)

        -- Widgets that are aligned to the right
        local right_layout = wibox.layout.fixed.horizontal()
        right_layout:add(awful.titlebar.widget.floatingbutton(c))
        right_layout:add(awful.titlebar.widget.maximizedbutton(c))
        right_layout:add(awful.titlebar.widget.stickybutton(c))
        right_layout:add(awful.titlebar.widget.ontopbutton(c))
        right_layout:add(awful.titlebar.widget.closebutton(c))

        -- The title goes in the middle
        local middle_layout = wibox.layout.flex.horizontal()
        local title = awful.titlebar.widget.titlewidget(c)
        title:set_align("center")
        middle_layout:add(title)
        middle_layout:buttons(buttons)

        -- Now bring it all together
        local layout = wibox.layout.align.horizontal()
        layout:set_left(left_layout)
        layout:set_right(right_layout)
        layout:set_middle(middle_layout)

        awful.titlebar(c):set_widget(layout)
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- {{{ Autostart
-- Autostart apps after login
--awful.util.spawn_with_shell("xrdb -quiet -merge -nocpp $HOME/.Xresources")
--awful.util.spawn_with_shell("xsetroot -cursor_name left_ptr")
-- }}}
