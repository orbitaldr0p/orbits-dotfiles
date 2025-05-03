import os
import ignis
import asyncio
from ignis.widgets import Widget
from ignis.services.mpris import MprisService, MprisPlayer
from ignis.utils import Utils
from ignis.app import IgnisApp
from ignis.exceptions import StylePathNotFoundError


mpris = MprisService.get_default()
app = IgnisApp.get_default()


class Player(Widget.Revealer):
    def __init__(self, player: MprisPlayer) -> None:
        self._player = player
        player.connect("closed", lambda x: self.destroy())
        super().__init__(
            transition_type="slide_down",
            reveal_child=False,
            css_classes=["player"],
        )

class NowPlaying(Widget.Box):
    def __init__(self):
        super().__init__(
            vertical=True,
            setup=lambda self: mpris.connect(
                "player_added", lambda x, player: self.__add_player(player)
            ),
            css_classes=["rec-unset"],
        )

    def __add_player(self, obj: MprisPlayer) -> None:
        player = Player(obj)
        self.append(player)
        player.set_reveal_child(True)