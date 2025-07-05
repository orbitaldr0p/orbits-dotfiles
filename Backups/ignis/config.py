from ignis.utils import Utils
from ignis.app import IgnisApp
from modules import (
    RightPanel
)
app = IgnisApp.get_default()
app.apply_css(Utils.get_current_dir() + "/style.scss")
RightPanel()
