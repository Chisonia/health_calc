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
  String expectedWeightAge = 'Expected Weight Range will appear here.'; // default text

  @override
  void initState() {
    super.initState();
    selectedAgeFormat = widget.selectedAgeFormat.isEmpty ? '' : widget.selectedAgeFormat;
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
        } else if (selectedAgeFormat == 'Years' && ageValue > 0 && ageValue <= 4 ) {
          // For children 1 year to 4 years
          final expectedWeight = 2 * (ageValue + 5);
          setState(() {
            expectedWeightAge = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
          });
        } else if(selectedAgeFormat == 'Years' && ageValue > 4 && ageValue <= 14 ){
          // For children 5 year to 14 years
          final expectedWeight = 4 * ageValue;
          setState(() {
            expectedWeightAge = 'Expected Weight: ${expectedWeight.toStringAsFixed(2)} kg';
          });

        }else {
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
                    text: "'Years' for 1 year to 14 years.",
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
                value: selectedAgeFormat.isEmpty ? null : selectedAgeFormat,
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.deepPurple,
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                hint: const Text(
                  "Select Age Format",
                  style: TextStyle(color: Colors.black54),
                ),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedAgeFormat = value;
                      // Recalculate expected weight with the current age
                      _calculateExpectedWeight(widget.age);
                    });
                    widget.onAgeFormatChanged(value);
                  }
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
                  onChanged: (value) {
                    widget.onAgeChanged(value);
                    _calculateExpectedWeight(value); // Calculate weight when age is changed
                  },
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
                  expectedWeightAge,
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