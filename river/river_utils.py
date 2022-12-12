import os
from typing import Collection, Literal, Optional


def map(
    modifiers: Collection[str],
    key: str,
    command: str,
    mode: str = "normal",
    release: bool = False,
    repeat: bool = False,
):
    """
    Run command when key is pressed while modifiers are held down and in the specified mode.

    •   release: if True, activate on key release instead of key press
    •   repeat: if True, activate repeatedly until key release; may not be used with -re‐
        lease
    •   mode: name of the mode for which to create the mapping
    •   modifiers: one or more of the modifiers listed above, separated by a plus sign (+).
    •   key: an XKB keysym name as described above
    •   command: any command that may be run with riverctl
    """
    modifier_string = "+".join(modifiers)
    riverctl_command = f"riverctl map {mode} {modifier_string} {key} {command}"
    if release:
        riverctl_command += " -release"
    if repeat:
        riverctl_command += " -repeat"

    print(riverctl_command)
    os.system(riverctl_command)


def map_pointer(
    modifiers: Collection[str],
    button: str,
    action: Literal["move-view", "resize-view", "toggle-float"],
    mode: str = "normal",
):
    """
    Move or resize views when button and modifiers are held down while in the specified mode.

    •   mode: name of the mode for which to create the mapping
    •   modifiers: one or more of the modifiers listed above, separated by a plus sign (+).
    •   button: the name of a linux input event code as described above
    •   action: one of the following values:
        •   move-view
        •   resize-view
    """
    modifier_string = "+".join(modifiers)

    os.system(f"riverctl map-pointer {mode} {modifier_string} {button} {action}")


def declare_mode(name: str):
    """Create a new mode called name."""
    os.system(f"riverctl declare-mode {name}")


def set_repeat(rate: int, delay: int):
    """
    Set the keyboard repeat rate to rate key repeats per second and re‐
    peat delay to delay milliseconds.
    """
    os.system(f"riverctl set-repeat {rate} {delay}")


def color(
    object: Literal["background", "border"],
    color: "str",
    suffix: Optional[Literal["focused", "unfocused", "urgent"]] = None,
):
    """
    Set the color of an object, according to hexa RGB or RGBA.

    If relevant, can also add a suffix, e.g. to color the border of a focused window.
    """
    riverctl_command = f"riverctl {object}-color"
    if suffix:
        if object == "border":
            riverctl_command += f"-{suffix}"
        else:
            raise ValueError(
                f"There exists no suffix for the given object {object} to color!"
            )
    riverctl_command += f" {color}"

    os.system(riverctl_command)


def add_filter(
    filter_type: Literal["csd", "float"],
    identifier_type: Literal["app-id", "title"],
    identifier: str,
):
    """
    Add a filter to, e.g. to make some windows floating dy default.

    filter_type values:
    - csd :: use client side decoration instead of the server side derocation
    - float :: do not tile the window
    """
    os.system(f'riverctl {filter_type}-filter-add {identifier_type} "{identifier}"')


def set_default_layout(namespace: str):
    """Set the layout namespace to be used by all outputs by default."""
    os.system(f"riverctl default-layout {namespace}")


def set_current_layout(namespace: str):
    """Set the layout namespace of currently focused output, overriding the value set with default-layout if any."""
    os.system(f"riverctl output-layout {namespace}")
