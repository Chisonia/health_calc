import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_calc/pages/wfa_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_box/cal_button.dart';
import 'bmi_page.dart';
import 'dose_weight_page.dart';
import 'drops_minute_page.dart';
import 'ga_edd_page.dart';
import 'nxt_visit_page.dart';
import 'history_page.dart'; // Import the HistoryPage
import 'profile_page.dart'; // Import the ProfilePage

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.calculationHistory});
  final List<Map<String, dynamic>> calculationHistory;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index
  List<Map<String, dynamic>> calculationHistory = []; // Store calculation history

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Load history on initialization
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

  // Method to handle bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget getBody() {
      switch (_selectedIndex) {
        case 0:
          return _buildHomeBody();
        case 1:
          return HistoryPage(calculationHistory: calculationHistory); // Pass history to HistoryPage
        case 2:
          return const ProfilePage(); // Open Profile Page
        default:
          return Container(); // Fallback for other cases
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/icons/health_calc_logo.png'),
          ],
        ),
      ),
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedLabelStyle: Theme.of(context).textTheme.titleSmall,
        selectedLabelStyle: Theme.of(context).textTheme.labelSmall,
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  // Home body widget
  Widget _buildHomeBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            'WELCOME',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 16),
          Text(
            'Click On The Icons Below To Quickly Perform Your'
                ' Desired Calculation.',
            style: Theme.of(context).textTheme.bodyMedium,
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
                  'assets/icons/syringe.png', // Custom icon path
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
                        )
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 20), // Add some spacing before the text
          Text(
            'RECENT CALCULATIONS',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          // Display recent calculations
          Expanded(
            child: calculationHistory.isEmpty
                ? Center(
              child: Text(
                'No Recent Calculations',
                style: Theme.of(context).textTheme.displayMedium,
              ),
            )
                : ListView.builder(
              itemCount: calculationHistory.length < 4
                  ? calculationHistory.length
                  : 4, // Show only the last 4 entries
              itemBuilder: (context, index) {
                final entry = calculationHistory[
                calculationHistory.length - 1 - index]; // Get the latest first
                // Determine the icon based on the calculation type
                String iconPath = getIconPath(entry['type']);
                return ListTile(
                  leading: SizedBox(
                    width: 24,  // Set desired width
                    height: 24, // Set desired height
                    child: Image.asset(iconPath), // Use the determined icon
                  ),
                  title: Text(
                    entry['type'],
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  subtitle: Text(
                    entry['result'],
                    style: const TextStyle(
                        fontSize: 12
                    ),
                  ),
                  trailing: Text(
                    // Formatting the time for better display
                    DateTime.parse(entry['time']).toLocal().toString().split('.')[0],
                    style: const TextStyle(
                        fontStyle: FontStyle.italic
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

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
        return 'assets/icons/health_calc_logo.png'; // Fallback icon
    }
  }
}
