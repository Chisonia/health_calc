import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import the provider package
import 'theme_provider.dart'; // Import the ThemeProvider
import 'pages/home_page.dart';
import 'package:health_calc/pages/wfa_page.dart';
import 'package:health_calc/pages/bmi_page.dart';
import 'package:health_calc/pages/dose_weight_page.dart';
import 'package:health_calc/pages/drops_minute_page.dart';
import 'package:health_calc/pages/ga_edd_page.dart';
import 'package:health_calc/pages/nxt_visit_page.dart';

void main() {

  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(), // Provide ThemeProvider
      child: const HealthCalcApp(),
    ),
  );
}

class HealthCalcApp extends StatelessWidget {
  const HealthCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context); // Get the current theme

    return MaterialApp(
      title: 'Health Calculators',
      theme: themeProvider.themeData, // Set the theme based on provider
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
        '/bmi': (context) => const BMICalculationPage(),
        '/dose-weight': (context) => const DosePerWeightPage(),
        '/drops-minute': (context) => const DropsPerMinutePage(),
      },
    );
  }
}
