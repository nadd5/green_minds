import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../App Themes/app_colors.dart';

class CropInputScreen extends StatefulWidget {
  static const String routeName = 'crop_input';

  const CropInputScreen({super.key});
  @override
  _CropInputScreenState createState() => _CropInputScreenState();
}

class _CropInputScreenState extends State<CropInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, TextEditingController> _controllers = {
    'Nitrogen': TextEditingController(),
    'Phosphorus': TextEditingController(),
    'Potasium': TextEditingController(),
    'Temperature': TextEditingController(),
    'Humidity': TextEditingController(),
    'Potential of Hydrogen': TextEditingController(),
    'Rainfall': TextEditingController(),
  };

  String? _predictedCrop;
  bool _isLoading = false;

  Future<void> predictCrop() async {
    setState(() {
      _isLoading = true;
    });

    final url = Uri.parse('http://127.0.0.1:5000/predict');
    print('Prediction URL: $url');// Replace with deployed server URL
    final Map<String, dynamic> data = {
      'model': 'KNN', // Adjust model name if necessary
      'features': [
        double.tryParse(_controllers['N']!.text) ?? 0,
        double.tryParse(_controllers['P']!.text) ?? 0,
        double.tryParse(_controllers['K']!.text) ?? 0,
        double.tryParse(_controllers['temperature']!.text) ?? 0,
        double.tryParse(_controllers['humidity']!.text) ?? 0,
        double.tryParse(_controllers['ph']!.text) ?? 0,
        double.tryParse(_controllers['rainfall']!.text) ?? 0,
      ],
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        setState(() {
          // Assuming the server returns the predicted crop in a key called 'prediction'
          _predictedCrop = jsonResponse['prediction']?.toString() ?? 'Unknown crop';
        });
      } else {
        setState(() {
          _predictedCrop = 'Error: ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _predictedCrop = 'error';
        print(e);
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.yellowGreenColor,
      appBar: AppBar(
backgroundColor: AppColors.greenColor,
        title: Text('Crops Prediction', style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.gray),),
      ),
      body:Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/2.png'),
            fit: BoxFit.cover, 
          ),
        ),
      child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ..._controllers.keys.map((key) {
                return TextFormField(
                  controller: _controllers[key],
                  decoration: InputDecoration(labelText: key),

                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '$key is required';
                    }
                    if (double.tryParse(value) == null) {
                      return '$key must be a number';
                    }
                    return null;
                  },
                );

              }),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    predictCrop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(129, 199, 132, 1),
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text('Predict', style: TextStyle(color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,),),
              ),

              const SizedBox(height: 20),
              if (_isLoading) CircularProgressIndicator(),
              if (_predictedCrop != null && !_isLoading)
                Text(
                  'Predicted Crop: $_predictedCrop',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    ));
  }
}
