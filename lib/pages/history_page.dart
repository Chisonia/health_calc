import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../widget_box/calculatePageTitle.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key, required this.calculationHistory});

  final List<Map<String, dynamic>> calculationHistory;

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> calculationHistory = [];

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
    } else {
      // If no history in SharedPreferences, use the passed-in calculationHistory
      calculationHistory = widget.calculationHistory;
    }
  }

  // Clear the history from shared preferences and update the UI
  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('calculationHistory');
    setState(() {
      calculationHistory = []; // Update the UI by clearing the list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomTextWidget(
          text: 'CALCULATION HISTORY',
        ),
        actions: [
          TextButton(
            onPressed: _clearHistory,
            child: Text(
              'Clear History',
              style: Theme.of(context).textTheme.displaySmall,
            ),
          ),
        ],
      ),
      body: calculationHistory.isNotEmpty
          ? ListView.builder(
        itemCount: calculationHistory.length,
        itemBuilder: (context, index) {
          final calculation = calculationHistory[index];

          // Determine the icon based on the calculation type
          String iconPath = getIconPath(calculation['type']);

          return ListTile(
            leading: SizedBox(
              width: 24,  // Set desired width
              height: 24, // Set desired height
              child: Image.asset(iconPath), // Use the determined icon
            ),
            title: Text(
                calculation['type'],
          style: Theme.of(context).textTheme.headlineMedium,
            ),
            subtitle: Text(calculation['result']),
            trailing: Text(
              // Formatting the time for better display
              DateTime.parse(calculation['time']).toLocal().toString().split('.')[0],
              style: const TextStyle(
                  fontStyle: FontStyle.italic
              ),
            ),
          );
        },
      )
          : Center(
        child: Text(
          'No history available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }

  String getIconPath(String calculationType) {
    switch (calculationType) {
      case 'BMI Calculation':
        return "assets/icons/bmi.png";
      case 'Gestational Age Calculation':
        return "assets/icons/pregnant.png";
      case 'Drops Per Minute Calculation':
        return 'assets/icons/drip.png';
      case 'Weight for Age Calculation':
        return 'assets/icons/child.png';
      case 'Next Visit Calculation':
        return 'assets/icons/calendar.png';
      case 'Dosage Calculation':
        return 'assets/icons/syringe.png';
      default:
        return 'assets/icons/health_calc_logo.png'; // Fallback icon
    }
  }
}