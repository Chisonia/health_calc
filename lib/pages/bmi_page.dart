import 'package:flutter/material.dart';

class BMICalculationPage extends StatelessWidget {
  final String selectedUnit;
  final ValueChanged<String?> onUnitChanged;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final String bmiResult;

  const BMICalculationPage({
    super.key,
    required this.selectedUnit,
    required this.onUnitChanged,
    required this.heightController,
    required this.weightController,
    required this.bmiResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: const Text(
          'CALCULATE BMI',
          style: TextStyle(
            color: Colors.black87,
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
                color: Colors.black87,
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
                value: selectedUnit.isNotEmpty ? selectedUnit : 'Metric (kg/m²)', // Set a default value
                icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: onUnitChanged,
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
            ),
            const SizedBox(height: 24),
            TextField(
              controller: weightController,
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
                  bmiResult.isEmpty ? "BMI result will appear here." :
                  "BMI Result: $bmiResult",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}