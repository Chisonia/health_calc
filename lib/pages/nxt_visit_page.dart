import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  @override
  void initState() {
    super.initState();
    selectedInterval = widget.selectedInterval.isEmpty ? '' : widget.selectedInterval;
  }

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: const Text(
          'CALCULATE NEXT VISIT DATE',
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
            const SizedBox(height: 36),
            const Text(
              "Select the desired interval for the next appointment",
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
                value: selectedInterval.isEmpty ? null : selectedInterval,
                hint: const Text("Select interval"),
                icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.deepPurple
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
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
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 36),
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
                  appointmentDate,
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