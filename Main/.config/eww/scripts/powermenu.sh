function first_action() {
    eww open powermenu
    echo "task 1"
}

# Function to perform the second action
function second_action() {
    eww close powermenu
    echo "task 2"
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
