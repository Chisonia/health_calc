import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DosePerWeightPage extends StatefulWidget {
  const DosePerWeightPage({super.key});

  @override
  DosePerWeightPageState createState() => DosePerWeightPageState();
}

class DosePerWeightPageState extends State<DosePerWeightPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController concentrationController = TextEditingController();

  String totalDosageResult = '';
  String dosageInMlResult = '';

  // Method to calculate and save dosage, only triggered on button press
  void _calculateDosage() {
    if (weightController.text.isNotEmpty &&
        dosageController.text.isNotEmpty &&
        concentrationController.text.isNotEmpty) {
      final double weight = double.parse(weightController.text);
      final double dosage = double.parse(dosageController.text);
      final double concentration = double.parse(concentrationController.text);

      // Calculate total dosage required (mg)
      final double totalDosage = dosage * weight;

      // Calculate dosage in ml
      final double dosageInMl = totalDosage / concentration;

      setState(() {
        totalDosageResult = totalDosage.toStringAsFixed(2);
        dosageInMlResult = dosageInMl.toStringAsFixed(2);
      });

      // Save the calculation to history once
      _saveToHistory(totalDosageResult, dosageInMlResult);
    }
  }

  // Save calculation history to SharedPreferences
  Future<void> _saveToHistory(String totalDosage, String dosageInMl) async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('calculationHistory');

    List<Map<String, dynamic>> history = [];
    if (encodedData != null) {
      history = List<Map<String, dynamic>>.from(jsonDecode(encodedData));
    }

    final newEntry = {
      'type': 'Dosage Calculation',
      'result': 'Total Dosage: $totalDosage mg, Dosage: $dosageInMl ml',
      'time': DateTime.now().toString(),
    };

    history.add(newEntry);

    await prefs.setString('calculationHistory', jsonEncode(history));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCULATE TOTAL DOSE FOR WEIGHT',
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
            const SizedBox(height: 16),
            const Text(
              "Enter patient's weight, the recommended dose per weight, and the drug's concentration per ml",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            _buildTextField(context, weightController, 'Enter Weight (kg)'),
            const SizedBox(height: 24),
            _buildTextField(context, dosageController, 'Enter Dosage (mg)'),
            const SizedBox(height: 24),
            _buildTextField(
                context, concentrationController, 'Concentration (mg/ml)'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateDosage, // Calculation triggered only here
              child: const Text('Calculate Dosage'),
            ),
            const SizedBox(height: 24),
            if (totalDosageResult.isNotEmpty)
            _buildResultContainer(context, totalDosageResult, 'Total Dosage: '),
            const SizedBox(height: 16),
            if (dosageInMlResult.isNotEmpty)
            _buildResultContainer(context, dosageInMlResult, 'Total Dosage in mls: '),
          ],
        ),
      ),
    );
  }

  // Method to build text fields
  Container _buildTextField(
      BuildContext context,
      TextEditingController controller,
      String label
      ) {
    return Container(
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
      child: Center(
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: Theme.of(context).textTheme.labelMedium,
            border: InputBorder.none,
          ),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }

  // Method to build result display
  Center _buildResultContainer(BuildContext context, String result, String label) {
    return Center(
      child: Text(
        result.isEmpty ? "$label will appear here." : "$label $result",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}