import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static const String _fontFamily = "Merriweather";

  ThemeData get themeData {
    return _isDarkTheme ? _darkTheme : _lightTheme;
  }

  // Dark Theme
  ThemeData get _darkTheme {
    final base = ThemeData.dark();
    return base.copyWith(
      appBarTheme: const AppBarTheme(
        color: Colors.lightBlueAccent,
      ),
      scaffoldBackgroundColor: Colors.grey[900],
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme:
        IconThemeData(color: Colors.lightBlueAccent[400]),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
      ),
      textTheme: _buildDarkTextTheme(base.textTheme),
    );
  }

  // Light Theme
  ThemeData get _lightTheme {
    final base = ThemeData.light();
    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[50],
      ),
      scaffoldBackgroundColor: Colors.grey[100],
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: Colors.deepPurple[800]),
        unselectedIconTheme: IconThemeData(color: Colors.grey[800]),
      ),
      textTheme: _buildLightTextTheme(base.textTheme),
    );
  }

  // Dark Text Theme
  TextTheme _buildDarkTextTheme(TextTheme base) {
    return base.copyWith(
      bodyLarge: base.bodyLarge?.copyWith(
        color: Colors.lightBlueAccent[50],
        fontSize: 24,
        fontFamily: "$_fontFamily-Regular",
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: Colors.lightBlueAccent[50],
        fontSize: 16,
        fontFamily: "$_fontFamily-Regular",
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: Colors.lightBlueAccent[50],
        fontSize: 12,
        fontFamily: "$_fontFamily-Regular",
      ),
      displayLarge: base.displayLarge?.copyWith(
        color: Colors.lightBlueAccent[100],
        fontSize: 24,
        fontFamily: "$_fontFamily-Bold",
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: Colors.lightBlueAccent[50],
        fontSize: 16,
        fontFamily: "$_fontFamily-Bold",
      ),
      displaySmall: base.displaySmall?.copyWith(
        color: Colors.white,
        fontSize: 12,
        fontFamily: "$_fontFamily-Bold",
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: Colors.lightBlueAccent[400],
        fontSize: 16,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: Colors.lightBlueAccent[400],
        fontSize: 16,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: Colors.lightBlueAccent[400],
        fontSize: 12,
        fontFamily: "$_fontFamily-Bold",
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: Colors.black87,
        fontSize: 24,
        fontFamily: "$_fontFamily-Bold",
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: Colors.black87,
        fontSize: 12,
        fontFamily: "$_fontFamily-Bold",
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: Colors.black54,
        fontSize: 24,
        fontFamily: "$_fontFamily-Light",
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: Colors.lightBlueAccent[400],
        fontSize: 16,
        fontFamily: "$_fontFamily-Light",
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: Colors.black54,
        fontSize: 12,
        fontFamily: "$_fontFamily-Light",
      ),
    );
  }

  // Light Text Theme
  TextTheme _buildLightTextTheme(TextTheme base) {
    return base.copyWith(
      bodyLarge: base.bodyLarge?.copyWith(
        color: Colors.black87,
        fontSize: 24,
        fontFamily: "$_fontFamily-Regular",
      ),
      bodyMedium: base.bodyMedium?.copyWith(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: "$_fontFamily-Regular",
      ),
      bodySmall: base.bodySmall?.copyWith(
        color: Colors.black87,
        fontSize: 12,
        fontFamily: "$_fontFamily-Regular",
      ),
      displayLarge: base.displayLarge?.copyWith(
        color: Colors.black87,
        fontSize: 24,
        fontFamily: "$_fontFamily-BlackItalic",
      ),
      displayMedium: base.displayMedium?.copyWith(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: "$_fontFamily-BlackItalic",
      ),
      displaySmall: base.displaySmall?.copyWith(
        color: Colors.deepPurple,
        fontSize: 12,
        fontFamily: "$_fontFamily-BlackItalic",
      ),
      headlineLarge: base.headlineLarge?.copyWith(
        color: Colors.deepPurple,
        fontSize: 16,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: base.headlineMedium?.copyWith(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: base.headlineSmall?.copyWith(
        color: Colors.black87,
        fontSize: 12,
        fontFamily: "$_fontFamily-Bold",
      ),
      titleLarge: base.titleLarge?.copyWith(
        color: Colors.black87,
        fontSize: 24,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      titleMedium: base.titleMedium?.copyWith(
        color: Colors.black87,
        fontSize: 16,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      titleSmall: base.titleSmall?.copyWith(
        color: Colors.black87,
        fontSize: 12,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
      labelLarge: base.labelLarge?.copyWith(
        color: Colors.black54,
        fontSize: 24,
        fontFamily: "$_fontFamily-Light",
      ),
      labelMedium: base.labelMedium?.copyWith(
        color: Colors.black54,
        fontSize: 16,
        fontFamily: "$_fontFamily-Light",
      ),
      labelSmall: base.labelSmall?.copyWith(
        color: Colors.deepPurple,
        fontSize: 12,
        fontFamily: "$_fontFamily-Bold",
        fontWeight: FontWeight.bold,
      ),
    );
  }
}