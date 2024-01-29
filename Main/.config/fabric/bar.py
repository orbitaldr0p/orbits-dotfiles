"""desktop status bar example"""
import fabric
import os
import psutil
from loguru import logger
from fabric.widgets.box import Box
from fabric.system_tray import SystemTray
from fabric.widgets.wayland import Window
from fabric.widgets.overlay import Overlay
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
            margin="10px 10px -2px 10px",
            exclusive=True,
            visible=True,
        )
        self.center_box = CenterBox(name="main-window")
        self.workspaces = Workspaces(
            buttons_list=[
                WorkspaceButton(label=FormattedString("")),
                WorkspaceButton(label=FormattedString("")),
                WorkspaceButton(label=FormattedString("")),
                WorkspaceButton(label=FormattedString("")),
                WorkspaceButton(label=FormattedString("")),
            ],
            spacing=2,
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
        self.date_time = DateTime(name="date-time")
        self.system_tray = SystemTray(name="system-tray")
        self.center_box.add_left(self.workspaces)
        self.center_box.add_center(self.active_window)
        self.circular_progress_bar_1 = CircularProgressBar(
            name="circular-progress-bar-1",
            background_color=False,  # false = disabled
            radius_color=False,
            pie=True,
        )
        self.circular_progress_bar_2 = CircularProgressBar(
            name="circular-progress-bar-2",
            background_color=False,
            radius_color=False,
            pie=True,
        )
        self.circular_progress_bars_overlay = Overlay(
            children=self.circular_progress_bar_1,
            overlays=self.circular_progress_bar_2,
        )
        
        self.center_box.add_right(self.system_tray)
        self.center_box.add_right(self.date_time)
        self.add(self.center_box)
        self.show_all()


if __name__ == "__main__":
    StatusBar()
    set_stylesheet_from_file('.config/fabric/bar.css')
    fabric.start()