import 'package:flutter/material.dart';

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
      appBarTheme: const AppBarTheme(
        color: Colors.lightBlueAccent,
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(color: Colors.lightBlueAccent[400]),
          unselectedIconTheme: const IconThemeData(color: Colors.grey)
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
            color: Colors.lightBlueAccent[50],
            fontSize: 24,
            fontFamily: "assets/fonts/Merriweather-Regular.ttf",
        ),
        bodyMedium: TextStyle(
            color: Colors.lightBlueAccent[50],
            fontSize: 16,
            fontFamily: "assets/fonts/Merriweather-Regular.ttf",
        ),
        bodySmall: TextStyle(
            color: Colors.lightBlueAccent[50],
            fontSize: 12,
            fontFamily: "assets/fonts/Merriweather-Regular.ttf",
        ),
        displayLarge: TextStyle(
            color:Colors.lightBlueAccent[100],
            fontSize: 24,
            fontFamily: "assets/fonts/Merriweather-Bold.ttf",
            ),
        displayMedium: TextStyle(
          color:Colors.lightBlueAccent[50],
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
        ),
        displaySmall: const TextStyle(
          color:Colors.white,
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
        ),
        headlineLarge: TextStyle(
            color:Colors.lightBlueAccent[400],
            fontSize: 24,
            fontFamily: "assets/fonts/Merriweather-Bold.ttf",
            fontWeight: FontWeight.bold
        ),
        headlineMedium: TextStyle(
          color:Colors.lightBlueAccent[400],
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
          fontWeight: FontWeight.bold
        ),
        headlineSmall: TextStyle(
          color:Colors.lightBlueAccent[400],
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
        ),
        titleLarge: const TextStyle(
          color:Colors.black87,
          fontSize: 24,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
        ),
        titleMedium:const TextStyle(
          color:Colors.black87,
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
          fontWeight: FontWeight.bold
        ),
        titleSmall: const TextStyle(
          color:Colors.black87,
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
        ),

        labelLarge: const TextStyle(
          color:Colors.black54,
          fontSize: 24,
          fontFamily: "assets/fonts/Merriweather-Light.ttf",
        ),
        labelMedium: TextStyle(
          color:Colors.lightBlueAccent[400],
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-Light.ttf",
        ),
        labelSmall: const TextStyle(
          color:Colors.black54,
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-Light.ttf",
        ),
      ),
    )
        : ThemeData.light().copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[50],
      ),
      scaffoldBackgroundColor: Colors.grey[100],

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(color: Colors.deepPurple[800]),
          unselectedIconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: Colors.black87,
          fontSize: 24,
          fontFamily: "assets/fonts/Merriweather-Regular.ttf",
        ),
        bodyMedium: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-Regular.ttf",
        ),
        bodySmall: TextStyle(
          color: Colors.black87,
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-Regular.ttf",
        ),
        displayLarge: TextStyle(
          color:Colors.black87,
          fontSize: 24,
          fontFamily: "assets/fonts/Merriweather-BlackItalic.ttf",
        ),
        displayMedium: TextStyle(
          color:Colors.black87,
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-BlackItalic.ttf",
        ),
        displaySmall: TextStyle(
          color:Colors.deepPurple,
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-BlackItalic.ttf",
        ),
        headlineLarge: TextStyle(
          color:Colors.black87,
          fontSize: 24,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
          fontWeight: FontWeight.bold
        ),
        headlineMedium: TextStyle(
          color:Colors.black87,
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
          fontWeight: FontWeight.bold
        ),
        headlineSmall: TextStyle(
          color:Colors.black87,
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
        ),
        titleLarge: TextStyle(
            color:Colors.black87,
            fontSize: 24,
            fontFamily: "assets/fonts/Merriweather-Bold.ttf",
            fontWeight: FontWeight.bold
        ),
        titleMedium: TextStyle(
            color:Colors.black87,
            fontSize: 16,
            fontFamily: "assets/fonts/Merriweather-Bold.ttf",
            fontWeight: FontWeight.bold
        ),
        titleSmall: TextStyle(
            color:Colors.black87,
            fontSize: 12,
            fontFamily: "assets/fonts/Merriweather-Bold.ttf",
            fontWeight: FontWeight.bold
        ),

        labelLarge: TextStyle(
          color:Colors.black54,
          fontSize: 24,
          fontFamily: "assets/fonts/Merriweather-Light.ttf",
        ),
        labelMedium: TextStyle(
          color:Colors.black54,
          fontSize: 16,
          fontFamily: "assets/fonts/Merriweather-Light.ttf",
        ),
        labelSmall: TextStyle(
          color:Colors.deepPurple,
          fontSize: 12,
          fontFamily: "assets/fonts/Merriweather-Bold.ttf",
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}