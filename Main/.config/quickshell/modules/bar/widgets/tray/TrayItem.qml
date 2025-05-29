import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import Quickshell.Widgets
import "root:/data/"

IconImage {
    id: root

    required property SystemTrayItem item

    source: root.item.icon
    implicitSize: 18

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: (event) => {
            switch (event.button) {
            case Qt.LeftButton:
                root.item.activate();
                break;
            case Qt.RightButton:
                if (root.item.hasMenu) {
                    const window = QsWindow.window;
                    const widgetRect = window.contentItem.mapFromItem(root, 0, root.height + 5, root.width, root.height);
                    menuAnchor.anchor.rect = widgetRect;
                    menuAnchor.open();
                }
                break;
            }
        }
    }

    QsMenuAnchor {
        id: menuAnchor

        menu: root.item.menu
        anchor.window: root.QsWindow.window ?? null
        anchor.adjustment: PopupAdjustment.Flip
    }

}
