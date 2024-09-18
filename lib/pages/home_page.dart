import 'package:flutter/material.dart';
import 'package:health_calc/pages/wfa_page.dart';
import '../widget_box/cal_button.dart';
import 'bmi_page.dart';
import 'dose_weight_page.dart';
import 'drops_minute_page.dart';
import 'ga_edd_page.dart';
import 'nxt_visit_page.dart';
import 'history_page.dart'; // Import the HistoryPage
import 'profile_page.dart'; // Import the ProfilePage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the selected index
  List<Map<String, dynamic>> calculationHistory = []; // Store calculation history

  // Method to handle bottom navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Method to add calculation results to history
  void _addCalculationToHistory(String type, String result, String iconPath) {
    setState(() {
      calculationHistory.add({
        'type': type,
        'result': result,
        'iconPath': iconPath, // Store the icon path
      });
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
                    final result = await Navigator.push(
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
                    if (result != null) {
                      _addCalculationToHistory('Weight for Age', result['result'], 'assets/icons/child.png');
                    }
                  },
                ),
                buildCalculationButton(
                  'GA/EDD',
                  'assets/icons/pregnant.png',
                      () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const GestationalAgePage(),
                      ),
                    );
                    if (result != null) {
                      _addCalculationToHistory('GA/EDD', result['result'], 'assets/icons/pregnant.png');
                    }
                  },
                ),
                buildCalculationButton(
                  'Next Visit',
                  'assets/icons/calendar.png',
                      () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NextVisitPage(
                          selectedInterval: '',
                          onIntervalChanged: (String? value) {},
                        ),
                      ),
                    );
                    if (result != null) {
                      _addCalculationToHistory('Next Visit', result['result'], 'assets/icons/calendar.png');
                    }
                  },
                ),
                buildCalculationButton(
                  'BMI',
                  'assets/icons/bmi.png',
                      () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BMICalculationPage(),
                      ),
                    );
                    if (result != null) {
                      _addCalculationToHistory('BMI', result['result'], 'assets/icons/bmi.png');
                    }
                  },
                ),
                buildCalculationButton(
                  'Dose/Weight',
                  'assets/icons/syringe.png', // Custom icon path
                      () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DosePerWeightPage(),
                      ),
                    );
                    if (result != null) {
                      _addCalculationToHistory('Dose/Weight', result['result'], 'assets/icons/syringe.png'); // Custom icon path
                    }
                  },
                ),
                buildCalculationButton(
                  'Drops/Minute',
                  'assets/icons/drip.png',
                      () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const DropsPerMinutePage(),
                      ),
                    );
                    if (result != null) {
                      _addCalculationToHistory('Drops/Minute', result['result'], 'assets/icons/drip.png');
                    }
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
                    style: Theme.of(context).textTheme.displayMedium
                )
            )
                : ListView.builder(
              itemCount: calculationHistory.length,
              itemBuilder: (context, index) {
                final entry = calculationHistory[index];
                return ListTile(
                  leading: Image.asset(entry['iconPath'], width: 24, height: 24), // Use Image.asset for custom icons
                  title: Text(
                      entry['type'],
                      style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Text(
                      entry['result'],
                      style: Theme.of(context).textTheme.titleSmall
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
