import { Widget, Mpris } from "../../misc/imports.js";

export default () =>
  Widget.Button({
    className: "barMedia",
    onPrimaryClick: () => Mpris.getPlayer("")?.playPause(),
    onScrollUp: () => Mpris.getPlayer("")?.next(),
    onScrollDown: () => Mpris.getPlayer("")?.previous(),
    child: Widget.Label({
      connections: [
        [
          Mpris,
          (self) => {
            const mpris = Mpris.getPlayer("");
            // mpris player can be undefined
            if (mpris)
              self.label = `${mpris.trackArtists.join(", ")} - ${
                mpris.trackTitle
              }`;
            else self.label = "Nothing is playing";
          },
        ],
      ],
    }),
  });
