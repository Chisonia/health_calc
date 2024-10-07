import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/customTextfield.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';

class GestationalAgePage extends StatefulWidget {
  const GestationalAgePage({super.key});

  @override
  GestationalAgePageState createState() => GestationalAgePageState();
}

class GestationalAgePageState extends State<GestationalAgePage> {
  String selectedOption = '';
  String selectedDate = '';
  String gestationalAge = '';
  String expectedDeliveryDate = '';

  final TextEditingController dateController = TextEditingController();
  List<Map<String, dynamic>> calculationHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Load previous calculations from SharedPreferences
  }

  // Load history from SharedPreferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('calculationHistory');
    if (encodedData != null) {
      setState(() {
        calculationHistory = List<Map<String, dynamic>>.from(jsonDecode(encodedData));
      });
    }
  }

  // Save all calculations to SharedPreferences
  Future<void> _saveAllCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(calculationHistory);
    await prefs.setString('calculationHistory', encodedData);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked.toLocal().toString().split(' ')[0];
        dateController.text = selectedDate;
      });
    }
  }

  void _calculateGestationalAgeAndEDD() {
    if (selectedDate.isNotEmpty && selectedOption.isNotEmpty) {
      DateTime date = DateTime.parse(selectedDate);
      DateTime now = DateTime.now();

      int daysDifference = now.difference(date).inDays;

      if (selectedOption == 'Weeks') {
        int weeks = (daysDifference ~/ 7);
        int days = daysDifference % 7;
        setState(() {
          gestationalAge = "$weeks weeks and $days days";
          expectedDeliveryDate = date.add(const Duration(days: 280)).toString().split(' ')[0];
        });
      } else if (selectedOption == 'Months') {
        int months = daysDifference ~/ 30;
        int days = daysDifference % 30;
        setState(() {
          gestationalAge = "$months months and $days days";
          expectedDeliveryDate = date.add(const Duration(days: 280)).toString().split(' ')[0];
        });
      }

      // Save the result to history
      Map<String, dynamic> calculation = {
        'type': 'Gestational Age Calculation',
        'result': 'GA: $gestationalAge, EDD: $expectedDeliveryDate',
        'time': DateTime.now().toString(),
      };

      calculationHistory.add(calculation);
      _saveAllCalculations();  // Save history
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          text: 'GESTATIONAL AGE/EDD',
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
                  text:'Select "Weeks" or "Months" to Calculate'
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                value: selectedOption.isEmpty ? null : selectedOption,
                hint: "Select Format",
                items: <String>['Weeks', 'Months'],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                      controller: dateController,
                      label: 'Select Date'
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: _calculateGestationalAgeAndEDD,
                text: 'Calculate GA and EDD',
              ),
              const SizedBox(height: 20),
              if (gestationalAge.isNotEmpty)
                ResultContainer(
                  label: "Gestational Age:",
                  result: gestationalAge,
                ),
              const SizedBox(height: 20),
              if (expectedDeliveryDate.isNotEmpty)
                ResultContainer(
                  label: "Expected Delivery Date:",
                  result: expectedDeliveryDate,
                ),
            ],
          ),
        ),
      ),
    );
  }
}