import 'package:flutter/material.dart';

class WeightForAgePage extends StatelessWidget {
  final String selectedAgeFormat;
  final ValueChanged<String?> onAgeFormatChanged;
  final String age;
  final ValueChanged<String> onAgeChanged;
  final String expectedWeightRange;

  const WeightForAgePage({
    super.key,
    required this.selectedAgeFormat,
    required this.onAgeFormatChanged,
    required this.age,
    required this.onAgeChanged,
    required this.expectedWeightRange,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: const Text(
          'CALCULATE WEIGHT FOR AGE',
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
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Select the age format: \n",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: "'Months' for children under 1 year, \n",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: "'Years' for 1 year and older.",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ],
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
                value: selectedAgeFormat.isNotEmpty ? selectedAgeFormat : null,
                icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.deepPurple
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                hint: const Text(
                  "Select Age Format",
                  style: TextStyle(color: Colors.black54),
                ),
                onChanged: (value){
                },
                items: <String>['Months', 'Years']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
              child: Center(
                child: TextField(
                  onChanged: onAgeChanged,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    hintText: "Enter Child's Age",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
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
                  expectedWeightRange.isNotEmpty
                      ? expectedWeightRange
                      : "Expected Weight Range will appear here.", // Default message
                  style: const TextStyle(
                    color: Colors.black,
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
