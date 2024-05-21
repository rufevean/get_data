import firebase_admin
from firebase_admin import credentials, firestore
import time
import json

# Initialize Firebase Admin SDK
cred = credentials.Certificate('serviceAccount.json')
firebase_admin.initialize_app(cred)

# Initialize Firestore client
db = firestore.client()

# Function to get data from Firestore and save it to a file
def get_data_and_save():
    try:
        docs = db.collection('dispensers').get()
        data = {}
        for doc in docs:
            data[doc.id] = doc.to_dict()
        
        with open('firestore_data.json', 'w') as file:
            json.dump(data, file, indent=4)
            
        print("Data saved to 'firestore_data.json' file.")
    except Exception as e:
        print("Error:", e)

# Main loop to fetch data and save it every 10 seconds
while True:
    get_data_and_save()
    time.sleep(10)

