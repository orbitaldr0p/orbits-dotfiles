import { App } from "astal/gtk4"
import style from "./widget/rightPanel/style.scss"
import rightPanel from "./widget/rightPanel/rightPanel"

App.start({
    css: style,
    main() {
        App.get_monitors().map(rightPanel)
    },
})
