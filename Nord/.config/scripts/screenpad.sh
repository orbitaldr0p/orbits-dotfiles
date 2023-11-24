#!/bin/bash
# Only turn on the screenpad if the laptop is plugged on
if [[ $(acpi) != *"Discharging"* ]]; then
    screenpad 9
fi
