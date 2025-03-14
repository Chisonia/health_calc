import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  File? _profileImage;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _loadProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _usernameController.text = prefs.getString('username') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      final imagePath = prefs.getString('profileImagePath');
      if (imagePath != null) {
        _profileImage = File(imagePath);
      }
    });
  }

  Future<void> _saveProfileData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', _usernameController.text);
    await prefs.setString('email', _emailController.text);
    if (_profileImage != null) {
      await prefs.setString('profileImagePath', _profileImage!.path);
    }
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved!')),
      );
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _profileImage = File(pickedFile.path);
      }
    });
  }

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final double avatarRadius = screenWidth * 0.15; // Adjust avatar size dynamically
    final double textSize = screenWidth * 0.04; // Adjust text size dynamically
    final double paddingSize = screenWidth * 0.05; // Dynamic padding

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87,
            fontSize: textSize * 0.8,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent[50],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.done : Icons.edit),
            onPressed: () {
              if (_isEditing) {
                _saveProfileData();
              }
              _toggleEditMode();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(paddingSize),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: _isEditing ? _pickImage : null,
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage:
                  _profileImage != null ? FileImage(_profileImage!) : null,
                  child: _profileImage == null
                      ? const Icon(Icons.person, size: 60)
                      : null,
                ),
              ),
            ),
            SizedBox(height: paddingSize),
            TextField(
              controller: _usernameController,
              enabled: _isEditing,
              decoration: const InputDecoration(
                labelText: 'Username',
                border: OutlineInputBorder(),
              ),
              style: TextStyle(fontSize: textSize),
            ),
            SizedBox(height: paddingSize),
            TextField(
              controller: _emailController,
              enabled: _isEditing,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(fontSize: textSize),
            ),
            SizedBox(height: paddingSize),
            ExpansionTile(
              title: Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: textSize),
              ),
              children: [
                ListTile(
                  title: Text(
                    'Dark Mode',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: textSize),
                  ),
                  trailing: Switch(
                    value: themeProvider.isDarkTheme,
                    onChanged: (value) {
                      themeProvider.toggleTheme();
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    'Notification Settings',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: textSize),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to notification settings page
                  },
                ),
                ListTile(
                  title: Text(
                    'Privacy Settings',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: textSize),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    // Navigate to privacy settings page
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
