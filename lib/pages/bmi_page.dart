import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_provider.dart';

class BMICalculationPage extends StatefulWidget {
  const BMICalculationPage({super.key});

  @override
  BMICalculationPageState createState() => BMICalculationPageState();
}

class BMICalculationPageState extends State<BMICalculationPage> {
  String selectedUnit = 'Metric (kg/m²)'; // Default unit
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String bmiResult = '';
  String bmiInterpretation = '';

  void _calculateBMI() {
    if (heightController.text.isNotEmpty && weightController.text.isNotEmpty) {
      final double height = double.parse(heightController.text);
      final double weight = double.parse(weightController.text);

      double bmi;

      if (selectedUnit == 'Metric (kg/m²)') {
        bmi = weight / (height * height); // BMI calculation in metric units
      } else {
        bmi = (weight / (height * height)) * 703; // BMI calculation in imperial units
      }

      setState(() {
        bmiResult = bmi.toStringAsFixed(2); // Format BMI result to 2 decimal places
        bmiInterpretation = _getBMIInterpretation(bmi); // Get the interpretation
      });
    } else {
      setState(() {
        bmiResult = "Please enter valid height and weight.";
        bmiInterpretation = "";
      });
    }
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
        title: const Text(
          'CALCULATE BMI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
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
            const Text(
              "Select the unit and enter the height and weight for BMI calculation:",
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedUnit,
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedUnit = newValue!;
                    _calculateBMI(); // Recalculate BMI when the unit changes
                  });
                },
                items: <String>['Metric (kg/m²)', 'Imperial (lbs/in²)']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Height',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Weight',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) => _calculateBMI(),
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.shade100,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  bmiResult.isEmpty
                      ? "BMI result will appear here."
                      : "BMI Result: $bmiResult",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            if (bmiInterpretation.isNotEmpty)
              Text(
                "Interpretation: $bmiInterpretation",
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }
}