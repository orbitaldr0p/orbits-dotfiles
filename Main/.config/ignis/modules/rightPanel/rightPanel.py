from ignis.widgets import Widget
from ignis.app import IgnisApp

app = IgnisApp.get_default()


class rightPanel(Widget.RevealerWindow):
    __gtype_name__ = "rightPanel"

    def __init__(self):
        revealer = Widget.Revealer(
            transition_type="slide_left",
            child=Widget.Box(
                vertical=True,
                css_classes=["control-center"],
                child=[
                    Widget.Box(
                        vertical=True,
                        css_classes=["control-center-widget"],
                        child=[
                            Widget.Label(
                                label="This window created using a custom class!"
                            ),
                        ],
                    ),
                ],
            ),
            transition_duration=300,
            reveal_child=True,
        )

        super().__init__(
            visible=False,
            popup=True,
            kb_mode="on_demand",
            layer="top",
            css_classes=["unset"],
            anchor=["top", "right", "bottom", "left"],
            namespace="rightPanel",
            child=Widget.Box(
                child=[
                    Widget.Button(
                        vexpand=True,
                        hexpand=True,
                        css_classes=["unset"],
                        on_click=lambda x: app.close_window("rightPanel"),
                    ),
                    revealer,
                ],
            ),
            revealer=revealer,
        )
