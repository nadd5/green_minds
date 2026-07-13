import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flask API Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: APITestPage(),
    );
  }
}

class APITestPage extends StatefulWidget {
  const APITestPage({super.key});

  @override
  _APITestPageState createState() => _APITestPageState();
}

class _APITestPageState extends State<APITestPage> {
  String _apiResponse = 'No Response';
  final String baseUrl = "http://127.0.0.1:5000";

  // Train model
  Future<void> trainModel() async {
    final url = Uri.parse('$baseUrl/train');
    final response = await http.post(url);

    setState(() {
      if (response.statusCode == 200) {
        _apiResponse = "Train Scores: ${jsonDecode(response.body)['scores']}";
      } else {
        _apiResponse = "Train Error: ${response.body}";
      }
    });
  }

  // Predict
  Future<void> predict(String model, List<double> features) async {
    final url = Uri.parse('$baseUrl/predict');
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "model": model,
        "features": features,
      }),
    );

    setState(() {
      if (response.statusCode == 200) {
        _apiResponse = "Prediction: ${jsonDecode(response.body)['prediction']}";
      } else {
        _apiResponse = "Predict Error: ${response.body}";
      }
    });
  }

  // Feature Importance
  Future<void> getFeatureImportance() async {
    final url = Uri.parse('$baseUrl/feature-importance?model=Random_Forest');
    final response = await http.get(url);

    setState(() {
      if (response.statusCode == 200) {
        _apiResponse =
        "Feature Importance: ${jsonDecode(response.body)['feature_importance']}";
      } else {
        _apiResponse = "Error: ${response.body}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flask API Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: trainModel,
              child: Text('Train Model'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => predict('KNN', [80, 40, 40, 20.0, 80.0, 6.5, 100.0]),
              child: Text('Predict with KNN'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: getFeatureImportance,
              child: Text('Get Feature Importance (RF)'),
            ),
            SizedBox(height: 20),
            Text(
              _apiResponse,
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
