import { Widget, Utils, App } from '../../misc/imports.js';
import panelButton from '../panelButton.js'
import GLib from 'gi://GLib';

const Clock = () => Widget.Label({
    className: 'barClock',
    connections: [
        [1000, self => Utils.execAsync(['date', '+%H:%M %b %e. %A'])
            .then(date => self.label = date).catch(console.error)],
    ],
});

export default ({ format = '%H:%M - %A %e.' } = {}) => panelButton({
    className: 'dashboard panel-button',
    onClicked: () => App.toggleWindow('dashboard'),
    connections: [[App, (btn, win, visible) => {
        btn.toggleClassName('active', win === 'dashboard' && visible);
    }]],
    child: Clock({ format }),
});
