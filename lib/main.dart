import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/wfa_page.dart';
import 'pages/bmi_page.dart';
import 'pages/dose_weight_page.dart';
import 'pages/drops_minute_page.dart';
import 'pages/ga_edd_page.dart';
import 'pages/nxt_visit_page.dart';
import 'pages/predict_diabetes.dart';
import 'theme_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const HealthCalcApp(),
    ),
  );
}

class HealthCalcApp extends StatelessWidget {
  const HealthCalcApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      title: 'Health Calculators',
      theme: themeProvider.themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/home': (context) => const HomePage(calculationHistory: [],), // Removed calculationHistory
        '/wfa': (context) => const WeightForAgePage(), // Removed unnecessary parameters
        '/ga-edd': (context) => const GestationalAgePage(),
        '/next-visit': (context) => const NextVisitPage(), // Removed unnecessary parameters
        '/bmi': (context) => const BMICalculationPage(),
        '/dose-weight': (context) => const DosePerWeightPage(),
        '/drops-minute': (context) => const DropsPerMinutePage(),
        '/predict-diabetes': (context) => PredictDiabetesPage(), // Added const
      },
    );
  }
}