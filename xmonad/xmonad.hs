--
-- xmonad config file.
--

import XMonad
import XMonad.Actions.GridSelect
import XMonad.Actions.CycleWS
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.SetWMName
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.SimplestFloat
import XMonad.Prompt.Shell
import XMonad.Prompt
import XMonad.Util.Run(spawnPipe)
--import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map        as M

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal :: [Char]
myTerminal = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = False

-- Width of the window border in pixels.
--
myBorderWidth :: Dimension
myBorderWidth = 1

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask :: KeyMask
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
myWorkspaces = ["*","mail","chat","media"] ++ map show [5..9] ++ ["dev"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor :: [Char]
myNormalBorderColor  = "#383838"
myFocusedBorderColor :: [Char]
myFocusedBorderColor = "#a1b56c"

powerMenu :: [(String, X ())]
powerMenu = [ ("lock" , spawn "/usr/lib/kscreenlocker_greet")
            , ("suspend" , spawn "qdbus org.kde.Solid.PowerManagement /org/freedesktop/PowerManagement Suspend")
            , ("reboot" , spawn "systemctl reboot")
            , ("shutdown" , spawn "systemctl poweroff")
            ]

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
--
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $

    -- launch a terminal
    [ ((modm,               xK_Return), spawn $ XMonad.terminal conf)

    -- launch dmenu
    , ((modm,               xK_r     ), shellPrompt myXPConfig)

    -- close focused window
    , ((modm .|. shiftMask, xK_c     ), kill)

    , ((controlMask .|. mod1Mask, xK_Escape), spawn "xkill")

     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)

    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)

    -- Resize viewed windows to the correct size
    , ((modm,               xK_n     ), refresh)

    -- Move focus to the next window when they are overlapping
    , ((modm,               xK_Tab   ), windows W.focusUp >> windows W.shiftMaster)

    -- Move focus to the next window
    , ((mod1Mask,           xK_Tab   ), windows W.focusDown)

    -- Move focus to the next window
    , ((modm,               xK_j     ), windows W.focusDown)

    -- Move focus to the previous window
    , ((modm,               xK_k     ), windows W.focusUp  )

    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )

    -- Swap the focused window and the master window
    , ((modm .|. shiftMask, xK_Return), windows W.swapMaster)

    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_j     ), windows W.swapDown  )

    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_k     ), windows W.swapUp    )

    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)

    -- Expand the master area
    , ((modm,               xK_l     ), sendMessage Expand)

    -- Push window back into tiling
    , ((modm,               xK_t     ), withFocused $ windows . W.sink)

    -- Increment the number of windows in the master area
    , ((modm              , xK_comma ), sendMessage (IncMasterN 1))

    -- Deincrement the number of windows in the master area
    , ((modm              , xK_period), sendMessage (IncMasterN (-1)))

    , ((controlMask .|. mod1Mask, xK_l), runSelectedAction def powerMenu)

    --, ((controlMask .|. mod1Mask, xK_l), spawn "/usr/lib/kscreenlocker_greet")

    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)

    -- Quit xmonad
    --, ((modm .|. shiftMask, xK_q     ), io (exitWith ExitSuccess))

    -- Restart xmonad
    , ((modm              , xK_q     ), spawn "xmonad --recompile; xmonad --restart")

    -- Run xmessage with a summary of the default keybindings (useful for beginners)
    --, ((modm .|. shiftMask, xK_slash ), spawn ("echo \"" ++ help ++ "\" | xmessage -file -"))
    ]
    ++

    --
    -- mod-[1..0], Switch to workspace N
    -- mod-shift-[1..0], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) ([xK_1 .. xK_9] ++ [xK_0])
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++

    -- mod-{w,e}, Switch to previous/next Xinerama screen
    -- mod-shift-{w,e}, Move client to previous/next Xinerama screen
    --
    [((m .|. modm, key), sc >>= screenWorkspace >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e] [(screenBy (-1)),(screenBy 1)]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

    -- Audio bindings
    ++
    [ ((0, 0x1008ff13), spawn "pactl set-sink-volume @DEFAULT_SINK@ +10%") -- XF86AudioRaiseVolume
    , ((0, 0x1008ff11), spawn "pactl set-sink-volume @DEFAULT_SINK@ -10%") -- XF86AudioLowerVolume
    , ((0, 0x1008ff12), spawn "pactl set-sink-mute @DEFAULT_SINK@ toggle") -- XF86AudioMute
    , ((0, 0x1008ffb2), spawn "pactl set-source-mute @DEFAULT_SOURCE@ toggle") -- XF86AudioMicMute
    ]

    -- Media bindings
    ++
    [ ((0, 0x1008ff14), spawn "qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 PlayPause") -- XF86AudioPlay
    , ((0, 0x1008ff16), spawn "qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 Previous") -- XF86AudioPrev
    , ((0, 0x1008ff17), spawn "qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 Next") -- XF86AudioNext
    , ((0, 0x1008ff15), spawn "qdbus org.mpris.MediaPlayer2.clementine /org/mpris/MediaPlayer2 Stop") -- XF86AudioStop
    ]

    -- Brightness bindings
    ++
    [ ((0, 0x1008ff03), spawn "qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl setBrightness $(expr $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightness) - $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightnessMax) / 5)") -- XF86MonBrightnessDown
    , ((0, 0x1008ff02), spawn "qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl setBrightness $(expr $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightness) + $(qdbus org.freedesktop.PowerManagement /org/kde/Solid/PowerManagement/Actions/BrightnessControl brightnessMax) / 5)") -- XF86MonBrightnessUp
    ]

    -- Extra bindings
    ++
    [ ((0, 0x1008ff41), spawn myTerminal) -- XF86Launch1
    , ((0, 0x1008ff2d), spawn "/usr/lib/kscreenlocker_greet") -- XF86ScreenSaver
    , ((0, xK_Print  ), spawn "spectacle") -- XF86Print
    --, ((0, 0x1008ff93), spawn "") -- XF86Battery
    ]

myXPConfig :: XPConfig
myXPConfig = def
    { font                = "xft:Source Code Pro:size=9"
    , bgColor             = "#181818"
    , fgColor             = "#a1b56c"
    , fgHLight            = "#d8d8d8"
    , bgHLight            = "#181818"
    , borderColor         = "#181818"
    , promptBorderWidth   = 0
    , position            = Top
    , height              = 18
    , showCompletionOnTab = True
    }

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) = M.fromList $

    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w
                                       >> windows W.shiftMaster))

    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))

    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w
                                       >> windows W.shiftMaster))

    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Layouts:

