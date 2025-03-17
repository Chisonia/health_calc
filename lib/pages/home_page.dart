import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:health_calc/pages/profile_page.dart';
import '../widget_box/cal_button.dart';
import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required List calculationHistory}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _calculationHistory = [];
  final String _historyKey = 'calculationHistory';

  @override
  void initState() {
    super.initState();
    _loadHistory(); // Load history from SharedPreferences
  }

  Future<void> _loadHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final String? historyJson = prefs.getString(_historyKey);

    if (historyJson != null) {
      setState(() {
        _calculationHistory =
        List<Map<String, dynamic>>.from(jsonDecode(historyJson));
      });
    }
  }

  Future<void> _saveHistory() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('calculationHistory', json.encode(_calculationHistory));
  }

  void _addCalculation(Map<String, String> result) {
    setState(() async {
      _calculationHistory.add(result);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('calculationHistory', jsonEncode(_calculationHistory));
    });
    _saveHistory(); // Save history after update
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomeContent(),
      HistoryPage(calculationHistory: _calculationHistory),
      const ProfilePage(),
    ];
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/icons/health_calc_logo.png', width: screenWidth * 0.15),
          ],
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/predict-diabetes');
        },
        child: Image.asset("assets/icons/diabetes.png", width: screenWidth * 0.15),
      ),
    );
  }

  Widget _buildHomeContent() {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 4 : 3;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'WELCOME',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: screenWidth * 0.05),
            ),
            const SizedBox(height: 16),
            Text(
              'Click On The Icons Below To Quickly Perform Your Desired Calculation.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: screenWidth * 0.04),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                _buildCalculationButton("BMI", "assets/icons/bmi.png", '/bmi'),
                _buildCalculationButton("WFA", "assets/icons/child.png", '/wfa'),
                _buildCalculationButton("GA/EDD", "assets/icons/pregnant.png", '/ga-edd'),
                _buildCalculationButton("Next Visit", "assets/icons/calendar.png", '/next-visit'),
                _buildCalculationButton("Dose/Weight", "assets/icons/syringe.png", '/dose-weight'),
                _buildCalculationButton("Drops/Minute", "assets/icons/drip.png", '/drops-minute'),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'RECENT CALCULATIONS',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: screenWidth * 0.05),
            ),
            _calculationHistory.isEmpty
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _calculationHistory.length < 4 ? _calculationHistory.length : 4,
              itemBuilder: (context, index) {
                final entry = _calculationHistory[_calculationHistory.length - 1 - index];
                String iconPath = getIconPath(entry['type']!);
                return ListTile(
                  leading: Image.asset(iconPath, width: 24, height: 24),
                  title: Text(entry['type']!, style: Theme.of(context).textTheme.headlineMedium),
                  subtitle: Text(entry['result']!, style: Theme.of(context).textTheme.bodySmall),
                  trailing: Text(
                    DateTime.parse(entry['time']!).toLocal().toString().split('.')[0],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculationButton(String title, String assetIconPath, String routeName) {
    return CustomCalculationButton(
      title: title,
      assetIconPath: assetIconPath,
      onPressed: () async {
        final result = await Navigator.pushNamed(context, routeName);
        if (result != null && result is Map<String, String>) {
          _addCalculation(result);
        }
      },
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
        return 'assets/icons/health_calc_logo.png';
    }
  }
}