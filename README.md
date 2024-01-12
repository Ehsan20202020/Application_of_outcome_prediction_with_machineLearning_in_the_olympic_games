# Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games
# Objective:
This project aims to develop models using pre-game available information to predict the number of medals each country will win at the Rio Olympics. Additionally, the numbers of Gold, Silver, and Bronze medals are also predicted using different machine learning models. Furthermore, it predicts the ranking or performance of the top 10 countries in the upcoming Olympics.
# Data Analysis:
I am using the Kaggle dataset as a data source to develop the project. The dataset I downloaded from Kaggle is titled "Tokyo 2020 Olympic Medals (Tokyo 2020 Olimpiyat Madalyası)" and can be found at this link (https://www.kaggle.com/datasets/berkayalan/2021-olympics-medals-in-tokyo). The dataset I am using consists of 93 rows and 6 columns, with variables including Country (country names), Gold Medal (number of gold medals won), Silver (number of silver medals won), Bronze Medals (number of bronze medals won), Total (total number of medals won), and Rank By Total (team ranking).

Firstly, necessary operations were performed using the Python language, such as data cleaning and checking for any missing values, with processes like assigning values in case of missing data. Training and validation data were generated. All modeling exercises were done using the scikit-learn package in Python.

# Method and Algorihtm used for the project.
I utilized Firebase Firestore technology, which is suitable for Flutter projects. Additionally, I am using the Random Forest Regressor for model creation and prediction processes. I attempted to integrate my mobile application developed with Flutter with machine learning using the Scikit-learn library.
# Database:
As seen in Figure, the training model was added to Firestore, and then the Flutter mobile application was integrated with Firestore to access the ML model.
![veritabanı](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/180caccd-cf8c-4703-be53-73a9d372b4a7)
# Authentication:

As seen in Figure, the email address, registration date, last login date, and the unique user ID of a person who registers in the application are visible through this service. This service also facilitates operations such as email verification, email change, and password reset. Additionally, users can log in to the application using social media accounts such as Google, Facebook, Twitter, and Github through the authentication service.
![2](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/2d440d4d-0ec6-41d3-9327-d64979ae42d1)

# Random Forest Regression Algorithm:
The Random Forest regression algorithm creates a regression model using a series of decision trees. This model employs randomness and ensemble methods to capture patterns and relationships in the dataset. 
In the project, I created a model using the Random Forest Regressor algorithm, and previously, I split the data into two sets for the x and y variables. The y variable holds a single column and is used for predictions, defined as the target. I assigned the split data to the x_train, x_test, y_train, and y_test variables, then trained them. To achieve better results, I expanded the data, utilizing features like automatic labeling. Subsequently, I carried out prediction processes. The figure displays the prediction results and the steps taken.
![4](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/2fb84581-d24b-4fc6-9a54-cb820b4a75ba)
# Model Creation and Training:
I determined the complexity of the model by controlling the number of trees (n_estimators) and the maximum depth for each tree (max_depth) with parameters. Since the Random Forest algorithm trains each tree using a subset of the dataset, each tree will be different. This ensures that the ensemble model is more generalizable and reduces the problem of overfitting. After training the model, you can make predictions on examples from the test dataset. Each tree will produce its own prediction. The overall prediction is obtained by taking the average of all tree predictions (for regression) or the most common prediction (for classification).
![5](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/5b273283-ab70-4203-94e8-2f49ac887699)
The prediction results are shown in the figure below. After expanding the data and training the model, the best result I obtained was 87.34%.
![9](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/048d787b-f135-4199-b03b-5aafefee26b4)
# The interface of Application:
Splash page: Before entering the application, a brief description of the Olympic Games is provided in a few lines. The user can open the entry page by reading the text and pressing the "Get Start" button, then log in to the application.
![splashPage](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/1e58385b-692e-40c5-a48a-45f76de0efe4)
# Login Page: 
The user needs to have a user account to use the application. If they already have an account, they can enter the application by typing their email address in the User Name section, entering the password, and then pressing the Sign In button.
![userPage](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/b868bce3-85bb-4898-aeee-95cf95353768)
# SignUp or Register page:
On the login page, you can open the registration page by clicking on the text "Register Now" at the bottom of Figure. Alternatively, you can open the registration page by clicking on the text "or create an account" on the opening page.
![registerPage](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/f22da0b4-c54b-44ba-9eca-51fd95e5ed33)
# Home Page: 
On the home page, the user can select countries from the "veriden" (from data) dropdown menu that are in the database. Similarly, they can choose the opposing team from the dropdown menu. After selecting the teams, the results are displayed by pressing the "Predict" button. The figure shows the interface of the mobile application. The application's interface is simple, making it user-friendly. The user can exit the application by pressing the button on the right.
![homPage2](https://github.com/Ehsan20202020/Application_of_outcome_prediction_with_machineLearning_in_the_olympic_games/assets/63020393/f5811dd1-9129-458e-9a69-f9c24f7522be)








