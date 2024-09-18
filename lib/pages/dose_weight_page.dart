import 'package:flutter/material.dart';

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

  void _calculateDosage() {
    if (weightController.text.isNotEmpty && dosageController.text.isNotEmpty && concentrationController.text.isNotEmpty) {
      final double weight = double.parse(weightController.text);
      final double dosage = double.parse(dosageController.text);
      final double concentration = double.parse(concentrationController.text);

      // Calculate total dosage required (mg)
      final double totalDosage = dosage * weight; // Total dosage = dosage * weight

      // Calculate dosage in ml
      final double dosageInMl = totalDosage / concentration; // ml

      setState(() {
        totalDosageResult = totalDosage.toStringAsFixed(2); // Format to 2 decimal places
        dosageInMlResult = dosageInMl.toStringAsFixed(2); // Format to 2 decimal places
      });
    } else {
      setState(() {
        totalDosageResult = "Please fill all fields.";
        dosageInMlResult = "";
      });
    }
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
            const SizedBox(height: 10),
            const Text(
              "Enter patient's weight, the recommended dose per weight and the drug's concentration per ml",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 16),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[100], // Changes based on theme
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
                  decoration: InputDecoration(
                    labelText: 'Enter Weight (kg)',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none
                  ),
                  style: Theme.of(context).textTheme.headlineMedium,
                  onChanged: (value) {
                    setState(() {
                      totalDosageResult = '';
                      dosageInMlResult = '';
                    });
                    _calculateDosage();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[100], // Changes based on theme
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: TextField(
                  controller: dosageController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Enter Dosage (mg)',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      totalDosageResult = '';
                      dosageInMlResult = '';
                    });
                    _calculateDosage();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[100], // Changes based on theme
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: TextField(
                  controller: concentrationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Concentration (mg/ml)',
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    setState(() {
                      totalDosageResult = '';
                      dosageInMlResult = '';
                    });
                    _calculateDosage();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.deepOrangeAccent.shade100,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  totalDosageResult.isEmpty
                      ? "Total Dosage will appear here."
                      : "Total Dosage: $totalDosageResult mg",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.lightBlueAccent.shade100,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Center(
                child: Text(
                  dosageInMlResult.isEmpty
                      ? "Dosage in ml will appear here."
                      : "Dosage: $dosageInMlResult ml",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}