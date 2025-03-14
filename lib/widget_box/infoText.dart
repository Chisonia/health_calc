import 'package:flutter/material.dart';

class CustomInfoTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double? fontSize;

  const CustomInfoTextWidget({
    Key? key,
    required this.text,
    this.textStyle,
    this.textAlign = TextAlign.center,
    this.padding,
    this.backgroundColor,
    this.fontSize, // Initialize fontSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double adaptivePadding = screenWidth * 0.03;
    final double adaptiveFontSize = screenWidth * 0.04;

    final defaultTextStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
      fontSize: adaptiveFontSize,
      color: Colors.black87, // Default text color
    );

    return Container(
      width: double.infinity, // Take full width
      padding: padding ?? EdgeInsets.all(adaptivePadding),
      color: backgroundColor ?? Colors.grey[200], // Default background color
      child: Text(
        text,
        textAlign: textAlign,
        style: textStyle ?? defaultTextStyle,
      ),
    );
  }
}
