import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme_provider.dart';

class WeightForAgePage extends StatefulWidget {
  final String selectedAgeFormat;
  final ValueChanged<String?> onAgeFormatChanged;
  final String age;
  final ValueChanged<String> onAgeChanged;

  const WeightForAgePage({
    super.key,
    required this.selectedAgeFormat,
    required this.onAgeFormatChanged,
    required this.age,
    required this.onAgeChanged,
  });

  @override
  WeightForAgePageState createState() => WeightForAgePageState();
}

class WeightForAgePageState extends State<WeightForAgePage> {
  late String selectedAgeFormat;
  late TextEditingController ageController;
  String expectedWeightAge = '';
  List<Map<String, dynamic>> calculationHistory = []; // Calculation history

  @override
  void initState() {
    super.initState();
    selectedAgeFormat = widget.selectedAgeFormat.isEmpty ? '' : widget.selectedAgeFormat;
    ageController = TextEditingController();
    _loadHistory(); // Load calculation history
  }

  @override
  void dispose() {
    ageController.dispose();
    super.dispose();
  }

  // Load history from shared preferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('calculationHistory');
    if (encodedData != null) {
      setState(() {
        calculationHistory = List<Map<String, dynamic>>.from(jsonDecode(encodedData));
      });
    }
  }

  // Save history to shared preferences
  Future<void> _saveAllCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(calculationHistory);
    await prefs.setString('calculationHistory', encodedData);
  }

  void _calculateExpectedWeight() {
    final String ageText = ageController.text;
    if (ageText.isNotEmpty) {
      final double? ageValue = double.tryParse(ageText);
      if (ageValue != null) {
        String result;
        if (selectedAgeFormat == 'Months' && ageValue < 12) {
          final expectedWeight = (ageValue + 9) / 2;
          result = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
        } else if (selectedAgeFormat == 'Years' && ageValue > 0 && ageValue <= 4) {
          final expectedWeight = 2 * (ageValue + 5);
          result = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
        } else if (selectedAgeFormat == 'Years' && ageValue > 4 && ageValue <= 14) {
          final expectedWeight = 4 * ageValue;
          result = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
        } else {
          result = "Please enter a valid age for the selected format.";
        }

        setState(() {
          expectedWeightAge = result;

          // Save to history after calculation
          Map<String, dynamic> calculation = {
            'type': 'Weight for Age Calculation',
            'result': result,
            'time': DateTime.now().toString(),
          };

          calculationHistory.add(calculation);
          _saveAllCalculations();  // Save history after calculation
        });
      } else {
        setState(() {
          expectedWeightAge = "Invalid age input.";
        });
      }
    } else {
      setState(() {
        expectedWeightAge = "Please enter a child's age.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCULATE WEIGHT FOR AGE',
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
              'Select the age format:\n "Month" for age below 1 year\n "Years" for age 1 year and above',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            Container(
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
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedAgeFormat.isEmpty ? null : selectedAgeFormat,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.deepPurple),
                elevation: 16,
                style: Theme.of(context).textTheme.headlineMedium,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedAgeFormat = value;
                    });
                    widget.onAgeFormatChanged(value);
                  }
                },
                hint: Text(
                  "Select Age Format",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                items: <String>['Months', 'Years'].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: Theme.of(context).textTheme.headlineMedium),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            buildTextField(
              label: "Enter Child's Age",
              controller: ageController,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateExpectedWeight,
              child: const Text("Calculate"),
            ),
            const SizedBox(height: 24),
            if (expectedWeightAge.isNotEmpty)
            Center(
              child: Text(
                expectedWeightAge,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable text field widget
  Widget buildTextField({required String label, required TextEditingController controller}) {
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