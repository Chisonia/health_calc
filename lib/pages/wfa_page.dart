import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme_provider.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/customTextfield.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';

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
    selectedAgeFormat =
    widget.selectedAgeFormat.isEmpty ? '' : widget.selectedAgeFormat;
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

  void _calculateExpectedWeight() {
    final String ageText = ageController.text;
    if (ageText.isNotEmpty) {
      final double? ageValue = double.tryParse(ageText);
      if (ageValue != null) {
        String result;
        if (selectedAgeFormat == 'Months' && ageValue < 12) {
          final expectedWeight = (ageValue + 9) / 2;
          result = '${expectedWeight.toStringAsFixed(2)} kg';
        } else
        if (selectedAgeFormat == 'Years' && ageValue > 0 && ageValue <= 4) {
          final expectedWeight = 2 * (ageValue + 5);
          result = '${expectedWeight.toStringAsFixed(2)} kg';
        } else
        if (selectedAgeFormat == 'Years' && ageValue > 4 && ageValue <= 14) {
          final expectedWeight = 4 * ageValue;
          result = '${expectedWeight.toStringAsFixed(2)} kg';
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
          _saveAllCalculations(); // Save history after calculation
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
          'EXPECTED WEIGHT FOR AGE',
          style: Theme
              .of(context)
              .textTheme
              .titleMedium,
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
                text: 'Select the age format:\n'
                    '"Months" for age below 1 year\n'
                    '"Years" for age 1 year and above',
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                value: selectedAgeFormat.isEmpty ? null : selectedAgeFormat,
                items: <String>['Months', 'Years'],
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedAgeFormat = value;
                    });
                    widget.onAgeFormatChanged(value);
                  }
                }, hint: 'Select Age Format',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Enter Child's Age",
                controller: ageController,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: _calculateExpectedWeight,
                text: 'Expected Weight',
              ),
              const SizedBox(height: 20),
              if (expectedWeightAge.isNotEmpty)
                ResultContainer(
                  label: "Expected weight for age:",
                  result: expectedWeightAge,
                ),
            ],
          ),
        ),
      ),
    );
  }
}