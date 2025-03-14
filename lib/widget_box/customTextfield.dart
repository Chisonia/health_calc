import 'package:flutter/material.dart';

// Reusable Custom TextField widget
class CustomTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final TextAlign textAlign;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final void Function()? onTap;
  final bool readOnly;
  final int? maxLines;
  final int? maxLength;
  final TextStyle? textStyle;
  final TextStyle? labelStyle;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textAlign = TextAlign.start,
    this.obscureText = false,
    this.validator,
    this.suffixIcon,
    this.onTap,
    this.readOnly = false,
    this.maxLines = 1,
    this.maxLength,
    this.textStyle,
    this.labelStyle,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final double adaptiveBorderRadius = screenWidth * 0.06;
    final double adaptivePadding = screenWidth * 0.04;
    final defaultTextStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: screenWidth * 0.05);
    final defaultLabelStyle = Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: screenWidth * 0.04);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textAlign: textAlign,
      obscureText: obscureText,
      validator: validator,
      onTap: onTap,
      readOnly: readOnly,
      maxLines: maxLines,
      maxLength: maxLength,
      style: textStyle ?? defaultTextStyle,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: labelStyle ?? defaultLabelStyle,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: fillColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[50]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? adaptiveBorderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Colors.deepPurple,
            width: 2.0,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? adaptiveBorderRadius),
          borderSide: BorderSide(
            color: borderColor ?? Colors.deepPurple,
            width: 2.0,
          ),
        ),
        contentPadding: contentPadding ?? EdgeInsets.symmetric(horizontal: adaptivePadding, vertical: adaptivePadding * 0.75),
      ),
    );
  }
}
