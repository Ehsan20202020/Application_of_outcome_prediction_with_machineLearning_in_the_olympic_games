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
