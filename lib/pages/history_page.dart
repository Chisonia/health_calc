import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../widget_box/calculatePageTitle.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key, required this.calculationHistory})
      : super(key: key);

  final List<Map<String, dynamic>> calculationHistory;

  @override
  HistoryPageState createState() => HistoryPageState();
}

class HistoryPageState extends State<HistoryPage> {
  List<Map<String, dynamic>> _calculationHistory = [];
  final String _historyKey = 'calculationHistory';

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  // Load history from shared preferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_historyKey);
    if (encodedData != null) {
      setState(() {
        _calculationHistory =
        List<Map<String, dynamic>>.from(jsonDecode(encodedData));
      });
    } else {
      // If no history in SharedPreferences, use the passed-in calculationHistory
      _calculationHistory = widget.calculationHistory;
    }
  }

  // Clear the history from shared preferences and update the UI
  Future<void> _clearHistory() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_historyKey);
    setState(() {
      _calculationHistory = [];
    });
  }

  // Get the icon path based on calculation type
  String _getIconPath(String calculationType) {
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 600; // Adjust for smaller devices

    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
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
      body: _calculationHistory.isNotEmpty
          ? ListView.builder(
        itemCount: _calculationHistory.length,
        itemBuilder: (context, index) {
          final calculation = _calculationHistory[index];
          final iconPath = _getIconPath(calculation['type']);
          final formattedTime = DateTime.parse(calculation['time']).toLocal()
              .toString()
              .split('.')[0];

          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: isSmallScreen ? 8.0 : 16.0, vertical: 4.0),
            child: ListTile(
              leading: SizedBox(
                width: isSmallScreen ? 20 : 32,
                height: isSmallScreen ? 20 : 32,
                child: Image.asset(iconPath),
              ),
              title: Text(
                calculation['type'],
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: isSmallScreen ? 16:20,
                ),
              ),
              subtitle: Text(
                calculation['result'],
                style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: isSmallScreen ? 12 : 16),
              ),
              trailing: Text(
                formattedTime,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                  fontSize: isSmallScreen
                      ? 8
                      : Theme.of(context).textTheme.bodySmall?.fontSize,
                ),
              ),
            ),
          );
        },
      )
          : Center(
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16.0 : 32.0),
          child: Text(
            'No history available',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: isSmallScreen
                    ? 14
                    : Theme.of(context).textTheme.bodySmall?.fontSize,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}