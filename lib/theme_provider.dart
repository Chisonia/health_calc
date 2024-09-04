import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  ThemeData get themeData {
    return _isDarkTheme
        ? ThemeData.dark().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple.shade100,
      ),
      scaffoldBackgroundColor: Colors.grey[850],
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
      ),
    )
        : ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple.shade100,
      ),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.black87),
        bodyMedium: TextStyle(color: Colors.black87),
      ),
    );
  }
}