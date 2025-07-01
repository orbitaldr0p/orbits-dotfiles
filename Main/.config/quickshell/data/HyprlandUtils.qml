pragma Singleton
pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Hyprland

Singleton {
    id: hyprland

    property var workspaces: sortWorkspaces(Hyprland.workspaces.values)
    property HyprlandWorkspace focusedWorkspace: Hyprland.focusedMonitor ? Hyprland.focusedMonitor.activeWorkspace : null
    property int maxWorkspace: findMaxId()

    function sortWorkspaces(ws) {
        return Array.from(ws).sort(function (a, b) {
            return a.id - b.id;
        });
    }

    function switchWorkspace(w) {
        console.log("workspace: focus " + (focusedWorkspace ? focusedWorkspace.id : "none") + " -> " + w);
        Hyprland.dispatch("workspace " + w);
    }

    function findMaxId() {
        var num = hyprland.workspaces.length;
        return num > 0 ? hyprland.workspaces[num - 1].id : 0;
    }

    Connections {
        function onRawEvent(event) {
            // console.log("EVENT NAME", event.name);
            // consow.wg("EVENT DATA", event.data);
            let eventName = event.name;
            switch (eventName) {
            case "createworkspacev2":
                {
                    hyprland.workspaces = hyprland.sortWorkspaces(Hyprland.workspaces.values);
                    hyprland.maxWorkspace = findMaxId();
                }
                ;
            case "destroyworkspacev2":
                {
                    hyprland.workspaces = hyprland.sortWorkspaces(Hyprland.workspaces.values);
                    hyprland.maxWorkspace = findMaxId();
                }
                ;
            }
        }

        target: Hyprland
    }
}
