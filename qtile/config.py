import os
import re
import socket
import subprocess
from libqtile import qtile
from libqtile.config import Click, Drag, Group, KeyChord, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy
from libqtile import layout, bar, widget, hook
from typing import List  # noqa: F401from typing import List  # noqa: F401

mod = "mod4"               # Sets mod key to SUPER/WINDOWS
my_term = "alacritty"      # My terminal of choice
my_browser = "firefox"     # My browser of choice
home = os.path.expanduser('~')

layouts = []

default_layout_theme = {
    "border_width": 2,
    "border_focus": "e1acff",
    "border_normal": "1D2330",
}
default_margin = 15

layouts.extend(
    [
        layout.MonadTall(margin=default_margin, **default_layout_theme),
        layout.MonadWide(margin=default_margin, **default_layout_theme),
    ]
)

layouts.append(
    layout.MonadThreeCol(
        new_client_position="below_current", ratio=0.4, margin=default_margin, **default_layout_theme
    )
)

layouts.append(layout.RatioTile(fancy=True, margin=default_margin // 2, **default_layout_theme))

left_keys = ["period", "p", "y", "e", "u", "i"]
right_keys = ["g", "c", "r", "t", "n"]
group_keys = left_keys + right_keys
groups = [
    # left groups
    Group(
        name=group_keys[0],
        label=",",
        layout="ratiotile",
        matches=[
            Match(wm_class=["Telegram", "Slack", "Mattermost", "Signal", "Element"]),
        ],
    ),
    Group(name=group_keys[1], label="P", layout="monadthreecol"),
    Group(name=group_keys[2], label="Y", layout="monadthreecol"),
    Group(name=group_keys[3], label="E", layout="monadthreecol"),
    Group(name=group_keys[4], label="U", layout="monadthreecol"),
    Group(name=group_keys[5], label="I", layout="monadthreecol"),
    # right groups
    Group(name=group_keys[6], label="G", layout="monadtall"),
    Group(name=group_keys[7], label="C", layout="monadtall"),
    Group(
        name=group_keys[8],
        label="R",
        matches=[Match(wm_class=["thunderbird"])],
    ),
    Group(name=group_keys[9], label="T", layout="monadtall"),
    Group(name=group_keys[10], label="N", layout="monadtall"),
]

dropdown_width = 0.4
dropdown_height = 0.65
dropdown_defaults = {
    "opacity": 0.8,
    "height": dropdown_height,
    "width": dropdown_width,
    "x": (1 - dropdown_width) / 2,
    "y": (1 - dropdown_height) / 2,
    "on_focus_lost_hide": True,
}

dropdowns = {
    "terminal": DropDown("terminal dropdown", cmd=my_term, **dropdown_defaults),
    "calculator": DropDown(
        "calculator dropdown",
        cmd=f"{my_term} -e emacsclient -cte '(full-calc)'",
        **dropdown_defaults,
    ),
    "gtd": DropDown(
        "gtd main dropdown", cmd=f"{my_term} -e emacsclient -ct ~/gtd/gtd.org", **dropdown_defaults
    ),
    "gtd inbox": DropDown(
        "gtd inbox dropdown", cmd=f"{my_term} -e emacsclient -ct ~/gtd/inbox.org", **dropdown_defaults
    ),
    "gtd someday": DropDown(
        "gtd someday dropdown",
        cmd=f"{my_term} -e emacsclient -ct ~/gtd/someday.org",
        **dropdown_defaults,
    ),
    "mail": DropDown(
        "mail dropdown", cmd=f"{my_term} -e emacsclient -cte '(mu4e)'", **dropdown_defaults
    ),
}

scratchpad = ScratchPad(name="scratchpad", dropdowns=list(dropdowns.values()))
groups.append(scratchpad)

keys = []

keys.extend([
    ### The essentials
    Key([mod], "Tab",
        lazy.next_layout(),
        desc='Toggle through layouts'
        ),
    Key([mod], "x",
        lazy.window.kill(),
        desc='Kill active window'
        ),
    Key([mod, "shift", "control"], "r",
        lazy.restart(),
        desc='Restart Qtile'
        ),
    Key([mod, "shift"], "Escape",
        lazy.shutdown(),
        desc='Shutdown Qtile'
        ),
    Key([mod], "Escape",
        lazy.spawn(f"rofi -show powermenu -modi powermenu:{home}/.config/scripts/rofi/rofi-power-menu.sh"),
        desc="Rofi Power-Menu",
        )
])

for monitor, group_keys in enumerate([left_keys, right_keys]):
   for key in group_keys:
      keys.extend(
         [
            # move to group
               Key(
                  [mod], key,
                  lazy.to_screen(monitor),
                  lazy.group[key].toscreen(),
                  desc="Move to group",
               ),
            # move to group with current window
               Key(
                  [mod, "shift"], key,
                  lazy.window.togroup(key),
                  lazy.to_screen(monitor),
                  lazy.group[key].toscreen(),
                  desc="Move to group with current window",
               ),
            # move only current window
               Key(
                  [mod, "control"], key,
                  lazy.window.togroup(key),
                  desc=f"Move window to group {key}",
               ),
         ]
      )

keys.extend(
    [
        Key(
            [mod, "mod1"],
            "Return",
            lazy.group["scratchpad"].dropdown_toggle(dropdowns["terminal"].name),
        ),
        Key(
            [mod, "mod1"],
            "c",
            lazy.group["scratchpad"].dropdown_toggle(dropdowns["calculator"].name),
        ),
        Key(
            [mod, "mod1"],
            "i",
            lazy.group["scratchpad"].dropdown_toggle(dropdowns["gtd inbox"].name),
        ),
        Key(
            [mod, "mod1"],
            "g",
            lazy.group["scratchpad"].dropdown_toggle(dropdowns["gtd"].name),
        ),
        Key(
            [mod, "mod1"],
            "m",
            lazy.group["scratchpad"].dropdown_toggle(dropdowns["mail"].name),
        ),
    ]
)

vim_down = "j"
vim_up = "k"
vim_left = "h"
vim_right = "l"
keys.extend(
    [
        Key([mod], vim_down, lazy.layout.down(), desc="Move focus down"),
        Key([mod], vim_up, lazy.layout.up(), desc="Move focus up"),
        Key(
            [mod, "shift"],
            vim_down,
            lazy.layout.shuffle_down(),
            lazy.layout.section_down(),
            desc="Move windows down in current stack",
        ),
        Key(
            [mod, "shift"],
            vim_up,
            lazy.layout.shuffle_up(),
            lazy.layout.section_up(),
            desc="Move windows up in current stack",
        ),
        Key(
            [mod],
            vim_left,
            lazy.layout.grow_right(),
            lazy.layout.grow(),
            lazy.layout.increase_ratio(),
            lazy.layout.delete(),
            desc="Resize left",
        ),
        Key(
            [mod],
            vim_right,
            lazy.layout.grow_left(),
            lazy.layout.shrink(),
            lazy.layout.decrease_ratio(),
            lazy.layout.add(),
            desc="Resize right",
        ),
        Key(
            [mod, "shift"],
            "asterisk",
            lazy.layout.normalize(),
            desc="normalize window size ratios",
        ),
        Key([mod, "shift"], "f", lazy.window.toggle_floating(), desc="toggle floating"),
        Key([mod], "m", lazy.window.toggle_fullscreen(), desc="toggle fullscreen"),
        Key(
            [mod, "shift"],
            "Tab",
            lazy.layout.rotate(),
            lazy.layout.flip(),
            desc="Switch which side main pane occupies (XmonadTall)",
        ),
        Key(
            [mod],
            "space",
            lazy.layout.next(),
            desc="Switch window focus to other pane(s) of stack",
        ),
        Key(
            [mod, "shift"],
            "space",
            lazy.layout.previous(),
            desc="Switch window focus to other pane(s) of stack",
        ),
    ]
)

keys.extend(
    [
        Key([], "Print",
            lazy.spawn("spectacle -i"),
            desc="Screenshot"),
        Key([mod], "v",
            lazy.spawn("pavucontrol"),
            desc="PulseAudio-Control"),
        Key([mod], "Return",
            lazy.spawn(my_term),
            desc="Terminal"),
        Key([mod], "a",
            lazy.spawn("emacsclient -c -a 'emacs'"),
            desc="Launch Emacs"),
        Key([mod], "b",
            lazy.spawn(my_browser),
            desc="Internet Browser"),
        Key([mod], "f",
            lazy.spawn("emacsclient -c -a 'emacs' --eval '(+default/dired nil)'"),
            desc="File-Manager"),
        Key(["control", "shift"], "Escape",
            lazy.spawn("plasma-systemmonitor"),
            desc="System Monitor"),
        Key([mod], "semicolon",
            lazy.spawn("emacsclient --eval '(emacs-everywhere)'"),
            desc="Write in Emacs instead"),
        Key([mod, "shift"], "b",
            lazy.spawn(
                f"{my_term} -e '{home}/.config/scripts/add-to-bib.fish'"
            ),
            desc="Bibliography Utility"),

        # rofi utilities
        Key([mod], "d",
            lazy.spawn("rofi -show combi -show-icons"),
            desc="d-Menu"),
        Key([mod], "o",
            lazy.spawn(f"fish {home}/.config/scripts/rofi/rofi-edit.fish"),
            desc="Open Config Files"),
        Key([mod, "shift"], "a",
            lazy.spawn(
                f"bash {home}/.config/scripts/rofi/rofi-add-transaction.sh"
            ),
            desc="Ledger Utility"),
        Key([mod], "z",
            lazy.spawn(
                f"fish {home}/.config/scripts/rofi/rofi-gtd.fish"
            ),
            desc="GTD Utility"),

        # cycle through autorandr profiles
        Key([mod, "shift"], "grave",
            lazy.spawn(f"fish {home}/.config/scripts/qtile/autorandr_cycle.fish"),
            desc='Cycle through autorandr profiles'
            ),
    ]
)

keys.extend([
    Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([], "XF86AudioNext", lazy.spawn("playerctl next")),
    Key([], "XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -ui 5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -ud 5")),
    Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute")),
])

keys.extend([
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
])

colors = {
    "background":          ["#242730", "#242730"], # panel background
    "active_background":   ["#3d3f4b", "#434758"], # background for current screen tab
    "active_foreground":   ["#ffffff", "#ffffff"], # font color for group names
    "active_accent":       ["#ff5555", "#ff5555"], # border line color for current tab
    "accent_1":            ["#74438f", "#74438f"], # border line color for 'other tabs' and color for 'odd widgets'
    "accent_2":            ["#4f76c7", "#4f76c7"], # color for the 'even widgets'
    "window_foreground":   ["#e1acff", "#e1acff"], # window name
    "inactive_foreground": ["#ecbbfb", "#ecbbfb"]} # backbround for inactive screens

prompt = "{0}@{1}: ".format(os.environ["USER"], socket.gethostname())

widget_defaults = dict(
    font="UbuntuMono Nerd Font",
    fontsize = 12,
    padding = 2,
    background=colors["active_foreground"]
)
extension_defaults = widget_defaults.copy()

class alternating_colors():
    count = 0
    color_options = [colors["accent_1"], colors["accent_2"]]

    def get(self):
        self.count += 1
        return self.color_options[self.count % len(self.color_options)]

def init_widgets(show_systray=True):
    widgets = [
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors["active_foreground"],
            background = colors["background"]
        ),
        widget.Image(
            filename = "~/.config/qtile/icons/python-white.png",
            scale = "False",
            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(my_term)}
        ),
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors["active_foreground"],
            background = colors["background"]
        ),
        widget.GroupBox(
            font = "Ubuntu, Bold",
            fontsize = 9,
            margin_y = 3,
            margin_x = 0,
            padding_y = 5,
            padding_x = 3,
            borderwidth = 3,
            active = colors["active_foreground"],
            inactive = colors["inactive_foreground"],
            rounded = False,
            highlight_color = colors["active_background"],
            highlight_method = "line",
            this_current_screen_border = colors["window_foreground"],
            this_screen_border = colors["accent_1"],
            other_current_screen_border = colors["window_foreground"],
            other_screen_border = colors["accent_2"],
            foreground = colors["active_foreground"],
            background = colors["background"],
            visible_groups = left_keys,
        ),
        widget.Sep(
            linewidth = 1,
            padding = 5,
            foreground = colors["inactive_foreground"],
            background = colors["background"]
        ),
        widget.GroupBox(
            font = "Ubuntu, Bold",
            fontsize = 9,
            margin_y = 3,
            margin_x = 0,
            padding_y = 5,
            padding_x = 3,
            borderwidth = 3,
            active = colors["active_foreground"],
            inactive = colors["inactive_foreground"],
            rounded = False,
            highlight_color = colors["active_background"],
            highlight_method = "line",
            this_current_screen_border = colors["window_foreground"],
            this_screen_border = colors["accent_1"],
            other_current_screen_border = colors["window_foreground"],
            other_screen_border = colors["accent_2"],
            foreground = colors["active_foreground"],
            background = colors["background"],
            visible_groups = right_keys,
        ),
        widget.Prompt(
            prompt = prompt,
            font = "UbuntuMono Nerd Font",
            padding = 10,
            foreground = colors["active_accent"],
            background = colors["active_background"]
        ),
        widget.Sep(
            linewidth = 0,
            padding = 20,
            foreground = colors["active_foreground"],
            background = colors["background"]
        ),
        widget.WindowName(
            foreground = colors["window_foreground"],
            background = colors["background"],
            padding = 0
        ),
        widget.Systray(
            background = colors["background"],
            padding = 5
        ) if show_systray else None,
        widget.Sep(
            linewidth = 0,
            padding = 6,
            foreground = colors["background"],
            background = colors["background"]
        ) if show_systray else None,
    ]

    # powerline: network
    col_gen = alternating_colors()
    old_bg_color = colors["background"]
    bg_color = col_gen.get()
    widgets.extend([
        widget.TextBox(
            text='',
            font = "UbuntuMono Nerd Font",
            background = old_bg_color,
            foreground = bg_color,
            padding = -4,
            fontsize = 37,
        ),
        widget.Net(
            interface = "enp3s0",
            format = '{down} ↓↑ {up}',
            foreground = colors["active_foreground"],
            background = bg_color,
            padding = 5
        ),
    ])

    # powerline: updates
    # old_bg_color = bg_color
    # bg_color = col_gen.get()
    # widgets.extend([
    #     widget.TextBox(
    #         text='',
    #         font = "UbuntuMono Nerd Font",
    #         background = old_bg_color,
    #         foreground = bg_color,
    #         padding = 0,
    #         fontsize = 37,
    #     ),
    #     widget.TextBox(
    #         text = " ⟳",
    #         padding = 2,
    #         foreground = colors["active_foreground"],
    #         background = bg_color,
    #         fontsize = 14
    #     ),
    #     widget.CheckUpdates(
    #         update_interval = 1800,
    #         distro = "Arch_checkupdates",
    #         display_format = "Updates: {updates} ",
    #         foreground = colors["active_foreground"],
    #         colour_have_updates = colors["active_foreground"],
    #         colour_no_updates = colors["active_foreground"],
    #         mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(my_term + ' -e yay -Syu')},
    #         padding = 5,
    #         background = bg_color
    #     ),
    # ])

    # powerline: cpu
    old_bg_color, bg_color = bg_color, col_gen.get()
    widgets.extend([
        widget.TextBox(
            text='',
            font = "UbuntuMono Nerd Font",
            background = old_bg_color,
            foreground = bg_color,
            padding = -4,
            fontsize = 37,
        ),
        widget.CPU(
            foreground = colors["active_foreground"],
            background = bg_color,
            format = 'CPU: {load_percent:4.1f}%',
            padding = 5
        ),
        widget.TextBox(
            text='|',
            font = "UbuntuMono Nerd Font",
            foreground = colors["active_foreground"],
            background = bg_color,
            padding = -4,
            fontsize = 30,
        ),
        widget.ThermalSensor(
            tag_sensor = "Package id 0",
            foreground = colors["active_foreground"],
            background = bg_color,
            threshold = 90,
            padding = 5
        ),
    ])

    # powerline: GPU
    # old_bg_color = bg_color
    # bg_color = col_gen.get()
    # widgets.extend([
    #     widget.TextBox(
    #         text='',
    #         font = "UbuntuMono Nerd Font",
    #         background = old_bg_color,
    #         foreground = bg_color,
    #         padding = -4,
    #         fontsize = 37,
    #     ),
    #     widget.NvidiaSensors(
    #         foreground = colors["active_foreground"],
    #         background = bg_color,
    #         format = 'GPU: {temp}°C',
    #         padding = 5
    #     ),
    # ])


    # powerline: memory
    old_bg_color, bg_color = bg_color, col_gen.get()
    widgets.extend([
        widget.TextBox(
            text='',
            font = "UbuntuMono Nerd Font",
            background = old_bg_color,
            foreground = bg_color,
            padding = -4,
            fontsize = 37,
        ),
        widget.TextBox(
            text = " ",
            foreground = colors["active_foreground"],
            background = bg_color,
            padding = 5,
            fontsize = 13
        ),
        widget.Memory(
            foreground = colors["active_foreground"],
            background = bg_color,
            format = '{MemUsed: 3.0f}{mm} /{MemTotal: 3.0f}{mm}',
            mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn(my_term + ' -e htop')},
            padding = 7
        ),
    ])

    # powerline: volume
    old_bg_color = bg_color
    bg_color = col_gen.get()
    widgets.extend([
        widget.TextBox(
            text='',
            font = "UbuntuMono Nerd Font",
            background = old_bg_color,
            foreground = bg_color,
            padding = -4,
            fontsize = 37,
        ),
        widget.TextBox(
            text = " Vol:",
            foreground = colors["active_foreground"],
            background = bg_color,
            padding = 0
        ),
        widget.Volume(
            foreground = colors["active_foreground"],
            background = bg_color,
            padding = 5
        ),
    ])

    # powerline: current layout
    old_bg_color = bg_color
    bg_color = col_gen.get()
    widgets.extend([
        widget.TextBox(
            text='',
            font = "UbuntuMono Nerd Font",
            background = old_bg_color,
            foreground = bg_color,
            padding = -4,
            fontsize = 37,
        ),
        widget.CurrentLayoutIcon(
            custom_icon_paths = [os.path.expanduser("~/.config/qtile/icons")],
            foreground = colors["background"],
            background = bg_color,
            padding = 0,
            scale = 0.7
        ),
        widget.CurrentLayout(
            foreground = colors["active_foreground"],
            background = bg_color,
            padding = 5
        ),
    ])

    # powerline: current date / time
    old_bg_color = bg_color
    bg_color = col_gen.get()
    widgets.extend([
        widget.TextBox(
            text='',
            font = "UbuntuMono Nerd Font",
            background = old_bg_color,
            foreground = bg_color,
            padding = -4,
            fontsize = 37,
        ),
        widget.Clock(
            foreground = colors["active_foreground"],
            background = bg_color,
            format = "%A, %B %d - %H:%M "
        ),
    ])


    return list(filter(None, widgets))

def init_widgets_screen1():
    widgets_screen1 = init_widgets(show_systray=False)
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets(show_systray=True)
    return widgets_screen2

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=0.8, size=20)),
        Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=0.8, size=20))]

if __name__ in {"config", "__main__"}:
    screens = init_screens()
    # widgets = init_widgets()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_app_rules = []
follow_mouse_focus = False
bring_front_click = False
cursor_warp = True

floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        # default_float_rules include: utility, notification, toolbar, splash, dialog,
        # file_progress, confirm, download and error.
        *layout.Floating.default_float_rules,
        Match(title="Confirmation"),        # tastyworks exit box
        Match(title="Qalculate!"),          # qalculate-gtk
        Match(wm_class="kdenlive"),         # kdenlive
        Match(wm_class="pinentry-gtk-2"),   # GPG key password entry
        Match(wm_class="librewolf"),
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = False

@hook.subscribe.startup_once
def start_once():
    if qtile.core.name == "x11":
        subprocess.call([home + '/.config/qtile/autostart_x11.sh'])
    elif qtile.core.name == "wayland":
        subprocess.call([home + '/.config/qtile/autostart_wayland.sh'])

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
