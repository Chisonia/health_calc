import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/customTextfield.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';

class GestationalAgePage extends StatefulWidget {
  const GestationalAgePage({Key? key}) : super(key: key);

  @override
  GestationalAgePageState createState() => GestationalAgePageState();
}

class GestationalAgePageState extends State<GestationalAgePage> {
  // State variables
  String? _selectedCalculationFormat; // 'Weeks' or 'Months'
  String? _selectedLastMenstrualPeriodDate;
  String _calculatedGestationalAge = '';
  String _calculatedExpectedDeliveryDate = '';

  // Controllers for text fields
  final TextEditingController _lastMenstrualPeriodDateController =
  TextEditingController();

  // History of calculations
  List<Map<String, dynamic>> _calculationHistory = [];
  final String _historyKey = 'calculationHistory';

  @override
  void initState() {
    super.initState();
    _loadCalculationHistory();
  }

  @override
  void dispose() {
    _lastMenstrualPeriodDateController.dispose();
    super.dispose();
  }

  // Load calculation history from SharedPreferences
  Future<void> _loadCalculationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_historyKey);
    if (encodedData != null) {
      setState(() {
        _calculationHistory =
        List<Map<String, dynamic>>.from(jsonDecode(encodedData));
      });
    }
  }

  // Save calculation history to SharedPreferences
  Future<void> _saveCalculationHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(_calculationHistory);
    await prefs.setString(_historyKey, encodedData);
  }

  // Select date using date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedLastMenstrualPeriodDate =
        picked.toLocal().toString().split(' ')[0];
        _lastMenstrualPeriodDateController.text =
        _selectedLastMenstrualPeriodDate!;
      });
    }
  }

  // Calculate GA and EDD based on last menstrual period
  void _calculateGAAndEDDFromLMP() {
    if (_selectedLastMenstrualPeriodDate == null ||
        _selectedCalculationFormat == null) {
      _showError("Please select a date and format.");
      return;
    }

    final lmpDate = DateTime.parse(_selectedLastMenstrualPeriodDate!);
    final now = DateTime.now();
    final daysDifference = now.difference(lmpDate).inDays;

    if (_selectedCalculationFormat == 'Weeks') {
      final weeks = daysDifference ~/ 7;
      final days = daysDifference % 7;
      setState(() {
        _calculatedGestationalAge = "$weeks weeks and $days days";
        _calculatedExpectedDeliveryDate =
        lmpDate.add(const Duration(days: 280)).toString().split(' ')[0];
      });
    } else if (_selectedCalculationFormat == 'Months') {
      final months = daysDifference ~/ 30;
      final days = daysDifference % 30;
      setState(() {
        _calculatedGestationalAge = "$months months and $days days";
        _calculatedExpectedDeliveryDate =
        lmpDate.add(const Duration(days: 280)).toString().split(' ')[0];
      });
    }
    _addToHistory(_calculatedGestationalAge, _calculatedExpectedDeliveryDate);
  }

  // Add calculation to history
  void _addToHistory(String ga, String edd) {
    final calculation = {
      'type': 'Gestational Age Calculation',
      'result': 'GA: $ga, EDD: $edd',
      'time': DateTime.now().toString(),
    };
    _calculationHistory.add(calculation);
    _saveCalculationHistory();
  }

  // Show error message
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: 'GESTATIONAL AGE/EDD',
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
                  text: 'Select "Weeks" or "Months" to Calculate'),
              const SizedBox(height: 20),
              CustomDropdown(
                value: _selectedCalculationFormat,
                hint: "Select Format",
                items: const <String>['Weeks', 'Months'],
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCalculationFormat = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: CustomTextField(
                    controller: _lastMenstrualPeriodDateController,
                    label: 'Select Date',
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: _calculateGAAndEDDFromLMP,
                text: 'Calculate GA and EDD',
              ),
              const SizedBox(height: 20),
              if (_calculatedGestationalAge.isNotEmpty)
                ResultContainer(
                  label: "Gestational Age:",
                  result: _calculatedGestationalAge,
                ),
              const SizedBox(height: 20),
              if (_calculatedExpectedDeliveryDate.isNotEmpty)
                ResultContainer(
                  label: "Expected Delivery Date:",
                  result: _calculatedExpectedDeliveryDate,
                ),
            ],
          ),
        ),
      ),
    );
  }
}