# Reikimann's qtile config

####Imports####

from typing import List  # noqa: F401

import subprocess
import os

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen 
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal


#### Variables ####


mod = "mod4"
terminal = "kitty"
browser = "brave"
file_manager = "nautilus"
music = "spotify"
wallpaper = "feh --randomize --bg-fill '/home/cbirkmand/Pictures/Wallpapers'"
config_file = "/home/cbirkmand/.config/qtile/config.py"

# home_dir = os.getenv('HOME')

#### Defaults ####

layout_defaults = dict(
    border_focus='#bd93f9',
    border_normal='#21222c',
    border_width=2, 
    margin=10,
    border_on_single = True
    )

widget_defaults = dict(
    font='Liga SFMono Nerd Font',
    fontsize=16,
    padding=3,
    )
extension_defaults = widget_defaults.copy()

widget_text_right = dict (
    text = '/',
    padding = 2,
    fontsize = 30
    )

widget_text_left = dict (
    text = '\\',
    padding = 2,
    fontsize = 30
    )

#### Hooks ####

@hook.subscribe.startup_once
def startup():
    subprocess.call('/home/cbirkmand/.config/qtile/autostart.sh')


####Keybindings####

keys = [
    # Browser
    Key([mod], "b", lazy.spawn(browser), desc="Launch browser"),

    # Edit config
    Key([mod], "e", lazy.spawn("kitty -e nvim /home/cbirkmand/.config/qtile/config.py"), desc="Edit config file"),


    # Terminal
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),

    # Wallpaper
    Key([mod], "g", lazy.spawn(wallpaper)),

    # Screenshot
    Key([], "Print", lazy.spawn("gnome-screenshot")),

    # File Manager
    Key([mod], "f", lazy.spawn(file_manager)),

    # Music
    Key([mod], "m", lazy.spawn(music)),

    # Volume
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer -D pulse sset Master 5%+ unmute")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer -D pulse sset Master 5%- unmute")),
    Key([], "XF86AudioMute", lazy.spawn("amixer -D pulse sset Master toggle")),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 10%+")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),


    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(),
        desc="Move window focus to other window"),

    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(),
        desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(),
        desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(),
        desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack"),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),
]



####Groups####


groups = [Group(i) for i in ["1", "2", "3", "4", "5", "6", "7", "8", "9"]]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen(),
            desc="Switch to group {}".format(i.name)),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name, switch_group=True),
            desc="Switch to & move focused window to group {}".format(i.name)),
        # Or, use below if you prefer not to switch to that group.
        # # mod1 + shift + letter of group = move focused window to group
        # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
        #     desc="move focused window to group {}".format(i.name)),
    ])



####Layouts####


# Margin [N E S W]
layouts = [
    layout.Tile(**layout_defaults, ratio = 0.55),
    layout.MonadTall(**layout_defaults, ratio = 0.55),
    layout.Floating(border_width = 0),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    layout.MonadWide(**layout_defaults, ratio = 0.50),
    layout.Columns(**layout_defaults),
    # layout.RatioTile(),
    # layout.TreeTab(),
    # layout.VerticalTile(),
    # layout.Zoomy(),
]





####Custom Func####


####Mouse Callbacks####




####Widgets####

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Image(
                    filename="~/Pictures/Logo/python-white.png",
                    margin=2
                    ),
                widget.TextBox(**widget_text_left),
                widget.GroupBox(
                    disable_drag=True,
                    spacing=10,
                    rounded=True,
                    hide_unused=False,
                    highlight_method='block',
                    this_current_screen_border='#bd93f9',
                    active='#ffffff'
                    ),
                widget.TextBox(**widget_text_left),
                widget.Prompt(
                    bell_style = ''
                    ),
                widget.WindowName(
                    max_chars=20
                    ),
                widget.Clock(format='%A, %B %d - %H:%M '),
                widget.Spacer(540),
                widget.WidgetBox(widgets=[
                    # widget.TextBox(**widget_text_right),
                    widget.Wlan(
                        format = '{essid} {percent:1.0%}  '
                        ),
                    widget.TextBox(**widget_text_right),
                    widget.Net(
                        format = '{down} ↓↑{up}'
                        ),
                    widget.TextBox(**widget_text_right),
                    widget.CheckUpdates(
                       update_interval = 1800,
                       display_format = '{updates} : ﮮ',
                       distro = "Arch_checkupdates",
                       mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(terminal + ' -e sudo pacman -Syu')},
                       padding = 5
                        ),
                    ],
                    close_button_location = 'right',
                    text_closed = '<=',
                    text_open = '>='
                    ),
                widget.TextBox(**widget_text_right),
                widget.CurrentLayoutIcon(
                    scale=0.75
                    ),
                widget.TextBox(**widget_text_right),
                widget.Systray(),
                # widget.TextBox(**widget_text_right),
                widget.PulseVolume(
                        fmt = '  {}'
                        ),
                widget.TextBox(**widget_text_right),
                widget.Battery(format=' {percent: 1.0%} ')
            ],
            24,
            # Margin [N E S W]
            # border_width=[2, 2, 2, 2],
            margin=[10, 10, 0, 10], # Space around bar {8}
            opacity = 1,
            background='#282a36',
            border_color='#282a36'
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    *layout.Floating.default_float_rules,
    Match(wm_class='confirmreset'),  # gitk
    Match(wm_class='makebranch'),  # gitk
    Match(wm_class='maketag'),  # gitk
    Match(wm_class='ssh-askpass'),  # ssh-askpass
    Match(title='branchdialog'),  # gitk
    Match(title='pinentry'),  # GPG key password entry
    ],
    border_focus='#bd93f9',
    border_normal='#21222c',
    border_width=2, 
    border_on_single = True
)


auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
