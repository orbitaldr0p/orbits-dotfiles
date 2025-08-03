pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Bluetooth

Singleton {
    id: root
    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property list<BluetoothDevice> devices: adapter?.devices.values ?? []
    readonly property string adapterState: adapter?.state.toString() ?? "Disabled"
    readonly property bool discovering: adapter?.discovering ?? false

    function launchBTMenu() {
        btMenu.running = true;
    }

    Process {
        id: btMenu
        command: ["sh", "-c", "blueberry"]
    }
}
