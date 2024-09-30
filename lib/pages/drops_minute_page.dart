import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme_provider.dart';

class DropsPerMinutePage extends StatefulWidget {
  const DropsPerMinutePage({super.key});

  @override
  DropsPerMinutePageState createState() => DropsPerMinutePageState();
}

class DropsPerMinutePageState extends State<DropsPerMinutePage> {
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  String selectedDropFactor = '';
  String dropsPerMinuteResult = '';

  List<Map<String, dynamic>> calculationHistory = []; // Keep history in the state

  @override
  void initState() {
    super.initState();
    _loadHistory();  // Load history on initialization
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
  // Save all calculations to SharedPreferences
  Future<void> _saveAllCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(calculationHistory);
    await prefs.setString('calculationHistory', encodedData);
  }

  void _calculateDropsPerMinute() {
    if (volumeController.text.isNotEmpty &&
        durationController.text.isNotEmpty &&
        selectedDropFactor.isNotEmpty) {
      try {
        final double dropFactor = double.parse(selectedDropFactor);
        final double volume = double.parse(volumeController.text);
        final double durationInHours = double.parse(durationController.text);
        final double durationInMinutes = durationInHours * 60.0;

        final double dropsPerMinute = (volume * dropFactor) / durationInMinutes;

        setState(() {
          dropsPerMinuteResult = dropsPerMinute.toStringAsFixed(0);

          // Save the calculation to history only after a valid result
          Map<String, dynamic> calculation = {
            'type': 'Drops Per Minute Calculation',
            'result': 'Drops/Min: $dropsPerMinuteResult',
            'time': DateTime.now().toString(),
          };

          calculationHistory.add(calculation);
          _saveAllCalculations();  // Save history after calculation
        });
      } catch (e) {
        setState(() {
          dropsPerMinuteResult = "Error in calculation. Check inputs.";
        });
      }
    } else {
      setState(() {
        dropsPerMinuteResult = "Please fill all fields.";
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'CALCULATE DROPS PER MINUTE',
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
              "Select the drop factor and enter the volume and duration:",
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
                value: selectedDropFactor.isEmpty ? null : selectedDropFactor,
                icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.deepPurple),
                elevation: 16,
                style: Theme.of(context).textTheme.headlineMedium,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDropFactor = newValue!;
                  });
                },
                hint: Text(
                  "Select Drop Factor",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                items: <String>['10', '15', '20']
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
            buildTextField(
              label: "Enter Volume (ml)",
              controller: volumeController,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            buildTextField(
              label: "Enter Duration (hours)",
              controller: durationController,
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _calculateDropsPerMinute,  // Calculate Drops/Min on button press
              child: const Text('Calculate Drops/Min'),
            ),
            const SizedBox(height: 24),
            if (dropsPerMinuteResult.isNotEmpty)
              Text(
                "$dropsPerMinuteResult Drops/Minute",
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  // Custom text field UI
  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    TextAlign textAlign = TextAlign.start,
  }) {
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