# xmonad config

Credit to the original authors of the config:

> @svalaskevicius - the current user :)
> This is [Marco Lopes](https://github.com/mlopes/dotfiles/)'s xmonad and xmobar configuration.
> This configuration is rooted in the [xmonad](http://xmonad.org/) configuration used by Vic Fryzel as it was circa 2013, and was heavily customised since then. Years of customisations have left litle in common with the original configuration.

Time to change and adapt it again :)

## Introduction

If you are unfamiliar with xmonad, it is a tiling window manager that is
notoriously minimal, stable, beautiful, and featureful.  If you find yourself
spending a lot of time organising or managing windows, you may consider trying
xmonad.

However, xmonad can be somewhat difficult to configure if you're new to
Haskell or even to xmonad itself.

This folder contains a completely working and very usable xmonad
configuration "out of the box". If you are just starting out with xmonad,
this will give you a configuration that I've been using personally for
work every day. Thought has been put into the colours, key bindings, layouts,
and supplementary scripts to make life easier.

<img src="https://github.com/svalaskevicius/dotfiles/raw/xps/.xmonad/screenshot.png" width="500px">

## Dependencies

* [xmonad](http://xmonad.org/) (currently being used in 0.13)
* [xmonad-contrib](http://hackage.haskell.org/package/xmonad-contrib) (currently being used in 0.13)
* [xmobar](http://projects.haskell.org/xmobar/) (currently being used with 0.24.5 with compiled with alsa support)
* [rofi](https://davedavenport.github.io/rofi/)
* [scrot](http://freecode.com/projects/scrot)
* [slock](http://tools.suckless.org/slock/)
* [mpd](https://www.musicpd.org/) (and mpc to control it via Keybindings)
* [fish shell](https://fishshell.com/)
* kitty
* pulseaudio + amixer // TODO: pamixer?
* tmux
* xrandr
* kbdlight
* xbacklight

### Dependencies used while starting X and xmonad

* xsetroot - Used to set the background to black and the mouse to a left pointer
* setxbmap - Used to set X's keyboard layout. Default is set to `gb`
* xmodmap - Used to remap Caps Lock to Ctrl and to set AltGr+a, e, i, n, and c to dead \`, dead ', dead ^, dead ~, and ç, respectively
* xcompmgr - Used to enable composide mode, shadows and transparencies on xmonad windows
* feh - Used to set the wallpaper. Will use the file in
  `~/.xmonad/wallpaper.png`


## Starting xmonad when logging in from a specific tty (example uses tty1)

Add the following to your `~/.bash_profile` file

    if [ "$(tty)" = "/dev/tty1" ]; then
        exec startx
    fi


Add the following to your `~/.xinitrc` file

    exec xmonad


## Keyboard shortcuts

The following keyboard shortcuts are set in this configuration. It uses the `Win Key` in a PC or the `Command Key` on a
Mac.

* `Win+Shift+Return`: Start an instance of the terminal running the fish shell, which will open on Workspace 1
* `Win+Alt+Return`: Start an instance of the terminal running fish on tmux, which will open on Workspace 3
* `Win+Ctrl+l`: Lock screen
* `Win+p`: Run the rofi launcher.  Once it comes up, type the name of a programme and press enter to launch it
* `Win+Shift+p`: Take screenshot in select mode. Click or click and drag to select
* `Win+Ctrl+Shift+p`: Take fullscreen screenshot. Supports multiple monitors
* `Win+Shift+c`: Close focused window
* `Win+Space`: Change workspace layout
* `Win+Shift+Space`: Change back to default workspace layout
* `Win+n`: Resize viewed windows to the correct size
* `Win+Tab`: Focus next window
* `Alt+Tab`: Focus next window
* `Win+j`: Focus next window
* `Win+k`: Focus previous window
* `Win+m`: Focus master window
* `Win+Return`: Swap focused window with master window
* `Win+Shift+j`: Swap focused window with next window
* `Win+Shift+k`: Swap focused window with previous window
* `Win+h`: Shrink master window area
* `Win+l`: Expand master window area
* `Win+t`: Push floating window back into tiling
* `Win+,`: Increment number of windows in master window area
* `Win+.`: Decrement number of windows in master window area
* `Win+q`: Reload xmonad. This reloads xmonad configuration, does not logout
* `Win+Shift+q`: Quit xmonad and logout
* `Win+[1-9]`: Switch to workspace 1-9, depending on which number was pressed
* `Win+Shift+[1-9]`: Send focused window to workspace 1-9
* `Win+d`: Focus left-most/internal monitor (Xinerama screen 1)
* `Win+e`: Focus centre-most/external monitor (Xinerama screen 2)
* `Win+r`: Focus right-most monitor (Xinerama screen 3)
* `Win+Shift+d`: Send focused window to workspace on left-most monitor
* `Win+Shift+e`: Send focused window to workspace on centre-most monitor
* `Win+Shift+r`: Send focused window to workspace on right-most monitor
* `Win+Alt+1`: Switch to single screen mode
* `Win+Alt+2`: Switch to dual screen mode
* `mute button`: Mutes the sound
* `volume down button`: Decreses the volume by 10%
* `volume up button`: Unmutes the sound and increases the volume by 10%
* `previous button`: Starts song again/goes to the previous song on mpd
* `play/pause button`: Starts playback or pauses mpd
* `next button`: Goes to the next song on mpd
* `eject button`: Ejects CD if the computer has a CD/DVD drive
* `keyboard brightness down`: Decreases brightness of keyboard backlight
* `keyboard brightness up`: Increases brightness of keyboard backlight
* `screen brightness down`: Decreases brightness of the screen
* `screen brightness up`: Increases brightness of the screen

### Keybindings Troubleshooting

Some of the key configurations will depend on the devices you're using.

#### Switching between single and dual screens mode doesn't work
If switching between single screen and dual screen mode doesn't work, use
`xrandr` to check if your devices correspond to the ones set in the keybinds
configuration.

#### Sound volume and mutting not working
The Keybindings for volume control and mutting sound, use `amixer` but assume
that the device is a `pulse` device. If you're not using pulseaudio, you'll have to
remove the `-D pulse` from the `amixer` calls.

#### CD won't eject
This usually means you don't have a CD/DVD drive

#### Adjusting keyboard/screen brightness doesn't work
Usually this means that your system as some misconfiguration or no ACPI
support. This configuration doesn't specify any devices for this, it relies on
`kbdlight` and `xbacklight`, if ACPI is working in your system, these
utilities should be able to dim the backlights.


## Personalising or modifying xmonad configuration

Once cloned, xmonad-config is laid out as follows.

All xmonad configuration is in ~/.xmonad/xmonad.hs.  This includes
things like key bindings, colours, layouts, etc.  You may need to have some
basic understanding of [Haskell](http://www.haskell.org/haskellwiki/Haskell)
in order to modify this file, but most people have no problems.

Most of the xmobar configuration is in `~/.xmonad/xmobar.hs`. Whichever
configurations are not in this file, should be in `~/.xmonad/xmonad.hs`, this
currently includes workspace colours and names.

All scripts are in `~/.xmonad/bin/.`
