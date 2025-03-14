import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final TextStyle? textStyle;
  final Color? buttonColor;
  final Color? splashColor;
  final double? elevation;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Widget? child;
  final Size? fixedSize;

  const CustomElevatedButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.textStyle,
    this.buttonColor,
    this.splashColor,
    this.elevation,
    this.borderRadius,
    this.padding,
    this.child,
    this.fixedSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = Theme.of(context).textTheme.headlineLarge?.copyWith(
      color: Colors.white, // Default text color
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: buttonColor ?? Colors.deepPurple, // Default button color
        foregroundColor: splashColor,
        elevation: elevation,
        padding: padding ?? const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0), // Default padding
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 24.0), // Default border radius
        ),
        fixedSize: fixedSize,
      ),
      child: child ?? Text(
        text,
        style: textStyle ?? defaultTextStyle,
      ),
    );
  }
}