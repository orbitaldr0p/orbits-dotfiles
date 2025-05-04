from ignis.widgets import Widget
from ignis.app import IgnisApp
from .widgets import (
    NowPlaying
)
app = IgnisApp.get_default()


class RightPanel(Widget.RevealerWindow):
    __gtype_name__ = "rightPanel"

    def __init__(self):
        revealer = Widget.Revealer(
            transition_type="crossfade",
            child=Widget.Box(
                vertical=True,
                css_classes=["rightPanel"],
                child=[
                    Widget.Box(
                        vertical=True,
                        css_classes=["rightPanelWidget"],
                        child=[
                        ],
                    ),
                ],
            ),
            transition_duration=100,
            reveal_child=True,
        )

        super().__init__(
            visible=False,
            popup=True,
            kb_mode="on_demand",
            layer="top",
            css_classes=["rightPanelClose"],
            anchor=["top", "right", "bottom"],
            namespace="rightPanel",
            child=Widget.Box(
                child=[
                    revealer,
                ],
            ),
            revealer=revealer,
        )
