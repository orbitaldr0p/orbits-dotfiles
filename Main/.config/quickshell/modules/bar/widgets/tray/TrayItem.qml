import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Services.SystemTray
import "root:/data/"

MouseArea {
	id: trayItem

	required property SystemTrayItem item
	Layout.preferredWidth: trayIcon.width
	Layout.preferredHeight: trayIcon.height

	acceptedButtons: Qt.LeftButton | Qt.RightButton
	cursorShape: Qt.PointingHandCursor

	onClicked: mouse => {
		switch (mouse.button) {
			case Qt.LeftButton:
				item.activate();
				break;
			case Qt.RightButton:
				if (item.hasMenu) {
					const window = QsWindow.window;
					const widgetRect = window.contentItem.mapFromItem(trayIcon, 0, trayIcon.height + 5, trayIcon.width, trayIcon.height);
					menuAnchor.anchor.rect = widgetRect;
					menuAnchor.open();
				}
				break;
		}
	}

	IconImage {
		id: trayIcon
		required property SystemTrayItem item
		item: trayItem.item
		source: item.icon
		implicitSize: 17
	}

	QsMenuAnchor {
		id: menuAnchor
		menu: item.menu
		anchor.window: QsWindow.window ?? null
		anchor.adjustment: PopupAdjustment.Flip
	}
}
