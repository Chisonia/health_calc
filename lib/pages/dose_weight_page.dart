import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customTextfield.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';

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

  // Method to calculate and save dosage, triggered on button press
  void _calculateDosage() {
    if (weightController.text.isNotEmpty &&
        dosageController.text.isNotEmpty &&
        concentrationController.text.isNotEmpty) {
      final double weight = double.parse(weightController.text);
      final double dosage = double.parse(dosageController.text);
      final double concentration = double.parse(concentrationController.text);

      // Calculate total dosage required (mg) and dosage in ml
      final double totalDosage = dosage * weight;
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
        title: CustomTextWidget(
          text: 'TOTAL DOSE IN MG & MLS',
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
                text: "Enter patient's weight, "
                    "the recommended dose per weight, and the drug's "
                    "concentration per ml",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController,
                  label: 'Enter Weight (kg)'
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: dosageController,
                  label: 'Enter Dosage (mg)'
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: concentrationController,
                  label: 'Concentration (mg/ml)'
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: _calculateDosage,
                text: 'Calculate Dosage',
              ),
              const SizedBox(height: 20),
              // Use the ResultContainer widget for total dosage result
              if (totalDosageResult.isNotEmpty)
                ResultContainer(
                  label: "Total Dosage in mg:",
                  result: totalDosageResult,
                ),
              const SizedBox(height: 20),
              // Use the ResultContainer widget for dosage in ml result
              if (dosageInMlResult.isNotEmpty)
                ResultContainer(
                  label: "Total Dosage in ml:",
                  result: dosageInMlResult,
                ),
            ],
          ),
        ),
      ),
    );
  }
}