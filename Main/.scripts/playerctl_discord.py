import struct
import sys

import dbus
import logging
import time
import pypresence

# ANSI escape codes for color formatting
ansiRed = "\033[91m"
ansiYellow = "\033[93m"
ansiGreen = "\033[92m"
ansiReset = "\033[0m"

discordID = 998718019549270036
display = "{xesam-artist} - {xesam-title}"


def connectionManager():
    logging.basicConfig(stream=sys.stdout, level=logging.INFO)
    logger = logging.getLogger(__name__)
    interface = None
    while True:
        try:
            bus = dbus.SessionBus()
            player = bus.get_object(
                "org.mpris.MediaPlayer2.strawberry", "/org/mpris/MediaPlayer2"
            )
            interface = dbus.Interface(
                player, dbus_interface="org.freedesktop.DBus.Properties"
            )

            discord = pypresence.Presence(discordID)
            discord.connect()

            update(interface)

        except dbus.exceptions.DBusException:
            logger.error(f"Connection to Strawberry failed. Retrying in 10 secs.")
            player = None
            interface = None
            time.sleep(10)


def update(interface):
    pass
