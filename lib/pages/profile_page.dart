import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent[50],
        elevation: 0, // Removes shadow for a flat appearance
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Expandable settings section
            ExpansionTile(
              title: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.headlineMedium,
              ),
              children: [
                ListTile(
                  title: Text(
                      'Dark Mode',
                      style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: Switch(
                    value: themeProvider.isDarkTheme,
                    onChanged: (value) {
                      themeProvider.toggleTheme(); // Toggle the theme
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                      'Notification Settings',
                      style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to notification settings page
                  },
                ),
                ListTile(
                  title: Text('Privacy Settings',
                      style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to privacy settings page
                  },
                ),
                // Add more settings items as needed
              ],
            ),
            // User information section
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User Information',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Placeholder for user information
            Center(
              child:Text(
                'No User Information Yet',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}