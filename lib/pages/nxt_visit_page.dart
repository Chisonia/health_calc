import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

// Global variable to hold the latest appointment date summary
String recentAppointmentDate = '';

class NextVisitPage extends StatefulWidget {
  final String selectedInterval;
  final ValueChanged<String?> onIntervalChanged;

  const NextVisitPage({
    super.key,
    required this.selectedInterval,
    required this.onIntervalChanged,
  });

  @override
  NextVisitPageState createState() => NextVisitPageState();
}

class NextVisitPageState extends State<NextVisitPage> {
  late String selectedInterval;
  String appointmentDate = 'Next visit will appear here'; // Default text
  List<Map<String, dynamic>> calculationHistory = []; // Calculation history

  @override
  void initState() {
    super.initState();
    selectedInterval = widget.selectedInterval.isEmpty ? '' : widget.selectedInterval;
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

  // Calculate the next appointment date based on the selected interval
  void _calculateAppointmentDate() {
    Duration duration;
    switch (selectedInterval) {
      case '1 week':
        duration = const Duration(days: 7);
        break;
      case '2 weeks':
        duration = const Duration(days: 14);
        break;
      case '1 month':
        duration = const Duration(days: 30);
        break;
      case '2 months':
        duration = const Duration(days: 60);
        break;
      case '3 months':
        duration = const Duration(days: 90);
        break;
      case '1 year':
        duration = const Duration(days: 365);
        break;
      case '3 years':
        duration = const Duration(days: 1095);
        break;
      case '5 years':
        duration = const Duration(days: 1825);
        break;
      default:
        duration = const Duration(days: 0);
    }

    DateTime nextAppointment = DateTime.now().add(duration);
    setState(() {
      appointmentDate = DateFormat('EEEE, MMMM d, yyyy').format(nextAppointment);
      // Update the global variable with the latest appointment date
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
        title: Text(
          'CALCULATE NEXT VISIT DATE',
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
            const SizedBox(height: 36),
            Text(
              "Select the desired interval for the next appointment",
              style: Theme.of(context).textTheme.bodyMedium,
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
                value: selectedInterval.isEmpty ? null : selectedInterval,
                hint: Text(
                  "Select interval",
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.deepPurple
                ),
                elevation: 16,
                style: Theme.of(context).textTheme.bodyMedium,
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      selectedInterval = value;
                      _calculateAppointmentDate();
                    });
                    widget.onIntervalChanged(value);
                  }
                },
                items: <String>[
                  '1 week', '2 weeks', '1 month', '2 months',
                  '3 months', '1 year', '3 years', '5 years']
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
            const SizedBox(height: 36),
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
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  appointmentDate,
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