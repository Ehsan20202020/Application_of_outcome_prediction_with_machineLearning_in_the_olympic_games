from flask import Flask, request, jsonify
import numpy as np
from sklearn.metrics import r2_score
from sklearn.ensemble import RandomForestRegressor
from sklearn.impute import SimpleImputer
from sklearn.metrics import mean_squared_error
from sklearn.pipeline import Pipeline
import util
import pandas as pd
import joblib
import pickle
import olympicdataset
from sklearn.impute import SimpleImputer

from sklearn.model_selection import train_test_split
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer

import firebase_admin
from firebase_admin import credentials, firestore,initialize_app
from google.cloud import firestore
import json
import os
from flask_cors import CORS



app = Flask(__name__)
CORS(app)


#laading dataset...
df= pd.read_csv("./Server/Tokyo Medals 2021.csv")



global __model
with open("random_forest_model3.pkl", 'rb') as f:
        __model = pickle.load(f)
        print("loading artifact is done...")
        



x = df.drop('Rank By Total', axis=1)
y = df['Rank By Total']


###################################################### THIRD WAY................................

# Perform one-hot encoding on categorical features
encoder = OneHotEncoder(sparse=False, handle_unknown='ignore')
X_encoded = encoder.fit_transform(x['Country'].values.reshape(-1, 1))


# Create a new DataFrame with the encoded features
X_encoded_df = pd.DataFrame(X_encoded, columns=encoder.get_feature_names_out(['Country']))

# Concatenate the encoded features with the remaining numerical features
X_final = pd.concat([X_encoded_df, x.drop('Country', axis=1)], axis=1)


# Create an imputer
imputer = SimpleImputer(strategy='mean')

# Fit the imputer on the data and transform the data
X_final_imputed = imputer.fit_transform(X_final)

# Split the data into training and testing sets
x_train, x_test, y_train, y_test = train_test_split(X_final_imputed, y, test_size=0.25, random_state=42)

# Train the model
__model.fit(x_train, y_train)


#################################################### store model using JSON .............................../...........
# # Path to the service account JSON key file
# service_account_path = './auth-application-a90fe-firebase-adminsdk-qsuuq-bb475eefa9.json'

# # Set the environment variable for authentication
# os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = service_account_path

# # Initialize the Firestore client
# db = firestore.Client()

# # Create a new collection
# collection_name = "json_models"  # Specify the name of the collection
# collection_ref = db.collection(collection_name)

# # Load the trained model from the .pkl file
# with open('./random_forest_model3.pkl', 'rb') as file:
#     trained_model = pickle.load(file)
    

# # Extract the necessary attributes from the trained model
# model_data = {
#     'n_estimators': trained_model.n_estimators,
#     'max_depth': trained_model.max_depth,
#     'columns': ['Country', 'Gold Medal', 'Silver Medal', 'Bronze Medal', 'Total', 'Rank By Total'],  # Replace with the actual column names
#     'Country': trained_model.country,
#     'Gold Medal': trained_model.Gold_Medal,
#     'Silver Medal': trained_model.Silver_Medal,
#     'Bronze Medal': trained_model.Bronze_Medal,
#     'Total': trained_model.Total,
#     'Rank By Total': trained_model.Rank_By_Total
#     # Add any other necessary attributes here
# }

# # Convert the model data to JSON
# serialized_model = json.dumps(model_data)

# # Print the serialized model
# print(serialized_model)

# # Create a new document in the collection and set the serialized model as a field
# document_data = {
#    'erialized_model': serialized_model
# }
# document_ref = collection_ref.document()  # Firestore generates a unique document ID
# document_ref.set(document_data)

# # Print the ID of the created document
# print("Created document with ID:", document_ref.id)


############################################# store model using pickle .............................../...........
    
# # Initialize the Firebase Admin SDK
# cred = credentials.Certificate("./auth-application-a90fe-firebase-adminsdk-qsuuq-bb475eefa9.json")
# firebase_admin.initialize_app(cred)

# # Create a reference to the Firestore collection
# collection_ref = firestore.client().collection("ML_models")

# # Create a document within the collection
# document_ref = collection_ref.document("my_ML_model")

# # Serialize the model
# serialized_model = pickle.dumps("./random_forest_model3.pkl")

# # Split the serialized model into chunks
# chunk_size = 1_000_000  # Set an appropriate chunk size
# chunks = [serialized_model[i : i + chunk_size] for i in range(0, len(serialized_model), chunk_size)]

# # Store the model chunks in Firestore
# model_ref = firestore.client().collection("ML_models").document("my_ML_model")

# for i, chunk in enumerate(chunks):
#     chunk_name = f"chunk_{i}"
#     model_ref.collection("chunks").document(chunk_name).set({"data": chunk})
    
    
    

#################################################################### stored database in firestore............................... it is DONE


# # Set the environment variable programmatically
# os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = './auth-application-a90fe-firebase-adminsdk-qsuuq-bb475eefa9.json'

