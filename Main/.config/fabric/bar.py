"""desktop status bar example"""
import fabric
import os
import psutil
from loguru import logger
from fabric.widgets.box import Box
from fabric.system_tray import SystemTray
from fabric.widgets.wayland import Window
from fabric.widgets.label import Label
from fabric.widgets.overlay import Overlay
from fabric.utils.fabricator.fabricator import Fabricate
from fabric.widgets.date_time import DateTime
from fabric.widgets.centerbox import CenterBox
from fabric.utils.string_formatter import FormattedString
from fabric.widgets.circular_progress_bar import CircularProgressBar
from fabric.hyprland.widgets import WorkspaceButton, Workspaces, ActiveWindow, Language
from fabric.utils.helpers import (
    set_stylesheet_from_file,
    bulk_replace,
    monitor_file,
    invoke_repeater,
)

class StatusBar(Window):
    def __init__(
        self,
    ):
        super().__init__(
            layer="top",
            anchor="left top right",
            margin="7px 7px 0px 7px",
            exclusive=True,
            visible=True,
        )
        self.center_box = CenterBox(name="main-window")
        self.workspaces = Workspaces(
            buttons_list=[
                WorkspaceButton(label=FormattedString("1")),
                WorkspaceButton(label=FormattedString("2")),
                WorkspaceButton(label=FormattedString("3")),
                WorkspaceButton(label=FormattedString("4")),
                WorkspaceButton(label=FormattedString("5")),
            ],
            spacing=6,
            name="workspaces",
        )
        self.active_window = ActiveWindow(
            formatter=FormattedString(
                "{test_title(win_class)}",
                test_title=lambda x, max_length=20: "Desktop"
                if len(x) == 0
                else x
                if len(x) <= max_length
                else x[: max_length - 3] + "...",
            ),
            name="hyprland-window",
        )

        self.cpu_label = Label(label="0")
        self.memory_label = Label(label="0")
        self.battery_label = Label(label="0")
        self.system_info_var = Fabricate(
            value={"ram": 0, "cpu": 0},
            poll_from=lambda _: {
                "ram": str(int(psutil.virtual_memory().percent)),
                "cpu": str(int(psutil.cpu_percent())),
                "battery": str(
                    int(
                        psutil.sensors_battery().percent
                        if psutil.sensors_battery() is not None
                        else 42
                    )
                ),
            },
            interval=1000,
        )
        self.system_info_var.connect(
            "changed",
            lambda _, value: (
                self.cpu_label.set_label(value["cpu"]),
                self.memory_label.set_label(value["ram"]),
                self.battery_label.set_label(value["battery"]),
            ),
        )

        #Left Widgets
        self.date_time = DateTime(name="date-time")
        self.system_tray = SystemTray(name="system-tray")
        self.center_box.add_left(self.workspaces)
        self.center_box.add_left(
            Box(
                orientation="h",
                style="min-width: calc(44px - 8px); margin: 8px;",
                children=[
                    Box(
                        spacing=4,
                        orientation="h",
                        children=[
                            Label(label=""),
                            self.battery_label,
                            Label(label="%"),
                        ],
                    ),
                    Box(name="module-separator"),
                    Box(
                        spacing=4,
                        orientation="h",
                        children=[
                            Label(label=""),
                            self.memory_label,
                            Label(label="%"),
                        ],
                    ),
                    Box(name="module-separator"),
                    Box(
                        spacing=4,
                        orientation="h",
                        children=[
                            Label(label=""),
                            self.cpu_label,
                            Label(label="%"),
                        ],
                    ),
                ],
            )
        )

        #Center Widgets
        self.center_box.add_center(self.active_window)
        
        #Right Widgets
        self.center_box.add_right(self.system_tray)
        self.center_box.add_right(self.date_time)
        self.add(self.center_box)
        self.show_all()


if __name__ == "__main__":
    StatusBar()
    set_stylesheet_from_file('.config/fabric/bar.css')
    fabric.start()