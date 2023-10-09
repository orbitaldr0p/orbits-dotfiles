// importing 
import App from 'resource:///com/github/Aylur/ags/app.js';

import topBar from './topBar/topBar.js';


export default {
    style: App.configDir + '/style.css',
    windows: [
        topBar({ monitor: 0 } ),
    ],
};