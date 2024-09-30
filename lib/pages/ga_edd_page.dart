import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        title: Text(
          'CALCULATE GESTATIONAL AGE AND EDD',
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
              "Select how to calculate GA and EDD.",
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
                value: selectedOption.isEmpty ? null : selectedOption,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.deepPurple),
                elevation: 16,
                style: Theme.of(context).textTheme.headlineMedium,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedOption = newValue!;
                  });
                },
                hint: Text(
                  "Select Format",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                items: <String>['Weeks', 'Months']
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
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: Container(
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
                      controller: dateController,
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        labelStyle: Theme.of(context).textTheme.labelMedium,
                        border: InputBorder.none,
                      ),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateGestationalAgeAndEDD,  // Calculate GA and EDD on button press
              child: const Text('Calculate GA and EDD'),
            ),
            const SizedBox(height: 24),
            if (gestationalAge.isNotEmpty)
              Center(
                child: Text(
                  "Gestational Age: $gestationalAge",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            const SizedBox(height: 24),
            if (expectedDeliveryDate.isNotEmpty)
              Center(
                child: Text(
                  "Expected Delivery Date: $expectedDeliveryDate",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}