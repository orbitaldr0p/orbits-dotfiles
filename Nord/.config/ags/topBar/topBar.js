// importing 
import { Widget } from '../misc/imports.js';
import workspace from './Parts/workspace.js';
import clock from './Parts/clock.js';
import notifications from './Parts/notifications.js';
import volume from './Parts/volume.js';
import power from './Parts/power.js';
import sysTray from './Parts/sysTray.js';

// layout of the bar3
const Left = () => Widget.Box({
    children: [
        workspace(),
    ],
});

const Center = () => Widget.Box({
    children: [
        clock(),
        notifications(),
    ],
});

const Right = () => Widget.Box({
    halign: 'end',
    children: [
        volume(),
        power(),
        sysTray(),
    ],
});

export default monitor => Widget.Window({
    name: `topBar-${monitor}`, // name has to be unique
    className: 'topBar',
    monitor,
    anchor: ['top', 'left', 'right'],
    exclusive: true,
    child: Widget.CenterBox({
        startWidget: Left(),
        centerWidget: Center(),
        endWidget: Right(),
    }),
})