-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout = avoidStruts $

    -- borders automatically disappear for fullscreen windows
    smartBorders $

    -- custom layouts per workspaces
    onWorkspace "mail" Full $
    onWorkspace "media" simplestFloat $
    onWorkspace "9" (Mirror tiled) $
    onWorkspace "dev" Full $

    tiled ||| Mirror tiled ||| Full ||| simplestFloat
    where
       -- default tiling algorithm partitions the screen into two panes
      tiled   = Tall nmaster delta ratio

      -- The default number of windows in the master pane
      nmaster = 1

      -- Default proportion of screen occupied by master pane
      ratio   = 1/2

      -- Percent of screen to increment by when resizing panes
      delta   = 3/100

------------------------------------------------------------------------
-- Window rules:

-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
myManageHook = composeAll
    [ resource  =? "kontact"           --> doShift "mail"
    , className =? "konversation"      --> doShift "chat"
    , className =? "mpv"               --> doFloat <+> doShift "media"
    , className =? "Clementine"        --> doShift "media"
    , className =? "Eclipse"           --> doShift "dev"
    , className =? "QtCreator"         --> doShift "dev"
    , className =? "jetbrains-studio"  --> doShift "dev"
    , className =? "stalonetray"       --> doIgnore
    , isFullscreen                     --> doFullFloat
    , isDialog                         --> doCenterFloat
    ]

------------------------------------------------------------------------
-- Event handling

-- * EwmhDesktops users should change this to ewmhDesktopsEventHook
--
-- Defines a custom handler function for X Events. The function should
-- return (All True) if the default handler is to be run afterwards. To
-- combine event hooks use mappend or mconcat from Data.Monoid.
--
myEventHook = docksEventHook

------------------------------------------------------------------------
-- Status bars and logging

-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
--myLogHook = dynamicLogWithPP $ xmobarPP

------------------------------------------------------------------------
-- Startup hook

-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
myStartupHook :: X()
myStartupHook = setWMName "LG3D" -- pre java 7 workaround for some apps

------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.

-- Run xmonad with the settings you specify.
--
main :: IO()
main = do
    xmproc <- spawnPipe "xmobar"
    xmonad $ defaults
        { logHook = dynamicLogWithPP $ xmobarPP
            { ppOutput  = hPutStrLn xmproc
            , ppCurrent = xmobarColor "#d0d0d0" "#151515"
            , ppUrgent  = xmobarColor "#202020" "#ac4142"
            , ppVisible = xmobarColor "#90a959" "#151515"
            , ppSep     = " ~ "
            , ppOrder   = \(ws:_:t:_) -> [ws,t]
            , ppTitle   = xmobarColor "#d0d0d0" "" . shorten 140
            }
        }

-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
defaults = def
    { terminal           = myTerminal
    , focusFollowsMouse  = myFocusFollowsMouse
    , clickJustFocuses   = myClickJustFocuses
    , borderWidth        = myBorderWidth
    , modMask            = myModMask
    , workspaces         = myWorkspaces
    , normalBorderColor  = myNormalBorderColor
    , focusedBorderColor = myFocusedBorderColor
    , keys               = myKeys
    , mouseBindings      = myMouseBindings
    , layoutHook         = myLayout
    , manageHook         = myManageHook
    , handleEventHook    = myEventHook
    , startupHook        = myStartupHook
    }
