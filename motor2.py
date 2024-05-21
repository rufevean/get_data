

from gpiozero import AngularServo
from time import sleep

# Function to run the motor for slot 2
servo = AngularServo(17, min_pulse_width=0.0006, max_pulse_width=0.0023)  # Assuming GPIO pin 17
servo.angle = 90
sleep(1)
servo.angle = 0
sleep(1)

