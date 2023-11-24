import { Widget, Notifications } from "../../misc/imports.js";

export default () =>
  Widget.Box({
    className: "barNotifications",
    children: [
      Widget.Icon({
        icon: "preferences-system-notifications-symbolic",
        connections: [
          [
            Notifications,
            (self) => (self.visible = Notifications.popups.length > 0),
          ],
        ],
      }),
      Widget.Label({
        connections: [
          [
            Notifications,
            (self) => {
              self.label = Notifications.popups[0]?.summary || "";
            },
          ],
        ],
      }),
    ],
  });
