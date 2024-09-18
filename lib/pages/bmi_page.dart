import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  void _selectedUnit(String? newValue) {
    if (newValue != null) {
      setState(() {
        selectedUnit = newValue;
        _calculateBMI(); // Recalculate BMI when the unit changes
      });
    }
  }

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
                onChanged: _selectedUnit,
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
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: TextField(
                  controller: heightController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Enter Height',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.headlineMedium,
                  onChanged: (value) => _calculateBMI(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: TextField(
                  controller: weightController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: 'Enter Weight',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.headlineMedium,
                  onChanged: (value) => _calculateBMI(),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.black54
                    : Colors.deepOrangeAccent.shade100,
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
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 24),
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
}
