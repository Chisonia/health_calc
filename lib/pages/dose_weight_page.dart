import 'package:flutter/material.dart';

class DosePerWeightPage extends StatelessWidget {
  final TextEditingController weightController;
  final TextEditingController dosageController;
  final String dosePerWeightResult;

  const DosePerWeightPage({
    super.key,
    required this.weightController,
    required this.dosageController,
    required this.dosePerWeightResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: const Text(
          'CALCULATE DOSE PER WEIGHT',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Enter the weight and dosage",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Weight (kg)',
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
              controller: dosageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Dosage (mg)',
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
              child: Center(
                child: Text(
                  dosePerWeightResult.isEmpty
                      ? "Dose per Weight will appear here. "
                      : "Dose per Weight: $dosePerWeightResult",
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