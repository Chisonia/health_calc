import 'package:flutter/material.dart';
import 'package:health_calc/pages/wfa_page.dart';
import '../widget_box/cal_button.dart';
import 'bmi_page.dart';
import 'dose_weight_page.dart';
import 'drops_minute_page.dart';
import 'ga_edd_page.dart';
import 'nxt_visit_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/icons/health_calc_logo.png'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'WELCOME',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Click On The Icons Below To Quickly Perform Your'
                  ' Desired Calculation.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 240, // Set a fixed height for the grid
              child: GridView.count(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  buildCalculationButton(
                    'Weight 4 Age',
                    'assets/icons/child.png',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeightForAgePage(
                            selectedAgeFormat: '',
                            onAgeFormatChanged: (String? value) {},
                            age: '',
                            onAgeChanged: (String value) {},
                          ),
                        ),
                      );
                    },
                  ),
                  buildCalculationButton(
                    'GA/EDD',
                    'assets/icons/pregnant.png',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const GestationalAgePage(),
                        ),
                      );
                    },
                  ),
                  buildCalculationButton(
                    'Next Visit',
                    'assets/icons/calendar.png',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NextVisitPage(
                            selectedInterval: '',
                            onIntervalChanged: (String? value) {},
                          ),
                        ),
                      );
                    },
                  ),
                  buildCalculationButton(
                    'BMI',
                    'assets/icons/bmi.png',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BMICalculationPage(
                            selectedUnit: '',
                            onUnitChanged: (String? value) {},
                            heightController: TextEditingController(),
                            weightController: TextEditingController(),
                            bmiResult: '',
                          ),
                        ),
                      );
                    },
                  ),
                  buildCalculationButton(
                    'Dose/Weight',
                    'assets/icons/syringe.png',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DosePerWeightPage(),
                        ),
                      );
                    },
                  ),
                  buildCalculationButton(
                    'Drops/Minute',
                    'assets/icons/drip.png',
                        () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DropsPerMinutePage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // Add some spacing before the text
            const Text(
              'RECENT CALCULATIONS',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            // Here you could add a list or grid to display recent calculations
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
