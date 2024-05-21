
#!/bin/bash

# Function to extract Slot1 and Slot2 alarm times from JSON file
get_slot_alarms() {
    # Check if the file exists
    if [ -f "firestore_data.json" ]; then
        # Use jq to parse JSON and extract Slot1 and Slot2 alarm times
        slot1_alarm=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot1Alarm' firestore_data.json)
        slot2_alarm=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot2Alarm' firestore_data.json)
        echo "Slot1 Alarm Time: $slot1_alarm"
        echo "Slot2 Alarm Time: $slot2_alarm"
    else
        echo "Error: 'firestore_data.json' file not found."
    fi
}

# Function to check if the current time matches any alarm time
check_alarms() {
    current_time=$(date +"%H:%M")
    echo "Current Time: $current_time"
    
    if [ "$current_time" == "$slot1_alarm" ]; then
        echo "Slot1 Alarm time reached. Running Python file..."
        python3 motor.py 
        sleep 50
    elif [ "$current_time" == "$slot2_alarm" ]; then
        echo "Slot2 Alarm time reached. Running Python file..."
        python3 motor.py 
        sleep 50
    else
        echo "Alarm time not reached yet."
    fi
}

# Main loop to continuously check the alarm times every 10 seconds
while true; do
    get_slot_alarms
    check_alarms
    sleep 10
done

