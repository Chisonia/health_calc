import 'package:flutter/material.dart';

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

  void _selectOption(String? option) {
    if (option != null) {
      setState(() {
        selectedOption = option;
        _calculateGestationalAgeAndEDD(); // Recalculate when option changes
      });
    }
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
        _calculateGestationalAgeAndEDD(); // Recalculate when date changes
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: const Text(
          'CALCULATE GESTATIONAL AGE AND EDD',
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
              "Select how to calculate GA and EDD.",
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
                value: selectedOption.isEmpty ? null : selectedOption,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.deepPurple),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: _selectOption,
                hint: const Text(
                  "Select Format",
                  style: TextStyle(color: Colors.black54),
                ),
                items: <String>['Weeks', 'Months']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => _selectDate(context),
              child: Container(
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    selectedDate.isEmpty ? "Select Date" : selectedDate,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  gestationalAge.isNotEmpty
                      ? "Gestational Age is $gestationalAge"
                      : "Gestational Age will appear here",
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
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
                  expectedDeliveryDate.isNotEmpty
                      ? "Expected Delivery Date is $expectedDeliveryDate"
                      : "Expected Delivery Date will appear here.",
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