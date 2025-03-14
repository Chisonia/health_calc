import 'package:flutter/material.dart';
import 'dart:async';
import 'home_page.dart'; // Replace with the actual import path

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    // Simulate some initialization work (e.g., loading data)
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
          const HomePage(calculationHistory: []),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child,);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.purple.shade100,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/icons/health_calc_logo.png', // Replace with the app's logo asset
              width: screenWidth * 0.25, // Adjust based on screen size
              height: screenWidth * 0.25,
            ),
            SizedBox(height: screenHeight * 0.03),
            Text(
              'Health Calculators',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: screenWidth * 0.06),
            ),
            SizedBox(height: screenHeight * 0.015),
            Text(
              'Quick, Reliable Health Calculations',
              style: Theme.of(context)
                  .textTheme
                  .labelMedium
                  ?.copyWith(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.05),
            const CircularProgressIndicator(
              color: Colors.deepPurple, // Matches the theme
            ),
          ],
        ),
      ),
    );
  }
}