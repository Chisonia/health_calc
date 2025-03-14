import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customTextfield.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';

class DosePerWeightPage extends StatefulWidget {
  const DosePerWeightPage({Key? key}) : super(key: key);

  @override
  DosePerWeightPageState createState() => DosePerWeightPageState();
}

class DosePerWeightPageState extends State<DosePerWeightPage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController concentrationController = TextEditingController();

  String totalDosageResult = '';
  String dosageInMlResult = '';
  List<Map<String, dynamic>> calculationHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    weightController.dispose();
    dosageController.dispose();
    concentrationController.dispose();
    super.dispose();
  }

  // Load history from shared preferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('calculationHistory');
    if (encodedData != null) {
      setState(() {
        calculationHistory =
        List<Map<String, dynamic>>.from(jsonDecode(encodedData));
      });
    }
  }

  // Save history to shared preferences
  Future<void> _saveAllCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(calculationHistory);
    await prefs.setString('calculationHistory', encodedData);
  }

  // Method to calculate and save dosage, triggered on button press
  void _calculateDosage() {
    if (weightController.text.isEmpty ||
        dosageController.text.isEmpty ||
        concentrationController.text.isEmpty) {
      setState(() {
        totalDosageResult = "Please enter all values.";
        dosageInMlResult = "";
      });
      return;
    }

    final double weight = double.parse(weightController.text);
    final double dosage = double.parse(dosageController.text);
    final double concentration = double.parse(concentrationController.text);

    // Calculate total dosage required (mg) and dosage in ml
    final double totalDosage = dosage * weight;
    final double dosageInMl = totalDosage / concentration;

    setState(() {
      totalDosageResult = totalDosage.toStringAsFixed(2);
      dosageInMlResult = dosageInMl.toStringAsFixed(2);

      // Add the new calculation to the history
      Map<String, dynamic> calculation = {
        'type': 'Dosage Calculation',
        'result':
        'Total Dosage: ${totalDosageResult} mg, Dosage: ${dosageInMlResult} ml',
        'time': DateTime.now().toString(),
        'weight': weight,
        'dosage': dosage,
        'concentration': concentration,
      };

      calculationHistory.add(calculation);
      _saveAllCalculations(); // Save updated history
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
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
              const CustomInfoTextWidget(
                text: "Enter patient's weight, "
                    "the recommended dose per weight, and the drug's "
                    "concentration per ml",
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: weightController, label: 'Enter Weight (kg)'),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: dosageController, label: 'Enter Dosage (mg)'),
              const SizedBox(height: 20),
              CustomTextField(
                  controller: concentrationController,
                  label: 'Concentration (mg/ml)'),
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