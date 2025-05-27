import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "root:/data/"

Rectangle {

    implicitHeight: parent.height
    implicitWidth: rowL.implicitWidth
    color: "transparent"

    RowLayout {
        id: rowL

        spacing: 10
        anchors.centerIn: parent

        Repeater {
            model: SystemTray.items

            TrayItem {
                required property SystemTrayItem modelData

                item: modelData
            }

        }

    }

}
