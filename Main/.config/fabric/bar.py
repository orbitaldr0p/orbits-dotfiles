import math
import os
import subprocess

import fabric
from fabric.audio.service import Audio
from fabric.hyprland.widgets import ActiveWindow, Language, WorkspaceButton, Workspaces
from fabric.system_tray import SystemTray
from fabric.utils.fabricator.fabricator import Fabricate
from fabric.utils.helpers import (
    bulk_replace,
    invoke_repeater,
    monitor_file,
    set_stylesheet_from_file,
)
from fabric.utils.string_formatter import FormattedString
from fabric.widgets.box import Box
from fabric.widgets.centerbox import CenterBox
from fabric.widgets.circular_progress_bar import CircularProgressBar
from fabric.widgets.date_time import DateTime
from fabric.widgets.eventbox import EventBox
from fabric.widgets.label import Label
from fabric.widgets.overlay import Overlay
from fabric.widgets.wayland import Window
from loguru import logger
import psutil

class VolumeWidget(Box):
    def __init__(self, **kwargs):
        super().__init__(**kwargs)
        self.audio = Audio()
        self.audioLabel = ""

        self.circular_progress_bar = CircularProgressBar(
            name="volume-circular-progress-bar",
            background_color=False,  # false = disabled
            radius_color=False,
            pie=False,
            line_width=4
        )

        self.event_box = EventBox(
            events="scroll",
            children=Overlay(
                children=self.circular_progress_bar,
                overlays=Label(
                    label=self.audioLabel,
                    style="margin: 0px 0px 0px 0px; font-size: 12px"
                ),
            ),
        )

        self.event_box.connect("scroll-event", self.on_scroll)
        self.event_box.connect("button-press-event", self.on_click)
        self.audio.connect("speaker-changed", self.update)
        self.add(self.event_box)

    def on_scroll(self, widget, event):
        if event.direction == 0:
            self.audio.speaker.volume += 10
            os.system(f'dunstify "Volume: {math.ceil(self.audio.speaker.volume)}" -t 800 -r 91190')
        elif event.direction == 1:
            self.audio.speaker.volume -= 10
            os.system(f'dunstify "Volume: {math.ceil(self.audio.speaker.volume)}" -t 800 -r 91190')

    def on_click(self, widget, event):
        if event.button == 1:
            os.system('pavucontrol')
            
    def update(self, *args):
        if self.audio.speaker is None:
            return
        self.circular_progress_bar.percentage = self.audio.speaker.volume
        return

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
        self.cpu_freq_label = Label(label="0")
        self.memory_label = Label(label="0")
        self.battery_label = Label(label="0")
        self.system_info_var = Fabricate(
            value={"ram": 0, "cpu": 0},
            poll_from=lambda _: {
                "ram": str(int(psutil.virtual_memory().percent)),
                "cpu": str(int(psutil.cpu_percent())),
                "cpu-freq": str(round(float(str(psutil.cpu_freq()).split("current=")[1].split(",")[0]) / 1000, 2)),
                "battery": str(int(psutil.sensors_battery().percent) if psutil.sensors_battery() is not None else 42),
            },
            interval=1000,
        )
        self.system_info_var.connect(
            "changed",
            lambda _, value: (
                self.cpu_label.set_label(value["cpu"]),
                self.memory_label.set_label(value["ram"]),
                self.battery_label.set_label(value["battery"]),
                self.cpu_freq_label.set_label(value["cpu-freq"]),
            ),
        )

        self.volume = VolumeWidget()

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
                            self.cpu_freq_label,
                            Label(label="GHz")
                        ],
                    ),
                ],
            )
        )

        #Center Widgets
        self.center_box.add_center(self.active_window)
        
        #Right Widgets
        self.center_box.add_right(
            Box(
                orientation="h",
                style="min-width: calc(44px - 8px); margin: 8px;",
                children=[
                    Box(
                        spacing=4,
                        orientation="h",
                        children=[
                            self.system_tray
                        ],
                    ),
                    Box(name="module-separator"),
                    Box(
                        spacing=4,
                        orientation="h",
                        children=[
                            self.volume
                        ],
                    ),
                    Box(name="module-separator"),
                    Box(
                        spacing=4,
                        orientation="h",
                        children=[
                            self.date_time
                        ],
                    ),
                ],
            )
        )
        
        self.add(self.center_box)
        self.show_all()


if __name__ == "__main__":
    StatusBar()
    set_stylesheet_from_file('.config/fabric/bar.css')
    fabric.start()