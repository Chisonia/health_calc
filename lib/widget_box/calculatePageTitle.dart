import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double adaptiveFontSize = screenWidth * 0.05; // Adjust font size dynamically

    final defaultTextStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
      fontSize: adaptiveFontSize,
      fontWeight: FontWeight.bold,
    );

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle ?? defaultTextStyle,
    );
  }
}
