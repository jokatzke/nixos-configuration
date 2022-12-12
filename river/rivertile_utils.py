import os
from typing import Literal


def start(
    view_padding: int = 6,
    outer_padding: int = 6,
    main_location: Literal["top", "bottom", "left", "right"] = "left",
    main_count: int = 1,
    main_ratio: float = 0.6,
):
    kwargs = {
        "view-padding": view_padding,
        "outer-padding": outer_padding,
        "main-location": main_location,
        "main-count": main_count,
        "main-ratio": main_ratio,
    }
    rivertile_command = "rivertile"
    for key, value in kwargs.items():
        rivertile_command += f" -{key} {value}"

    os.system(f"{rivertile_command} &")
