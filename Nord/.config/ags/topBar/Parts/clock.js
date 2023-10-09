import { Widget, Utils } from '../../misc/imports.js';

export default () => Widget.Label({
    className: 'barClock',
    connections: [
        [1000, self => Utils.execAsync(['date', '+%H:%M:%S %b %e.'])
            .then(date => self.label = date).catch(console.error)],
    ],
});

