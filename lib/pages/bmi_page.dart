import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme_provider.dart';

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

  List<Map<String, dynamic>> calculationHistory = []; // Keep history in the state

  @override
  void initState() {
    super.initState();
    _loadHistory();  // Load history on initialization
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
        _saveAllCalculations();  // Save history after calculation
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
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return "Normal weight";
    } else if (bmi >= 25.0 && bmi < 29.9) {
      return "Overweight";
    } else if (bmi >= 30.0 && bmi < 34.9) {
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
        title: Text(
          'CALCULATE BMI',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              "Select the unit and enter the height and weight for BMI calculation:",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.grey[50],
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedUnit.isEmpty ? null : selectedUnit,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.deepPurple),
                elevation: 16,
                style: Theme.of(context).textTheme.headlineMedium,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUnit = newValue!;
                  });
                },
                hint: Text(
                  "Select Format",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                items: <String>['Metric (kg/m²)', 'Imperial (lbs/in²)']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            buildTextField(
              label: "Enter Height",
              controller: heightController,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            buildTextField(
              label: "Enter Weight",
              controller: weightController,
              textAlign: TextAlign.start,

            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateBMI,  // Calculate BMI on button press
              child: const Text(
                  'Calculate BMI'
              ),
            ),
            const SizedBox(height: 24),
            if (bmiResult.isNotEmpty)
              Text(
                "BMI Result: $bmiResult",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
            if (bmiInterpretation.isNotEmpty)
              Text(
                "Interpretation: $bmiInterpretation",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  // Custom text field UI
  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[50],
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.deepPurple,
          width: 2.0,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}