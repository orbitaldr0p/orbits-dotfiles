import { Widget, Battery } from "../../misc/imports.js";

export default () =>
  Widget.Box({
    className: "barPower",
    children: [
      Widget.Icon({
        connections: [
          [
            Battery,
            (self) => {
              self.icon = `battery-level-${
                Math.floor(Battery.percent / 10) * 10
              }-symbolic`;
            },
          ],
        ],
      }),
      Widget.ProgressBar({
        valign: "center",
        connections: [
          [
            Battery,
            (self) => {
              if (Battery.percent < 0) return;

              self.fraction = Battery.percent / 100;
            },
          ],
        ],
      }),
    ],
  });
