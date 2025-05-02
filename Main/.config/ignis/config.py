from ignis.widgets import Widget

def complex_operation(x):
    print("Doing something 1")
    print("Doing something 2")
    print("Doing something 3")

def bar(monitor: int) -> Widget.Window:  # type hinting is good practice!
    button1 = Widget.Button(
        child=Widget.Label(label="Click me!"),
        on_click=lambda x: print("you clicked the button 1"),
    )
    button2 = Widget.Button(
        child=Widget.Label(label="Don't listen him! Click me!"), on_click=complex_operation
    )
    button3 = Widget.Button(
        child=Widget.Label(label="Click me and text will change"),
        on_click=lambda x: x.child.set_label("Text changed!"),
    )

    return Widget.Window(
        namespace=f"some-window-{monitor}",  # the namespace must be unique
        monitor=monitor,
        anchor=["left", "top", "right"],  # btw put this window in the top
        child=Widget.Box(
            spacing=10,
            child=[
                Widget.Label(label="Click buttons)))"),
                button1,
                button2,
                button3,
            ],
        ),
    )

# initialize two bars for two monitors
bar(0)
bar(1)