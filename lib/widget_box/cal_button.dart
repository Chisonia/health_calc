import 'package:flutter/material.dart';

class CustomCalculationButton extends StatelessWidget {
  final String title;
  final String assetIconPath;
  final VoidCallback onPressed;
  final String? heroTag;
  final Color? buttonColor;
  final Color? iconColor;
  final double? iconSize;
  final double? buttonSize;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  const CustomCalculationButton({
    Key? key,
    required this.title,
    required this.assetIconPath,
    required this.onPressed,
    this.heroTag,
    this.buttonColor,
    this.iconColor,
    this.iconSize,
    this.buttonSize,
    this.textStyle,
    this.padding,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get screen width and height
    final screenWidth = MediaQuery.of(context).size.width;


    // Adjust sizes dynamically based on screen width
    double calculatedButtonSize = buttonSize ?? screenWidth * 0.12;
    double calculatedIconSize = iconSize ?? screenWidth * 0.06;
    double calculatedFontSize = screenWidth * 0.04;

    final defaultTextStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: calculatedFontSize,
    );

    return Padding(
      padding: padding ?? EdgeInsets.all(screenWidth * 0.02), // Scaled padding
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          SizedBox(
            width: calculatedButtonSize,
            height: calculatedButtonSize,
            child: FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: buttonColor ?? Colors.deepPurple,
              heroTag: heroTag ?? UniqueKey(), // Ensure unique hero tag
              child: Image.asset(
                alignment: Alignment.center,
                assetIconPath,
                width: calculatedIconSize,
                height: calculatedIconSize,
                color: iconColor,
                fit: BoxFit.contain, // Ensure the image fits well
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: textStyle ?? defaultTextStyle,
          ),
        ],
      ),
    );
  }
}
