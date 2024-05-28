
#!/bin/bash

# Function to extract all Slot1 and Slot2 alarm times from JSON file
get_slot_alarms() {
    # Check if the file exists
    if [ -f "firestore_data.json" ]; then
        # Use jq to parse JSON and extract all Slot1 and Slot2 alarm times
        slot1_alarm1=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot1Alarm1' firestore_data.json)
        slot1_alarm2=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot1Alarm2' firestore_data.json)
        slot1_alarm3=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot1Alarm3' firestore_data.json)
        slot2_alarm1=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot2Alarm1' firestore_data.json)
        slot2_alarm2=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot2Alarm2' firestore_data.json)
        slot2_alarm3=$(jq -r '.["0gzcixGt44jahOFECZ19"].slot2Alarm3' firestore_data.json)
        echo "Slot1 Alarm1 Time: $slot1_alarm1"
        echo "Slot1 Alarm2 Time: $slot1_alarm2"
        echo "Slot1 Alarm3 Time: $slot1_alarm3"
        echo "Slot2 Alarm1 Time: $slot2_alarm1"
        echo "Slot2 Alarm2 Time: $slot2_alarm2"
        echo "Slot2 Alarm3 Time: $slot2_alarm3"
    else
        echo "Error: 'firestore_data.json' file not found."
    fi
}

# Function to check if the current time matches any alarm time
check_alarms() {
    current_time=$(date +"%H:%M")
    echo "Current Time: $current_time"
    
    if [ "$current_time" == "$slot1_alarm1" ]; then
        echo "Slot1 Alarm1 time reached. Running Python file..."
        python3 motor.py 
        sleep 50
    elif [ "$current_time" == "$slot1_alarm2" ]; then
        echo "Slot1 Alarm2 time reached. Running Python file..."
        python3 motor.py 
        sleep 50
    elif [ "$current_time" == "$slot1_alarm3" ]; then
        echo "Slot1 Alarm3 time reached. Running Python file..."
        python3 motor.py 
        sleep 50
    elif [ "$current_time" == "$slot2_alarm1" ]; then
        echo "Slot2 Alarm1 time reached. Running Python file..."
        python3 motor.py 
        sleep 50
    elif [ "$current_time" == "$slot2_alarm2" ]; then
        echo "Slot2 Alarm2 time reached. Running Python file..."
        python3 motor.py 
        sleep 50
    elif [ "$current_time" == "$slot2_alarm3" ]; then
        echo "Slot2 Alarm3 time reached. Running Python file..."
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
