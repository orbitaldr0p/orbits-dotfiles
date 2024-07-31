#!/bin/bash
# Kill and restart fabric whenever its config files change
CONFIG_FILES="$HOME/.config/fabric/bar.py $HOME/.config/fabric/bar.css"
# source ~/Technical/fabric/venv/bin/activate

# Function to kill the running python process
kill_python() {
    if [ -n "$PYTHON_PID" ]; then
        kill "$PYTHON_PID"
        wait "$PYTHON_PID" 2>/dev/null
    fi
}

trap "kill_python" EXIT

while true; do
    python .config/fabric/bar.py &
    PYTHON_PID=$!
    inotifywait -e create,modify $CONFIG_FILES
    kill_python
done
