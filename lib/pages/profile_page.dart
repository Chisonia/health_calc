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
        backgroundColor: Colors.white,
        elevation: 0, // Removes shadow for a flat appearance
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Expandable settings section
            ExpansionTile(
              title: const Text('Settings'),
              children: [
                ListTile(
                  title: const Text('Dark Mode'),
                  trailing: Switch(
                    value: themeProvider.isDarkTheme,
                    onChanged: (value) {
                      themeProvider.toggleTheme(); // Toggle the theme
                    },
                  ),
                ),
                ListTile(
                  title: const Text('Notification Settings'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to notification settings page
                  },
                ),
                ListTile(
                  title: const Text('Privacy Settings'),
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
            const Text(
              'User Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            // Placeholder for user information
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Name: John Doe',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: johndoe@example.com',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Phone: +1234567890',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date Joined: January 1, 2023',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}