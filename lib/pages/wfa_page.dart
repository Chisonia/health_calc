import 'package:flutter/material.dart';

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
  late TextEditingController ageController; // TextEditingController for the age input
  String expectedWeightAge = 'Expected Weight Range will appear here.'; // default text

  @override
  void initState() {
    super.initState();
    selectedAgeFormat = widget.selectedAgeFormat.isEmpty ? '' : widget.selectedAgeFormat;
    ageController = TextEditingController(); // Initialize the TextEditingController
  }

  @override
  void dispose() {
    ageController.dispose(); // Dispose the controller
    super.dispose();
  }

  void _calculateExpectedWeight(String age) {
    if (age.isNotEmpty) {
      final double? ageValue = double.tryParse(age);
      if (ageValue != null) {
        if (selectedAgeFormat == 'Months' && ageValue < 12) {
          // For children aged 0 to 11 months
          final expectedWeight = (ageValue + 9) / 2;
          setState(() {
            expectedWeightAge = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
          });
        } else if (selectedAgeFormat == 'Years' && ageValue > 0 && ageValue <= 4) {
          // For children 1 year to 4 years
          final expectedWeight = 2 * (ageValue + 5);
          setState(() {
            expectedWeightAge = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
          });
        } else if (selectedAgeFormat == 'Years' && ageValue > 4 && ageValue <= 14) {
          // For children 5 year to 14 years
          final expectedWeight = 4 * ageValue;
          setState(() {
            expectedWeightAge = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
          });
        } else {
          setState(() {
            expectedWeightAge = "Please enter a valid age for the selected format.";
          });
        }
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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Select the age format: \n",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: '"Months" for children under 1 year, \n',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  TextSpan(
                    text: '"Years" for 1 year to 14 years.',
                    style: Theme.of(context).textTheme.bodySmall,
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
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.deepPurple,
                ),
                elevation: 16,
                style: Theme.of(context).textTheme.headlineMedium,
                hint: Text(
                  "Select Age Format",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedAgeFormat = value;
                      // Recalculate expected weight with the current age
                      _calculateExpectedWeight(ageController.text); // Use controller text
                    });
                    widget.onAgeFormatChanged(value);
                  }
                },
                items: <String>['Months', 'Years']
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
                  controller: ageController, // Set the controller
                  onChanged: (value) {
                    widget.onAgeChanged(value);
                    _calculateExpectedWeight(value); // Calculate weight when age is changed
                  },
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    labelText: "Enter Child's Age",
                    labelStyle: Theme.of(context).textTheme.labelMedium,
                    border: InputBorder.none,
                  ),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[200],
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  expectedWeightAge,
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