# # Initialize Firebase using the service account key JSON file
# cred = credentials.Certificate('./auth-application-a90fe-firebase-adminsdk-qsuuq-bb475eefa9.json')
# firebase_app = initialize_app(cred)

# # Get a Firestore client
# db = firestore.Client()

# # Create a new collection called "model_database"
# collection_ref = db.collection("model_database")


# # Iterate over the rows of the DataFrame
# for _, row in df.iterrows():
#     # Convert the row to a dictionary
#     data_point = row.to_dict()
    
#     # Add a new document to the "model_database" collection with an automatically generated document ID
#     doc_ref = collection_ref.add(data_point)
    
#     # Print the document ID
#     print("Document ID:", doc_ref[1].id)

########################### connecting to firestore............................
# Set the environment variable programmatically
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = './auth-application-a90fe-firebase-adminsdk-qsuuq-bb475eefa9.json'

# Initialize Firebase using the service account key JSON 'file
cred = credentials.Certificate('./auth-application-a90fe-firebase-adminsdk-qsuuq-bb475eefa9.json')
firebase_admin.initialize_app(cred)

# Get a Firestore client
db = firestore.Client()




#################################################################### Get database ............................... it workkkkk

# @app.route('/fetch_column_value', methods=['GET'])
# def fetch_column_value():
    
#     collection_name = request.args.get('collection_name')
#     document_id = request.args.get('document_id')
#     column_name = request.args.get('column_name')


#     # Check if any of the required parameters is missing
#     if not collection_name or not document_id or not column_name:
#         return jsonify({'error': 'Missing query parameters'})

#     # Get a reference to the specified collection
#     collection_ref = db.collection(collection_name)

#     # Get the document reference using the document ID
#     doc_ref = collection_ref.document(document_id)

#     # Retrieve the document snapshot
#     doc_snapshot = doc_ref.get()

#     # Check if the document exists
#     if doc_snapshot.exists:
#         # Get the document data as a dictionary
#         document_data = doc_snapshot.to_dict()

#         # Retrieve the value of the specified column
#         column_value = document_data.get(column_name)

#         # Return the column value
#         return jsonify({'value': column_value})

#     # Return None if the document doesn't exist
#     return jsonify({'error': 'Document not found'})

######################*********************************fetch data from firestore wooooork !!!!!!!!!!!!!!!!!!
@app.route('/fetch_column_values', methods=['GET'])
def fetch_column_values():
    # Retrieve the query parameters from the request
    collection_name = request.args.get('collection_name')
    column_name = request.args.get('column_name')

    # Check if the required parameters are provided
    if not collection_name or not column_name:
        return jsonify({'error': 'Missing query parameters'})

    # Get a reference to the specified collection
    collection_ref = db.collection(collection_name)

    # Retrieve all documents from the collection
    docs = collection_ref.get()

    # Extract the column values from each document
    column_values = []
    for doc in docs:
        document_data = doc.to_dict()
        column_value = document_data.get(column_name)
        column_values.append(column_value)

    # Return the list of column values
    return jsonify({'column_values': column_values})


##################################### SECOND FUNcTION.11111...........................

# Flask Predict Function
@app.route('/predict', methods=['GET'])
def predict():
    country= request.args.get('Country')
    gold_medal = request.args.get('Gold Medal')
    silver_medal = request.args.get('Silver Medal')
    bronze_medal = request.args.get('Bronze Medal')
    total = request.args.get('Total')
    
    # Preprocess the input data
    country_encoded = encoder.transform([[country]])
    input_features = np.concatenate([country_encoded, [[gold_medal, silver_medal, bronze_medal, total]]], axis=1)
    input_features_imputed = imputer.transform(input_features)
    
    # Make predictions
    prediction = __model.predict(input_features_imputed)
    
    return jsonify({'The winner is predicted...': prediction.tolist()})#Predicted Rank By Total



if __name__ == "__main__":
    print("Starting python Flask Server for football game prediction...")
    app.run()
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    








    
    
    
    
    
################################### second not  fine.................................

# @app.route('/fetch_column_values', methods=['GET'])
# def fetch_column_values():
#     # Retrieve the query parameters from the request
#     collection_name = request.args.get('collection_name')
#     column_name1 = request.args.get('column_name1')  # First column name
#     column_name2 = request.args.get('column_name2')  # Second column name

#     # Check if the required parameters are provided
#     if not collection_name or not column_name1 or not column_name2:
#         return jsonify({'error': 'Missing query parameters'})

#     # Get a reference to the specified collection
#     collection_ref = db.collection(collection_name)

#     # Retrieve all documents from the collection
#     docs = collection_ref.get()

#     # Extract the column values from each document
#     column_values1 = []
#     column_values2 = []
#     for doc in docs:
#         document_data = doc.to_dict()
#         column_value1 = document_data.get(column_name1)
#         column_value2 = document_data.get(column_name2)
#         if column_value1:
#             column_values1.append(column_value1)
#         if column_value2:
#             column_values2.append(column_value2)

#     # Return the list of column values
#     return jsonify({'column_values1': column_values1, 'column_values2': column_values2})
