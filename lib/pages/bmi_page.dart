import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme_provider.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/customTextfield.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';

class BMICalculationPage extends StatefulWidget {
  const BMICalculationPage({super.key});

  @override
  BMICalculationPageState createState() => BMICalculationPageState();
}

class BMICalculationPageState extends State<BMICalculationPage> {
  String selectedUnit = ''; // Default unit
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String bmiResult = '';
  String bmiInterpretation = '';

  List<Map<String, dynamic>> calculationHistory = [
  ]; // Keep history in the state

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Load history on initialization
  }

  // Load history from shared preferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('calculationHistory');
    if (encodedData != null) {
      setState(() {
        calculationHistory = List<Map<String, dynamic>>.from(
            jsonDecode(encodedData));
      });
    }
  }

  void _calculateBMI() {
    if (heightController.text.isNotEmpty && weightController.text.isNotEmpty) {
      final double height = double.parse(heightController.text);
      final double weight = double.parse(weightController.text);

      double bmi;
      String unit;

      if (selectedUnit == 'Metric (kg/m²)') {
        bmi = weight / (height * height);
        unit = 'kg/m²';
      } else {
        bmi = (weight / (height * height)) * 703;
        unit = 'lbs/in²';
      }

      setState(() {
        bmiResult = bmi.toStringAsFixed(2);
        bmiInterpretation = _getBMIInterpretation(bmi);

        // Save the calculation to history only after a valid BMI result
        Map<String, dynamic> calculation = {
          'type': 'BMI Calculation',
          'result': 'BMI: $bmiResult $unit ($bmiInterpretation)',
          'time': DateTime.now().toString(),
        };

        calculationHistory.add(calculation);
        _saveAllCalculations(); // Save history after calculation
      });
    } else {
      setState(() {
        bmiResult = "Please enter valid height and weight.";
        bmiInterpretation = "";
      });
    }
  }

  // Save all calculations to SharedPreferences
  Future<void> _saveAllCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(calculationHistory);
    await prefs.setString('calculationHistory', encodedData);
  }

  String _getBMIInterpretation(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi >= 18.5 && bmi < 25.0) {
      return "Normal weight";
    } else if (bmi >= 25.0 && bmi < 30.0) {
      return "Overweight";
    } else if (bmi >= 30.0 && bmi < 35.0) {
      return "Obese";
    } else {
      return "Morbidly Obese";
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          text: 'BODY MASS INDEX',
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomInfoTextWidget(
                text: "Select the unit and enter the height and "
                    "weight for BMI calculation",
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                value: selectedUnit.isEmpty ? null : selectedUnit,
                hint: "Select Format",
                items: <String>['Metric (kg/m²)', 'Imperial (lbs/in²)'],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUnit = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Enter Height",
                controller: heightController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Enter Weight",
                controller: weightController,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: _calculateBMI,
                text: 'Calculate BMI',
              ),
              const SizedBox(height: 20),
              if (bmiResult.isNotEmpty)

                ResultContainer(
                  label: "BMI Result:",
                  result: bmiResult,
                ),

              const SizedBox(height: 20),
              if (bmiInterpretation.isNotEmpty)
                ResultContainer(
                  label: "BMI Result:",
                  result: bmiInterpretation,
                ),
            ],
          ),
        ),
      ),
    );
  }
}