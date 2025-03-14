import 'package:flutter/material.dart';

// Custom widget for displaying result containers
class ResultContainer extends StatelessWidget {
  final String label;
  final String result;
  final TextStyle? labelStyle;
  final TextStyle? resultStyle;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;
  final double? fontSize; // Add fontSize as an optional parameter

  const ResultContainer({
    Key? key,
    required this.label,
    required this.result,
    this.labelStyle,
    this.resultStyle,
    this.padding,
    this.fontSize, // Initialize fontSize
    this.mainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double adaptivePadding = screenWidth * 0.02;
    final double adaptiveFontSize = screenWidth * 0.045;

    final defaultLabelStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: adaptiveFontSize);
    final defaultResultStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: adaptiveFontSize);

    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: adaptivePadding),
      child: Row(
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            "$label ",
            style: labelStyle ?? defaultLabelStyle,
          ),
          Text(
            result,
            style: resultStyle ?? defaultResultStyle,
          ),
        ],
      ),
    );
  }
}
