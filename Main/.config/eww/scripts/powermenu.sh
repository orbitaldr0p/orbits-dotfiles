function first_action() {
    killall waybar
    eww open powermenu
}

# Function to perform the second action
function second_action() {
    eww close powermenu
    waybar
}

# Run the first action
first_action

# Wait for the user to press Esc
read -n 1 -s key
while [ "$key" != $'\e' ]; do
    read -n 1 -s key
done

# If Esc is pressed, perform the second action
if [ "$key" == $'\e' ]; then
    second_action
fi
