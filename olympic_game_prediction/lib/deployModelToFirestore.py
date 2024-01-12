import firebase_admin
import base64
import json
from firebase_admin import credentials
from firebase_admin import firestore


# Initialize Firebase Admin SDK
cred = credentials.Certificate("auth-application-a90fe-firebase-adminsdk-qsuuq-bb475eefa9.json")
firebase_admin.initialize_app(cred)


# Assuming you have a trained model stored as a JSON file
model_path = "random_forest_model.json"

# Load the model from the JSON file
with open(model_path, "r") as f:
    model_data = json.load(f)

# Serialize the model to a JSON string
serialized_model = json.dumps(model_data)

# Connect to Firestore
db = firestore.client()

# Store the serialized model in Firestore
doc_ref = db.collection('models').document('my_model')
doc_ref.set({
    'name': 'My Model',
    'version': '1.0',
    'model_data': serialized_model
})

