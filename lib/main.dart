import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'package:health_calc/pages/wfa_page.dart';
import 'package:health_calc/pages/bmi_page.dart';
import 'package:health_calc/pages/dose_weight_page.dart';
import 'package:health_calc/pages/drops_minute_page.dart';
import 'package:health_calc/pages/ga_edd_page.dart';
import 'package:health_calc/pages/nxt_visit_page.dart';

void main() {
  runApp(const HealthCalcApp());
}

class HealthCalcApp extends StatelessWidget {
  const HealthCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Calculators',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(), // Set the homepage here
      routes: {
        '/wfa': (context) => WeightForAgePage(
          selectedAgeFormat: '',
          onAgeFormatChanged: (String? value) {},
          age: '',
          onAgeChanged: (String value) {},
        ),
        '/ga-edd': (context) => const GestationalAgePage(),
        '/next-visit': (context) => NextVisitPage(
          selectedInterval: '',
          onIntervalChanged: (String? value) {},
        ),
        '/bmi': (context) => BMICalculationPage(
          selectedUnit: '',
          onUnitChanged: (String? value) {},
          heightController: TextEditingController(),
          weightController: TextEditingController(),
          bmiResult: '',
        ),
        '/dose-weight': (context) => DosePerWeightPage(
          weightController: TextEditingController(),
          dosageController: TextEditingController(),
          dosePerWeightResult: '',
        ),
        '/drops-minute': (context) => DropsPerMinutePage(
          selectedDropFactor: '',
          onDropFactorChanged: (String? value) {},
          volumeController: TextEditingController(),
          dropsPerMinuteResult: '',
        ),
      },
    );
  }
}