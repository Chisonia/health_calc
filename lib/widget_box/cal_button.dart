import 'package:flutter/material.dart';

Widget buildCalculationButton(String title, String assetIconPath, VoidCallback onPressed, {String? heroTag}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      SizedBox(
        width: 48, // Default FAB size
        height: 48,
        child: FloatingActionButton(
          onPressed: onPressed,
          backgroundColor: Colors.deepPurple,
          heroTag: heroTag ?? UniqueKey(), // Ensure unique hero tag
          child: Image.asset(
            alignment: Alignment.center,
            assetIconPath,
            width: 64, // Adjusted icon size to fit within the FAB
            height: 64,
            fit: BoxFit.fill, // Ensure the image fits well
          ),
        ),
      ),
      const SizedBox(height: 16),
      Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 16),
    ],
  );
}

