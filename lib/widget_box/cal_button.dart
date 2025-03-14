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
    final defaultTextStyle = Theme.of(context).textTheme.bodySmall?.copyWith(
      fontWeight: FontWeight.bold,
    );

    return Padding(
      padding: padding ?? const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          SizedBox(
            width: buttonSize ?? 48, // Default FAB size
            height: buttonSize ?? 48,
            child: FloatingActionButton(
              onPressed: onPressed,
              backgroundColor: buttonColor ?? Colors.deepPurple,
              heroTag: heroTag ?? UniqueKey(), // Ensure unique hero tag
              child: Image.asset(
                alignment: Alignment.center,
                assetIconPath,
                width: iconSize ?? 32, // Adjusted icon size to fit within the FAB
                height: iconSize ?? 32,
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