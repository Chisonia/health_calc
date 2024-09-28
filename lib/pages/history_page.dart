import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
        title: Text(
          'Calculation History',
          style: Theme.of(context).textTheme.titleMedium,
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
          return ListTile(
            leading: Icon(IconData(calculation['icon'], fontFamily: 'MaterialIcons')),
            title: Text(calculation['type']),
            subtitle: Text(calculation['result']),
            trailing: Text(
              // Formatting the time for better display
              DateTime.parse(calculation['time']).toLocal().toString().split('.')[0],
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
}