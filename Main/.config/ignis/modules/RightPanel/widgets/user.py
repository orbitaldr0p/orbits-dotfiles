import os
import subprocess
from ignis.widgets import Widget
from ignis.utils import Utils
from ignis.app import IgnisApp
from ignis.services.fetch import FetchService

fetchService = FetchService.get_default()
ignisApp = IgnisApp.get_default()


def formatUptime(value: tuple[int, int, int, int]) -> str:
    days, hours, minutes, seconds = value
    if days:
        return f"Uptime: {days:02}:{hours:02}:{minutes:02}"
    else:
        return f"Uptime: {hours:02}:{minutes:02}"


class User(Widget.Box):
    def __init__(self):
        imagePath = os.path.join(os.path.dirname(__file__), "avatar.png")

        userImage = Widget.Picture(
            image=imagePath,
            width=44,
            height=44,
            content_fit="cover",
            style="border-radius: 10rem;",
        )

        userName = Widget.Box(
            child=[
                Widget.Label(
                    label=os.getenv("USER") or "User",
                    css_classes=["userName"],
                    halign="start",
                ),
                Widget.Label(
                    label=Utils.Poll(
                        timeout=60 * 1000, callback=lambda x: fetchService.uptime
                    ).bind("output", lambda value: formatUptime(value)),
                    halign="start",
                    css_classes=["userNameSecondary"],
                ),
            ],
            vertical=True,
            css_classes=["userNameBox"],
        )

        powerButton = Widget.Button(
            child=Widget.Icon(image="system-shutdown-symbolic", pixel_size=20),
            halign="end",
            hexpand=True,
            css_classes=["userPower", "unset"],
            on_click=lambda x: self.onPowerButtonClick(),
        )

        super().__init__(
            child=[userImage, userName, powerButton],
            css_classes=["user"],
        )

    def onPowerButtonClick(self) -> None:
        subprocess.Popen(["wlogout"])
