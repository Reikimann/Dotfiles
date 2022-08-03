# Reikimann's qtile config

####Imports####

from typing import List

import subprocess
import os

from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Match, Screen, DropDown, ScratchPad
from libqtile.lazy import lazy


#### Variables ####

mod = "mod4"
terminal = "kitty"
config_file = "~/.config/qtile/config.py"
gaps = 10

#
#     
#      


#### Defaults ####

layout_defaults = dict(
    border_focus='#bb9af7',
    border_normal='#1a1b26',
    border_width=2, 
    margin=gaps,
    border_on_single = True
    )

widget_defaults = dict(
    font='Liga SFMono Nerd Font',
    fontsize=16,
    padding=3,
    )
extension_defaults = widget_defaults.copy()

widget_text_left = dict (
    text = '',
    padding = 2,
    fontsize = 30
    )

widget_text_right = dict (
    text = '',
    padding = 2,
    fontsize = 30
    )


#widget_text_right = dict (
#    text = '/',
#    padding = 2,
#    fontsize = 30
#    )
#
#widget_text_left = dict (
#    text = '\\',
#    padding = 2,
#    fontsize = 30
#    )

#### Hooks ####

@hook.subscribe.startup_once
def startup_once():
    subprocess.call('/home/reikimann/.config/qtile/autostart.sh')

@hook.subscribe.startup
def startup():
    subprocess.call('/home/reikimann/.config/polybar/launch.sh')

####Keybindings####

keys = [ 
    # Edit config
    Key([mod, "shift"], "e", lazy.spawn("kitty -e nvim /home/reikimann/.config/qtile/config.py"), desc="Edit config file"),

    # Volume -- amixer by alsa-utils
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+ unmute")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%- unmute")),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master toggle")),

    # Brightness
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set 10%+")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),

    # Toggle fullscreen
    Key([mod, "shift"], "c", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),

    # Toggle floating
    Key([mod, "shift"], "b", lazy.window.toggle_floating(), desc="Toggle floating"),

    # Toggle bar
    # Key([mod, "shift"], "b", lazy.hide_show_bar("top"), desc="Toggle bar"),

    # Toggle maximize
    # Key([mod, "shift"], "f", lazy.window.toggle_maximize(), desc="Toggle floating"),

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
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),

    Key([mod], "i", lazy.layout.grow(), desc="Grow window up"),
    Key([mod], "m", lazy.layout.shrink(), desc="Grow window up"),

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
    # Key([mod, "shift"], "r", lazy.spawncmd(),
    #    desc="Spawn a command using a prompt widget"),
]


####Keychords####

#keys = [
#        KeyChord([mod], "s", [
#            Key([], "s", lazy.spawn("")),
#            Key([], "r", lazy.spawn(""))
#        ])
#]


####Groups####

groups = [Group(i) for i in ["1", "2", "3", "4", "5", "6", "7", "8", "9"]]

for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod1 + shift + letter of group = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
    ])


####ScratchPads####

groups.append(ScratchPad("scratchpad", [
    DropDown("term", terminal, width=0.6, height=0.7, x=0.2, y=0.15, opacity=0.8),
    DropDown("browser", "waterfox-g4", width=0.7, height=0.8, x=0.15, y=0.1, opacity=1),
    DropDown("music", "spotify", width=0.7, height=0.8, x=0.15, y=0.1, opacity=1),
    #DropDown("discord", "discord", width=0.7, height=0.8, x=0.15, y=0.1, opacity=1),
    ]))

keys.extend([
    Key([mod, "control"], "1", lazy.group["scratchpad"].dropdown_toggle("term")),
    Key([mod, "control"], "2", lazy.group["scratchpad"].dropdown_toggle("browser")),
    Key([mod, "control"], "3", lazy.group["scratchpad"].dropdown_toggle("music")),
    #Key([mod, "control"], "4", lazy.group["scratchpad"].dropdown_toggle("discord")),
    ])

####Layouts####

# Margin [N E S W]
layouts = [
    layout.Tile(**layout_defaults, ratio=0.55, ratio_increment=0.1),
    layout.MonadTall(**layout_defaults, ratio=0.55, change_ratio=0.1),
    layout.MonadWide(**layout_defaults, ratio=0.50, change_ratio=0.1),
    layout.Columns(**layout_defaults),
    # layout.Floating(border_width = 0),
    # layout.Max(),
]



####Custom Func####


####Mouse Callbacks####




####Widgets####

screens = [
    Screen(),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = False
bring_front_click = True
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="airtame"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        ],
        border_focus='#bb9af7',
        border_normal='#1a1b26',
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
