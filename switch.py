import RPi.GPIO as GPIO
import time
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

# Set GPIO mode
GPIO.setmode(GPIO.BCM)

# Set up GPIO pin for the switch
switch_pin = 16
GPIO.setup(switch_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

# Email configuration
sender_email = "dheerajchowdary3476@gmail.com"
sender_password = "ruFF2004"
receiver_email = "chowdary.s.deeraj@gmail.com"

def send_email():
    msg = MIMEMultipart()
    msg['From'] = sender_email
    msg['To'] = receiver_email
    msg['Subject'] = "Switch Pressed"

    body = "The switch connected to the Raspberry Pi has been pressed."
    msg.attach(MIMEText(body, 'plain'))

    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(sender_email, sender_password)
        text = msg.as_string()
        server.sendmail(sender_email, receiver_email, text)
        server.quit()
        print("Email sent successfully")
    except Exception as e:
        print("Error sending email:", e)

try:
    while True:
        # Read the state of the switch
        switch_state = GPIO.input(switch_pin)

        # Print the state of the switch
        if switch_state == GPIO.LOW:
            print("Switch is pressed")
            send_email()

        # Delay to avoid excessive polling
        time.sleep(0.1)

except KeyboardInterrupt:
    # Clean up GPIO on keyboard interrupt
    GPIO.cleanup()

