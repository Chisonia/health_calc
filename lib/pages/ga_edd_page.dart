import 'package:flutter/material.dart';

class GestationalAgePage extends StatelessWidget {
  final String selectedOption;
  final ValueChanged<String?> onOptionChanged;
  final String selectedDate;
  final ValueChanged<String> onSelectDate; // Change to ValueChanged for selected date
  final String gestationalAge;
  final String expectedDeliveryDate;

  const GestationalAgePage({
    super.key,
    required this.selectedOption,
    required this.onOptionChanged,
    required this.selectedDate,
    required this.onSelectDate,
    required this.gestationalAge,
    required this.expectedDeliveryDate,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      onSelectDate(picked.toLocal().toString().split(' ')[0]); // Update to handle date string
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
                value: selectedOption.isNotEmpty ? selectedOption : null,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.deepPurple),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: onOptionChanged,
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
              onTap: () => _selectDate(context), // Update to call the date picker
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