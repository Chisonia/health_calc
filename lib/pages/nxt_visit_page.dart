import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';
import '../widget_box/customTextField.dart';

class NextVisitPage extends StatefulWidget {
  const NextVisitPage({Key? key}) : super(key: key);

  @override
  NextVisitPageState createState() => NextVisitPageState();
}

class NextVisitPageState extends State<NextVisitPage> {
  String? selectedType; // Interval type (days, weeks, etc.)
  String appointmentDate = ''; // Default text for calculated date
  List<Map<String, dynamic>> calculationHistory = []; // Calculation history
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    _inputController.dispose();
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

  // Calculate the next appointment date based on the selected type and input value
  void _calculateAppointmentDate() {
    if (_inputController.text.isEmpty || selectedType == null) {
      setState(() {
        appointmentDate = "Please select interval type and enter duration.";
      });
      return;
    }

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
        duration = const Duration(days: 0);
    }

    DateTime nextAppointment = DateTime.now().add(duration);
    setState(() {
      appointmentDate = DateFormat('EEEE, MMMM d, yyyy').format(nextAppointment);

      // Add the new appointment calculation to the history
      Map<String, dynamic> calculation = {
        'type': 'Next Visit Calculation',
        'result': appointmentDate,
        'time': DateTime.now().toString(),
        'intervalType': selectedType,
        'intervalValue': value,
      };

      calculationHistory.add(calculation);
      _saveAllCalculations(); // Save updated history
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
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
              const CustomInfoTextWidget(
                text: "Select the interval type and enter the duration",
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                value: selectedType,
                hint: "Select interval type",
                items: const <String>['Days', 'Weeks', 'Months', 'Years'],
                onChanged: (String? value) {
                  setState(() {
                    selectedType = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              if (selectedType != null)
                CustomTextField(
                  label: "Enter number of $selectedType",
                  controller: _inputController,
                  textAlign: TextAlign.start,
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