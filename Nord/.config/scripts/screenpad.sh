#!/bin/bash
# Check if laptop is charging
if [[ $(acpi) != *"Discharging"* ]]; then
    screenpad 9
fi
