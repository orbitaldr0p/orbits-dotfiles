pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import qs.data
import qs.common
import qs.config

Item {
    id: root

    required property SystemTrayItem item
    signal menuOpened
    signal menuClosed
    Layout.preferredWidth: trayIcon.width
    Layout.preferredHeight: trayIcon.height

    MouseArea {
        anchors.fill: parent

        acceptedButtons: Qt.LeftButton | Qt.RightButton
        cursorShape: Qt.PointingHandCursor

        onClicked: mouse => {
            switch (mouse.button) {
            case Qt.LeftButton:
                root.item.activate();
                break;
            case Qt.RightButton:
                if (root.item.hasMenu) {
                    const window = QsWindow.window;
                    const widgetRect = window.contentItem.mapFromItem(trayIcon, 0, trayIcon.height + 5, trayIcon.width, trayIcon.height);
                    menuAnchor.anchor.rect = widgetRect;
                    menuAnchor.open();
                    root.menuOpened();
                }
                break;
            }
        }
    }

    IconImage {
        id: trayIcon
        required property SystemTrayItem item
        item: root.item
        source: item.icon
        implicitSize: 17
    }

    QsMenuAnchor {
        id: menuAnchor
        menu: root.item.menu
        anchor.window: QsWindow.window ?? null
        anchor.adjustment: PopupAdjustment.Flip
        onClosed: root.menuClosed()
    }
}
