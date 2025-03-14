import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme_provider.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/customTextfield.dart';
import '../widget_box/infoText.dart';
import '../widget_box/resultContainer.dart';

class DropsPerMinutePage extends StatefulWidget {
  const DropsPerMinutePage({Key? key}) : super(key: key);

  @override
  DropsPerMinutePageState createState() => DropsPerMinutePageState();
}

class DropsPerMinutePageState extends State<DropsPerMinutePage> {
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  String? selectedDropFactor;
  String dropsPerMinuteResult = '';
  String dropsPer15SecondsResult = '';
  List<Map<String, dynamic>> calculationHistory = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  @override
  void dispose() {
    volumeController.dispose();
    durationController.dispose();
    super.dispose();
  }

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

  Future<void> _saveAllCalculations() async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(calculationHistory);
    await prefs.setString('calculationHistory', encodedData);
  }

  void _calculateDropsPerMinute() {
    if (volumeController.text.isEmpty ||
        durationController.text.isEmpty ||
        selectedDropFactor == null) {
      setState(() {
        dropsPerMinuteResult = "Please fill all fields.";
        dropsPer15SecondsResult = "";
      });
      return;
    }

    try {
      final double dropFactor = double.parse(selectedDropFactor!);
      final double volume = double.parse(volumeController.text);
      final double durationInHours = double.parse(durationController.text);
      final double durationInMinutes = durationInHours * 60.0;

      final double dropsPerMinute = (volume * dropFactor) / durationInMinutes;
      final double dropsPer15Seconds = dropsPerMinute / 4;

      setState(() {
        dropsPerMinuteResult = dropsPerMinute.toStringAsFixed(0);
        dropsPer15SecondsResult = dropsPer15Seconds.toStringAsFixed(0);
        _addCalculationToHistory(
            dropsPerMinute.toStringAsFixed(0),
            dropsPer15Seconds.toStringAsFixed(0),
            volume,
            durationInHours,
            dropFactor);
      });
    } catch (e) {
      setState(() {
        dropsPerMinuteResult = "Error in calculation. Check inputs.";
        dropsPer15SecondsResult = "";
      });
    }
  }

  void _addCalculationToHistory(
      String dropsPerMinute,
      String dropsPer15Seconds,
      double volume,
      double durationInHours,
      double dropFactor) {
    Map<String, dynamic> calculation = {
      'type': 'Drops Per Minute Calculation',
      'result': 'Drops/Min: $dropsPerMinute, Drop(s)/15 Seconds: $dropsPer15Seconds',
      'time': DateTime.now().toString(),
      'volume': volume,
      'duration': durationInHours,
      'dropFactor': dropFactor,
    };
    calculationHistory.add(calculation);
    _saveAllCalculations();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: 'FLUID DROPS/MINUTE',
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
                text: "Select the drop factor and enter "
                    "the volume and duration:",
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                value: selectedDropFactor,
                hint: "Select Drop Factor",
                items: const <String>['10', '15', '20', '60'],
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDropFactor = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Enter Volume (ml)",
                controller: volumeController,
              ),
              const SizedBox(height: 20),
              CustomTextField(
                label: "Enter Duration (hours)",
                controller: durationController,
              ),
              const SizedBox(height: 20),
              CustomElevatedButton(
                onPressed: _calculateDropsPerMinute,
                text: 'Calculate Drops/Min',
              ),
              const SizedBox(height: 20),
              if (dropsPerMinuteResult.isNotEmpty)
                ResultContainer(
                  label: "Drops/Minute:",
                  result: dropsPerMinuteResult,
                ),
              const SizedBox(height: 20),
              if (dropsPer15SecondsResult.isNotEmpty)
                ResultContainer(
                  label: "Drop(s)/15 Seconds:",
                  result: dropsPer15SecondsResult,
                ),
            ],
          ),
        ),
      ),
    );
  }
}