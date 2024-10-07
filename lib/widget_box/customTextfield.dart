import 'package:flutter/material.dart';

// Reusable Custom TextField widget
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextAlign textAlign;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[50],
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.deepPurple,
          width: 2.0,
        ),
      ),
      child: TextField(
        controller: controller,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: Theme.of(context).textTheme.labelMedium,
          border: InputBorder.none,
        ),
        style: Theme.of(context).textTheme.headlineMedium,
        textAlign: textAlign,
      ),
    );
  }
}