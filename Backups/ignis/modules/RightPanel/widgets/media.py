import asyncio
from ignis.widgets import Widget
from ignis.services.mpris import MprisService, MprisPlayer
from ignis.app import IgnisApp

mprisService = MprisService.get_default()
ignisApp = IgnisApp.get_default()
blacklistPrefixes = ["chromium.", "firefox."]


class Media(Widget.Box):
    def __init__(self):
        super().__init__(vertical=True, css_classes=["rec-unset"], setup=self._setup)
        self.playerWidgets = {}

    def _setup(self, widget):
        mprisService.connect("player_added", self._onPlayerAdded)

    def _onPlayerAdded(self, service: MprisService, player: MprisPlayer):
        playerName = player.desktop_entry
        if playerName is None or any(
            playerName.startswith(prefix) for prefix in blacklistPrefixes
        ):
            return
        if playerName in self.playerWidgets:
            return

        # Metadata
        titleLabel = Widget.Label(
            label=player.bind("title"),
            ellipsize="end",
            css_classes=["mediaTitle"],
        )

        artistLabel = Widget.Label(
            label=player.bind("artist"),
            ellipsize="end",
            css_classes=["mediaArtist"],
        )

        playPauseButton = Widget.Button(
            child=Widget.Label(
                label=player.bind(
                    "playback_status",
                    lambda status: "" if status == "Playing" else "",
                ),
                css_classes=["mediaControlIcon"],
            ),
            on_click=lambda _: asyncio.create_task(player.play_pause_async()),
            visible=player.bind("can_play"),
            css_classes=["mediaControl"],
        )

        previousButton = Widget.Button(
            child=Widget.Label(label="", css_classes=["mediaControlIcon"]),
            on_click=lambda _: asyncio.create_task(player.previous_async()),
            visible=player.bind("can_go_previous"),
            css_classes=["mediaControl"],
        )

        nextButton = Widget.Button(
            child=Widget.Label(label="", css_classes=["mediaControlIcon"]),
            on_click=lambda _: asyncio.create_task(player.next_async()),
            visible=player.bind("can_go_next"),
            css_classes=["mediaControl"],
        )

        positionSlider = Widget.Scale(
            value=player.bind("position"),
            max=player.bind("length"),
            hexpand=True,
            css_classes=["mediaSeek"],
            on_change=lambda slider: asyncio.create_task(
                player.set_position_async(slider.value)
            ),
            visible=player.bind("position", lambda value: value != -1),
        )

        controlRow = Widget.Box(
            child=[previousButton, playPauseButton, nextButton],
            spacing=10,
            halign="center",
        )

        mediaBox = Widget.Box(
            vertical=True,
            css_classes=["mediaRectangle"],
            child=[
                titleLabel,
                artistLabel,
                positionSlider,
                controlRow,
            ],
        )

        self.append(mediaBox)
        self.playerWidgets[playerName] = mediaBox

        def onPlayerClosed(p):
            box = self.playerWidgets.pop(playerName, None)
            if box:
                self.remove(box)

        player.connect("closed", onPlayerClosed)
