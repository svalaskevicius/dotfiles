-- original author: Vic Fryzel http://github.com/vicfryzel/xmonad-config
-- then others :)

{-# LANGUAGE ImportQualifiedPost #-}

import System.Exit
import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks (ToggleStruts (..), avoidStruts, docks, manageDocks)
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ScreenCorners
import XMonad.Hooks.SetWMName

-- import XMonad.Layout.Fullscreen

import Data.Map qualified as M
import XMonad.Layout.Decoration
import XMonad.Layout.NoBorders
import XMonad.Layout.Spiral
import XMonad.StackSet qualified as W
import XMonad.Util.EZConfig (additionalKeys)
import XMonad.Util.Run (safeSpawn, spawnPipe)

import System.Environment (getEnvironment)
import XMonad.Config.Desktop
import XMonad.Hooks.EwmhDesktops
import XMonad.Prompt
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.Window

import XMonad.Actions.GridSelect

import XMonad.Actions.CycleWS

import XMonad.Layout.Spacing

-- import XMonad.Hooks.ICCCMFocus
import XMonad.Util.Dzen qualified as Dzen

import XMonad.Util.Run (runProcessWithInput)

import Control.Exception
import Data.Foldable (traverse_)
import Data.List (isInfixOf)
import System.Posix.Env (getEnv, putEnv)
import System.Process (readProcess)
import XMonad.Actions.ShowText

import Debug.Trace qualified as D

------------------------------------------------------------------------
-- Terminal
-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
-- myTerminal = "urxvt -e fish -c \"tmux -q has-session; and exec tmux attach-session -d; or exec tmux new-session -n$USER -s$USER@$HOSTNAME\""
-- myTerminal = "/usr/bin/urxvt +ls -e fish -l"
-- myTerminal = "/usr/bin/urxvt +ls -e fish -l"
-- myTerminal = "st -e fish -l -c 'tmuxinator terminal'"
myTerminal = "kitty tmux"

------------------------------------------------------------------------
-- Workspaces
-- The default number of workspaces (virtual screens) and their names.
--
myWorkspaces = ["1:term \xf120", "2:web \xf269", "3:code \xf126", "4:comms \xf075", "5:comms \xf075", "6:apps \xf080"] ++ map show [7 .. 9]

------------------------------------------------------------------------
-- Window rules
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook =
    composeAll
        [ className =? "Gnome-terminal" --> doShift "1:term \xf120"
        , resource =? "termvim" --> doShift "3:code \xf126"
        , resource =? "termtelegram" --> doShift "4:comms \xf075"
        , resource =? "cmusterm" --> doShift "9"
        , className =? "URxvt" --> doShift "1:term \xf120"
        , className =? "st-256color" --> doShift "1:term \xf120"
        , className =? "Chromium" --> doShift "2:web \xf269"
        , className =? "Google-chrome" --> doShift "2:web \xf269"
        , className =? "chromium-browser" --> doShift "2:web \xf269"
        , className =? "Chromium-browser" --> doShift "2:web \xf269"
        , className =? "vimb" --> doShift "2:web \xf269"
        , className =? "Vimb" --> doShift "2:web \xf269"
        , className =? "Firefox" --> doShift "2:web \xf269"
        , className =? "firefox" --> doShift "2:web \xf269"
        , className =? "Sublime_text" --> doShift "3:code \xf126"
        , className =? "Gvim" --> doShift "3:code \xf126"
        , className =? "Code" --> doShift "3:code \xf126"
        , className =? "jetbrains-pycharm" --> doShift "3:code \xf126"
        , className =? "jetbrains-idea-ce" --> doShift "3:code \xf126"
        , className =? "jetbrains-phpstorm" --> doShift "3:code \xf126"
        , className =? "Emacs24" --> doShift "3:code \xf126"
        , className =? "Xchat" --> doShift "4:comms \xf075"
        , className =? "HipChat" --> doShift "4:comms \xf075"
        , className =? "Slack" --> doShift "4:comms \xf075"
        , className =? "TelegramDesktop" --> doShift "4:comms \xf075"
        , className =? "Whatsie" --> doShift "4:comms \xf075"
        , className =? "Skype" --> doShift "5:comms \xf075"
        , className =? "zoom" --> doShift "5:comms \xf075"
        , className =? ".zoom " --> doShift "5:comms \xf075"
        , className =? "zoom-us" --> doShift "5:comms \xf075"
        , className =? "VirtualBox" --> doShift "6:apps \xf080"
        , className =? "Gimp" --> doShift "6:apps \xf080"
        , resource =? "desktop_window" --> doIgnore
        , className =? "Galculator" --> doFloat
        , className =? "Steam" --> doFloat
        , className =? "Gimp" --> doFloat
        , resource =? "gpicview" --> doFloat
        , className =? "MPlayer" --> doFloat
        , isFullscreen --> (doF W.focusDown <+> doFullFloat)
        ]

------------------------------------------------------------------------
-- Layouts
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
--
-- mySpacing = smartSpacing 1
myLayout =
    lessBorders (Combine Union OnlyFloat Screen) $
        avoidStruts
            ( (Tall 1 (3 / 100) (1 / 2))
                ||| (Mirror (Tall 1 (3 / 100) (1 / 2)))
                |||
                -- tabbed shrinkText tabConfig |||
                -- Full |||
                -- spiral (6/7) |||
                noBorders Full
            )

------------------------------------------------------------------------
-- Colors and borders
--
-- Colors for text and backgrounds of each tab when in "Tabbed" layout.
tabConfig =
    def
        { activeBorderColor = "#00FF00"
        , activeTextColor = "#FFCA28"
        , activeColor = "#000000"
        , inactiveBorderColor = "#7C7C7C"
        , inactiveTextColor = "#EEEEEE"
        , inactiveColor = "#000000"
        }

-- Color of current window title in xmobar.
xmobarTitleColor = "#ffeecc"

-- Color of current workspace in xmobar.
xmobarCurrentWorkspaceColor = "#ffeecc"

-- Width of the window border in pixels.
myBorderWidth = 3
myNormalBorderColor = "#303060"
myFocusedBorderColor = "#88bb66"

------------------------------------------------------------------------
-- Key bindings
--
-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

terminus = "-*-terminus-*-*-*-*-24-*-*-*-*-*-*-*"

externalCommandInPopUp :: String -> [String] -> X ()
externalCommandInPopUp c p = do
    s <- runProcessWithInput c p ""
    Dzen.dzenConfig (Dzen.onCurr (Dzen.center 800 30) Dzen.>=> Dzen.font terminus) s

myKeys conf@(XConfig{XMonad.modMask = modMask}) =
    M.fromList $
        ----------------------------------------------------------------------
        -- Custom key bindings
        --

        -- Start a terminal.  Terminal to start is specified by myTerminal variable.
        [
            ( (modMask .|. shiftMask, xK_Return)
            , spawn $ XMonad.terminal conf
            )
        , -- Lock the screen using slock.

            ( (modMask .|. controlMask, xK_l)
            , spawn "slock"
            )
        , -- Launch dmenu via yeganesh.
          ((modMask, xK_p), spawn "rofi -dpi 192 -combi-modi drun,run -show combi -modi combi")
        , -- , ((modMask, xK_p), spawn "exe=`~/.xmonad/bin/dmenu_path | yeganesh` && eval \"exec $exe\"")

          -- , ((modMask .|. mod1Mask, xK_n), spawn "~/.xmonad/bin/nmgui")

          -- Switch to single screen mode

            ( (modMask .|. mod1Mask, xK_1)
            , spawn "xrandr --output HDMI-1 --off && xrandr --output DP-1 --off"
            )
        , -- Switch to dual screen mode

            ( (modMask .|. mod1Mask, xK_2)
            , spawn "xrandr --output HDMI-1 --auto --left-of eDP-1 --set audio on && feh --bg-tile ~/.xmonad/wallpaper.png"
            )
        , --
          -- Switch to dual screen mode work

            ( (modMask .|. mod1Mask, xK_3)
            , spawn "xrandr --output DP-1 --auto --left-of eDP-1 --set audio on && feh --bg-tile ~/.xmonad/wallpaper.png"
            )
        , --
          -- Switch to dual screen mode work

            ( (modMask .|. mod1Mask, xK_4)
            , spawn "xrandr --output DP-2 --auto --left-of eDP-1 --set audio on && feh --bg-tile ~/.xmonad/wallpaper.png"
            )
        , -- Take a screenshot in select mode.
          -- After pressing this key binding, click a window, or draw a rectangle with
          -- the mouse.

            ( (modMask .|. shiftMask, xK_p)
            , spawn "~/.xmonad/bin/select-screenshot"
            )
        , -- Take full screenshot in multi-head mode.
          -- That is, take a screenshot of everything you see.

            ( (modMask .|. controlMask .|. shiftMask, xK_p)
            , spawn "~/.xmonad/bin/screenshot"
            )
        , -- Mute volume.

            ( (0, 0x1008ff12)
            , spawn "pamixer -t"
            )
        , -- Decrease volume.

            ( (0, 0x1008ff11)
            , spawn "pamixer -d 5"
            )
        , -- Increase volume.

            ( (0, 0x1008ff13)
            , spawn "pamixer -u && pamixer -i 5"
            )
        , -- Audio previous.

            ( (0, 0x1008FF16)
            , spawn "mpc prev"
            )
        , -- Play/pause.

            ( (0, 0x1008FF14)
            , spawn "mpc toggle"
            )
        , -- Audio next.

            ( (0, 0x1008FF17)
            , spawn "mpc next"
            )
        , -- Eject CD tray.

            ( (0, 0x1008FF2C)
            , spawn "eject -T"
            )
        , -- Keyboard Brightness Up

            ( (0, 0x1008ff05)
            , spawn "kbdlight up"
            )
        , -- Keyboard Brightness Down

            ( (0, 0x1008ff06)
            , spawn "kbdlight down"
            )
        , -- Screen Brightness Up

            ( (0, 0x1008ff02)
            , spawn "light -A 10"
            )
        , -- Screen Brightness Down

            ( (0, 0x1008ff03)
            , spawn "light -U 10"
            )
        , --------------------------------------------------------------------
          -- "Standard" xmonad key bindings
          --

          -- Close focused window.

            ( (modMask .|. shiftMask, xK_c)
            , kill
            )
        , -- Cycle through the available layout algorithms.

            ( (modMask, xK_space)
            , sendMessage NextLayout
            )
        , --  Reset the layouts on the current workspace to default.

            ( (modMask .|. shiftMask, xK_space)
            , setLayout $ XMonad.layoutHook conf
            )
        , -- Resize viewed windows to the correct size.

            ( (modMask, xK_n)
            , refresh
            )
        , -- Move focus to the next window.

            ( (modMask, xK_Tab)
            , windows W.focusDown
            )
        ,
            ( (mod1Mask, xK_Tab)
            , windows W.focusDown
            )
        , -- Move focus to the next window.

            ( (modMask, xK_j)
            , windows W.focusDown
            )
        , -- Move focus to the previous window.

            ( (modMask, xK_k)
            , windows W.focusUp
            )
        ,
            ( (modMask .|. shiftMask, xK_Tab)
            , windows W.focusUp
            )
        ,
            ( (mod1Mask .|. shiftMask, xK_Tab)
            , windows W.focusUp
            )
        , -- Move focus to the master window.
          -- Move focus to the master window.

            ( (modMask, xK_m)
            , windows W.focusMaster
            )
        , -- Swap the focused window and the master window.

            ( (modMask, xK_Return)
            , windows W.swapMaster
            )
        , -- Swap the focused window with the next window.

            ( (modMask .|. shiftMask, xK_j)
            , windows W.swapDown
            )
        , -- Swap the focused window with the previous window.

            ( (modMask .|. shiftMask, xK_k)
            , windows W.swapUp
            )
        , -- Shrink the master area.

            ( (modMask, xK_h)
            , sendMessage Shrink
            )
        , -- Expand the master area.

            ( (modMask, xK_l)
            , sendMessage Expand
            )
        , -- Push window back into tiling.

            ( (modMask, xK_t)
            , withFocused $ windows . W.sink
            )
        , -- Increment the number of windows in the master area.

            ( (modMask, xK_comma)
            , sendMessage (IncMasterN 1)
            )
        , -- Decrement the number of windows in the master area.

            ( (modMask, xK_period)
            , sendMessage (IncMasterN (-1))
            )
        , -- Toggle the status bar gap.

            ( (modMask, xK_b)
            , sendMessage ToggleStruts
            )
        , -- Show grid selector

            ( (modMask, xK_g)
            , goToSelected $
                def
                    { gs_cellheight = 50
                    , gs_cellwidth = 450
                    , gs_cellpadding = 20
                    , gs_font = "xft:Hack:pixelsize=28"
                    }
            )
        , -- Quit xmonad.

            ( (modMask .|. shiftMask, xK_q)
            , confirmPrompt promptDef "Quit XMonad?" $ io (exitWith ExitSuccess)
            )
        , -- Restart xmonad.

            ( (modMask, xK_q)
            , confirmPrompt promptDef "Restart XMonad?" $ restart "xmonad" True
            )
        ]
            ++ [
                   ( (modMask .|. shiftMask, xK_g)
                   , windowPrompt promptDef{autoComplete = Just 500000} Goto allWindows
                   )
               , ((modMask .|. shiftMask, xK_b), windowPrompt promptDef Bring allWindows)
               ]
            ++
            -- mod-[1..9], Switch to workspace N
            -- mod-shift-[1..9], Move client to workspace N
            [ ((m .|. mod4Mask, k), windows $ f i)
            | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
            , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
            ]
            ++
            -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
            -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
            [ ((m .|. modMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
            | (key, sc) <- zip [xK_e, xK_w, xK_r] [0 ..]
            , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
            ]

------------------------------------------------------------------------
-- Mouse bindings
--
-- Focus rules
-- True if your focus should follow your mouse cursor.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = False

myMouseBindings (XConfig{XMonad.modMask = modMask}) =
    M.fromList $
        [ -- mod-button1, Set the window to floating mode and move by dragging

            ( (modMask .|. shiftMask, button1)
            , (\w -> focus w >> mouseMoveWindow w)
            )
        , -- mod-button2, Raise the window to the top of the stack

            ( (modMask, button2)
            , (\w -> focus w >> windows W.swapMaster)
            )
        , -- mod-button3, Set the window to floating mode and resize by dragging

            ( (modMask, button3)
            , (\w -> focus w >> mouseResizeWindow w)
            )
            -- you may also bind events to the mouse scroll wheel (button4 and button5)
        ]

------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'DynamicLog' extension for examples.
--
-- To emulate dwm's status bar
--
-- > logHook = dynamicLogDzen
--

-- logHook = takeTopFocus

------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = do
    setWMName "LG3D"
    cfgDir <- asks (cfgDir . directories)
    let initFile = cfgDir ++ "/xmonad-init"
    l <-
        runProcessWithInput
            "/usr/bin/env"
            [ "bash"
            , "-c"
            , "if test ! \"$XMONAD_INIT_DONE\" = 'y' -a -f '"
                ++ initFile
                ++ "' ; then \
                   \  export XMONAD_INIT_DONE='y'; \
                   \  source '"
                ++ initFile
                ++ "' >/dev/null 2>&1 && env ; \
                   \ fi"
            ]
            ""
    io $ traverse_ putEnv (lines l)
    -- alert "test"
    -- addScreenCorner SCLowerRight (spawn "slock")
    return ()

myEventHook e = do
    screenCornerEventHook e

------------------------------------------------------------------------
-- Run xmonad with all the defaults we set up.
--
main = do
    -- xmproc <- spawnPipe "i3status | /usr/bin/xmobar ~/.xmonad/xmobar.hs"
    -- xmproc <- spawnPipe "/run/current-system/sw/bin/xmobar ~/.xmonad/xmobar.hs"
    -- xmproc <- spawnPipe "~/.local/bin/xmobar ~/.xmonad/xmobar.hs"
    xmproc <- spawnPipe "~/.config/polybar/launch.sh"
    xmonad $
        docks $
            ewmhFullscreen
                defaults
                    { -- logHook = dynamicLogWithPP $ xmobarPP {
                      --       ppOutput = hPutStrLn xmproc
                      --     , ppTitle = xmobarColor xmobarTitleColor "" . shorten 75
                      --     , ppCurrent = xmobarColor xmobarCurrentWorkspaceColor "#777777"
                      --     , ppVisible = xmobarColor xmobarCurrentWorkspaceColor "#777777"
                      --     , ppSep = " |  "}
                      -- ,
                      manageHook = manageDocks <+> myManageHook
                    }

promptDef :: XPConfig
promptDef =
    def
        { font = "xft:Hack:pixelsize=38"
        , height = 50
        , searchPredicate = isInfixOf -- TODO: fuzzy matching
        }

alert = flashText textDef 30

textDef :: ShowTextConfig
textDef =
    def
        { st_font = "xft:Hack:pixelsize=50"
        , st_bg = "#221100"
        , st_fg = "#FF2200"
        }

------------------------------------------------------------------------
-- Combine it all together
-- A structure containing your configuration settings, overriding
-- fields in the default config. Any you don't override, will
-- use the defaults defined in xmonad/XMonad/Config.hs
--
-- No need to modify this.
--
defaults =
    disableEwmhManageDesktopViewport . ewmh $
        def
            { -- simple stuff
              terminal = myTerminal
            , focusFollowsMouse = myFocusFollowsMouse
            , borderWidth = myBorderWidth
            , modMask = myModMask
            , workspaces = myWorkspaces
            , normalBorderColor = myNormalBorderColor
            , focusedBorderColor = myFocusedBorderColor
            , -- key bindings
              keys = myKeys
            , mouseBindings = myMouseBindings
            , -- hooks, layouts
              layoutHook = myLayout
            , manageHook = myManageHook
            , startupHook = myStartupHook
            , -- make fullscreen work in chromium
              handleEventHook = handleTimerEvent <+> myEventHook
            }
