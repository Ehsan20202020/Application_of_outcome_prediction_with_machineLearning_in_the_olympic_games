import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
//import 'package:olympic_game_prediction/core/colors.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
//import 'dart:typed_data';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> columnValues = []; // Store the column values
  Future<Map<String, dynamic>> fetchDocumentColumnValuesAPI() async {
    const apiUrl = 'http://127.0.0.1:5000/fetch_column_values';

    // Define the required query parameters
    final queryParams = {
      'collection_name': 'model_database',
      'column_name': 'Country',
      // Add more query parameters as needed
    };

    // Construct the complete URL with query parameters
    final url = Uri.parse(apiUrl).replace(queryParameters: queryParams);

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final fetchedColumnValues = jsonData['column_values'] as List<dynamic>?;
        columnValues = fetchedColumnValues != null
            ? List<String>.from(fetchedColumnValues)
            : [];
      } else {
        throw Exception('Failed to fetch document column values');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
    return {};
  }

  // List<String> columnValues = []; // Store the column values  it was thereee
  String? selectedValue; // Store the selected value
  String? selectedValue2; // Store the selected value

  @override
  void initState() {
    super.initState();
    fetchDocumentColumnValuesAPI().then((_) {
      // Call setState here to trigger a rebuild with the fetched column values
      setState(() {});
    });
  }

  void printRandomValue() {
    final random = Random();
    final dropdownIndex =
        random.nextInt(2); // Generate a random number between 0 and 1

    if (dropdownIndex == 0) {
      if (selectedValue != null) {
        final randomIndex = random.nextInt(columnValues.length);
        final randomValue = columnValues[randomIndex];
        print('The Winner is Predicted... $randomValue');
      } else {
        print('No value selected from Dropdown 1');
      }
    } else {
      if (selectedValue2 != null) {
        final randomIndex = random.nextInt(columnValues.length);
        final randomValue = columnValues[randomIndex];
        print('The Winner is Predicted... $randomValue');
      } else {
        print('No value selected from Dropdown 2');
      }
    }
  }

  /// sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      // backgroundColor: blackBG,
      backgroundColor: Colors.blueGrey[700],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          )
        ],
      ),

      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
              vertical: 20.0, horizontal: 16.0), // Add vertical padding
          child: Column(
            children: [
              Container(
                child: DropdownButton<String>(
                  value: selectedValue,
                  items: columnValues.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                ),
              ),
              const Text(
                'VS',
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                child: DropdownButton<String>(
                  value: selectedValue2,
                  items: columnValues.map((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue2 = value;
                    });
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    printRandomValue();
                  },
                  child: const Text(
                    'Predict',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // Center(
      //   child: DropdownButton<String>(
      //     value: selectedValue,
      //     items: columnValues.map((value) {
      //       return DropdownMenuItem<String>(
      //         value: value,
      //         child: Text(value),
      //       );
      //     }).toList(),
      //     onChanged: (value) {
      //       // Handle the selected value
      //       setState(() {
      //         selectedValue = value;
      //       });
      //     },
      //   ),

      // ),
    );
  }
}







































        // List<String> columnValues1 = [];
  // List<String> columnValues2 = [];
  // List<String> columnValues = []; // Store the column values
  // String? selectedValue; // Store the selected value
  // String? selectedValue2; // Store the selected value

  // Future<String?> makePrediction() async {
  //   // Check if both selected values are not null
  //   if (selectedValue != null && selectedValue2 != null) {
  //     // Prepare the input data for prediction
  //     final input = {
  //       'Country': selectedValue,
  //       'Rank_by_total':
  //           0, // Placeholder value for prediction, as it will be ignored
  //     };

  //     // Perform any necessary preprocessing on the input data
  //     // Convert the input data to JSON
  //     final jsonData = json.encode(input);

  //     // Make a request to your Flask API endpoint for prediction
  //     const apiUrl =
  //         'http://127.0.0.1:5000/fetch_column_values'; // Replace with your actual API endpoint
  //     final response = await http.post(Uri.parse(apiUrl), body: jsonData);

  //     if (response.statusCode == 200) {
  //       // Parse the response body
  //       final responseBody = json.decode(response.body);

  //       // Extract and return the predicted winner from the response
  //       final predictedWinner = responseBody['predicted_winner'] as String?;
  //       return predictedWinner;
  //     } else {
  //       throw Exception('Failed to make prediction request');
  //     }
  //   }

  //   return null; // If any selected value is null, return null
  // }

  // Future<void> fetchDocumentColumnValuesAPI2() async {
  //   const apiUrl = 'http://127.0.0.1:5000/fetch_column_values';

  //   // Define the required query parameters
  //   final queryParams = {
  //     'collection_name': 'model_database',
  //     'column_name1': 'Country',
  //     'column_name2': 'Rank By Total',
  //   };

  //   // Construct the complete URL with query parameters
  //   final url =
  //       Uri.parse(apiUrl).replace(queryParameters: queryParams).toString();

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final responseBody = response.body;
  //       if (responseBody != null) {
  //         final jsonData = json.decode(responseBody) as Map<String, dynamic>;
  //         final fetchedColumnValues1 =
  //             jsonData['column_value1'] as List<dynamic>?;
  //         final fetchedColumnValues2 =
  //             jsonData['column_value2'] as List<dynamic>?;

  //         columnValues1 = fetchedColumnValues1 != null
  //             ? List<String>.from(fetchedColumnValues1)
  //             : [];
  //         columnValues2 = fetchedColumnValues2 != null
  //             ? List<String>.from(fetchedColumnValues2)
  //             : [];
  //       } else {
  //         throw Exception('Response body is null');
  //       }
  //     } else {
  //       throw Exception('Failed to fetch document column values');
  //     }
  //   } catch (error) {
  //     throw Exception('Error: $error');
  //   }
  // }

  // List<int> rankByTotalList = [];

  // String? predictWinnerFormList() {
  //   // ... existing code ...

  //   // Get the index of each selected country
  //   final index1 = columnValues1.indexOf(selectedValue!);
  //   final index2 = columnValues2.indexOf(selectedValue2!);

  //   // Check if both selected countries are found in the column values
  //   if (index1 != -1 && index2 != -1) {
  //     // Get the corresponding "Rank_by_total" values
  //     final rank1 = rankByTotalList[index1];
  //     final rank2 = rankByTotalList[index2];

  //     // Compare the ranks to determine the winner
  //     if (rank1 < rank2) {
  //       return selectedValue;
  //     } else if (rank1 > rank2) {
  //       return selectedValue2;
  //     } else {
  //       return 'Draw';
  //     }
  //   }

  //   return null; // If any selected country is not found, return null
  // }


  /////////////////////////////////////////////////// ------ it workkkkkkkkkkkkkkkk
  ///
  ///
  ///
  ///
  // Future<void> fetchDocumentColumnValuesAPI() async {
  //   const apiUrl = 'http://127.0.0.1:5000/fetch_column_values';

  //   // Define the required query parameters
  //   final queryParams = {
  //     'collection_name': 'model_database',
  //     'column_name': 'Country',
  //     // Add more query parameters as needed
  //   };

  //   // Construct the complete URL with query parameters
  //   final url =
  //       Uri.parse(apiUrl).replace(queryParameters: queryParams).toString();

  //   try {
  //     final response = await http.get(Uri.parse(url));

  //     if (response.statusCode == 200) {
  //       final responseBody = response.body;
  //       if (responseBody != null) {
  //         final jsonData = json.decode(responseBody);
  //         final fetchedColumnValues =
  //             jsonData['column_values'] as List<dynamic>;
  //         setState(() {
  //           columnValues = List<String>.from(fetchedColumnValues);
  //         });
  //       } else {
  //         throw Exception('Response body is null');
  //       }
  //     } else {
  //       throw Exception('Failed to fetch document column values');
  //     }
  //   } catch (error) {
  //     throw Exception('Error: $error');
  //   }
  // }