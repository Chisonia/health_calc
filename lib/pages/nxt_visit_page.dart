import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';
import '../widget_box/customTextField.dart'; // Import your custom widget

// Global variable to hold the latest appointment date summary
String recentAppointmentDate = '';

class NextVisitPage extends StatefulWidget {
  const NextVisitPage({super.key, required String selectedInterval, required Null Function(String? value) onIntervalChanged});

  @override
  NextVisitPageState createState() => NextVisitPageState();
}

class NextVisitPageState extends State<NextVisitPage> {
  String selectedType = ''; // Interval type (days, weeks, etc.)
  String appointmentDate = ''; // Default text for calculated date
  String inputValue = ''; // User input for number of intervals
  List<Map<String, dynamic>> calculationHistory = []; // Calculation history
  // Controller for input field
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHistory();
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

  // Calculate the next appointment date based on the selected type and input value
  void _calculateAppointmentDate() {
    if (_inputController.text.isEmpty || selectedType.isEmpty) return;

    int value = int.tryParse(_inputController.text) ?? 0;
    Duration duration;

    switch (selectedType) {
      case 'Days':
        duration = Duration(days: value);
        break;
      case 'Weeks':
        duration = Duration(days: value * 7);
        break;
      case 'Months':
        duration = Duration(days: value * 30);
        break;
      case 'Years':
        duration = Duration(days: value * 365);
        break;
      default:
        duration = Duration(days: 0);
    }

    DateTime nextAppointment = DateTime.now().add(duration);
    setState(() {
      appointmentDate = DateFormat('EEEE, MMMM d, yyyy').format(nextAppointment);
      recentAppointmentDate = appointmentDate;

      // Add the new appointment calculation to the history
      Map<String, dynamic> calculation = {
        'type': 'Next Visit Calculation',
        'result': appointmentDate,
        'time': DateTime.now().toString(),
      };

      calculationHistory.add(calculation);
      _saveAllCalculations(); // Save updated history
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          text: 'NEXT VISIT DATE',
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
                text: "Select the interval type and enter the duration",
              ),
              const SizedBox(height: 20),

              CustomDropdown(
                value: selectedType.isEmpty ? null : selectedType,
                hint: "Select interval type",
                items: <String>['Days', 'Weeks', 'Months', 'Years'],
                onChanged: (String? value) {
                  setState(() {
                    selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              if (selectedType.isNotEmpty)
                CustomTextField(
                  label: "Enter number of $selectedType",
                  controller: _inputController, // Use the controller here
                  textAlign: TextAlign.start, // Optional alignment
                ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: _calculateAppointmentDate,
                text: 'Next Visit',
              ),
              const SizedBox(height: 20),
              if (appointmentDate.isNotEmpty)
                ResultContainer(
                  label: "Next Visit:",
                  result: appointmentDate,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
