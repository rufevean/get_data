#!/bin/bash

# Function to extract Slot1 alarm time from JSON file
get_slot1_alarm() {
    # Check if the file exists
    if [ -f "firestore_data.json" ]; then
        # Use jq to parse JSON and extract Slot1 alarm time
        slot1_alarm=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot1Alarm' firestore_data.json)
        echo "Slot1 Alarm Time: $slot1_alarm"
    else
        echo "Error: 'firestore_data.json' file not found."
    fi
}

# Function to check if the current time matches the alarm time
check_alarm() {
    current_time=$(date +"%H:%M")
    echo "Current Time: $current_time"
    
    if [ "$current_time" == "$slot1_alarm" ]; then
        echo "Alarm time reached. Running Python file..."
        python3 motor.py 
	sleep 50
    else
        echo "Alarm time not reached yet."
    fi
}

# Main loop to continuously check the alarm time every 10 seconds
while true; do
    get_slot1_alarm
    check_alarm
    sleep 10
done

