import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_calc/pages/wfa_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_box/cal_button.dart';// Import calculation button widget
import 'bmi_page.dart';// Import BMICalculationPage for BMI calculation
import 'dose_weight_page.dart';// Import DosePerWeightPage for weight for age calculation
import 'drops_minute_page.dart';// Import DropsPerMinutePage for drops calculation
import 'ga_edd_page.dart'; // Import GestationalAgePage for GA/EDD calculation
import 'nxt_visit_page.dart';// Import NextVisitPage for next visit calculation
import 'history_page.dart'; // Import HistoryPage for calculation history
import 'profile_page.dart'; // Import ProfilePage for user profile

// HomePage Widget: StatefulWidget that displays different pages based on user interaction
class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.calculationHistory});

  // Holds the calculation history passed to this page
  final List<Map<String, dynamic>> calculationHistory;

  @override
  HomePageState createState() => HomePageState();
}

// HomePageState: Manages the state and UI logic for HomePage
class HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Tracks the currently selected bottom navigation index
  List<Map<String, dynamic>> calculationHistory = []; // Stores the calculation history

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Load stored calculation history when the widget is initialized
  }

  // Load calculation history from SharedPreferences
  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString('calculationHistory');

    // If there is saved history, decode and load it; otherwise, use the passed-in history
    setState(() {
      calculationHistory = encodedData != null
          ? List<Map<String, dynamic>>.from(jsonDecode(encodedData))
          : widget.calculationHistory;
    });
  }

  // Handle bottom navigation bar item tap to change the page
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Get the appropriate body based on the selected index
    Widget getBody() {
      switch (_selectedIndex) {
        case 0:
          return _buildHomeBody(); // Home page body
        case 1:
          return HistoryPage(calculationHistory: calculationHistory); // History page
        case 2:
          return const ProfilePage(); // Profile page
        default:
          return Container(); // Fallback to an empty container
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/icons/health_calc_logo.png'), // App logo
          ],
        ),
      ),
      body: getBody(), // Set body based on the selected page
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
        selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home', // Home tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History', // History tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile', // Profile tab
          ),
        ],
        currentIndex: _selectedIndex, // Highlight the current tab
        onTap: _onItemTapped, // Handle navigation item tap
      ),
    );
  }

  // Home page body: displays buttons for different calculations and recent calculation history
  Widget _buildHomeBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WELCOME',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Click On The Icons Below To Quickly Perform Your Desired Calculation.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            // Grid of calculation buttons
            SizedBox(
              height: 240, // Fixed height for the grid
              child: GridView.count(
                crossAxisCount: 3, // 3 columns in the grid
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: [
                  buildCalculationButton(
                    'Weight 4 Age',
                    'assets/icons/child.png',
                        () async {
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
                        () async {
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
                        () async {
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
                        () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BMICalculationPage(),
                        ),
                      );
                    },
                  ),
                  buildCalculationButton(
                    'Dose/Weight',
                    'assets/icons/syringe.png',
                        () async {
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
                        () async {
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
            const SizedBox(height: 16), // Add spacing before recent calculations text
            Text(
              'RECENT CALCULATIONS',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            // Display recent calculations
            calculationHistory.isEmpty
                ? SizedBox(
              height: 240,
              child: Center(
                child: Text(
                  'No Recent Calculations',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
            )
                : ListView.builder(
              shrinkWrap: true, // ListView inside SingleChildScrollView
              physics: const NeverScrollableScrollPhysics(), // Disable scrolling for ListView
              itemCount: calculationHistory.length < 4
                  ? calculationHistory.length
                  : 4, // Show the last 4 entries
              itemBuilder: (context, index) {
                final entry = calculationHistory[
                calculationHistory.length - 1 - index]; // Latest entry first
                String iconPath = getIconPath(entry['type']); // Get appropriate icon
                return ListTile(
                  leading: SizedBox(
                    width: 24,
                    height: 24,
                    child: Image.asset(iconPath), // Display icon based on type
                  ),
                  title: Text(
                    entry['type'], // Display calculation type
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    entry['result'], // Display result
                    style: const TextStyle(fontSize: 12),
                  ),
                  trailing: Text(
                    DateTime.parse(entry['time']).toLocal().toString().split('.')[0], // Format time
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // Get icon path based on calculation type
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
        return 'assets/icons/health_calc_logo.png'; // Fallback icon for unknown types
    }
  }
}