import 'package:flutter/material.dart';

// Reusable Custom Dropdown widget
class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;
  final TextStyle? hintStyle;
  final TextStyle? itemStyle;
  final Color? iconColor;
  final Color? fillColor;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Widget? icon;
  final double? elevation;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.hint,
    required this.items,
    this.onChanged,
    this.hintStyle,
    this.itemStyle,
    this.iconColor,
    this.fillColor,
    this.borderColor,
    this.borderRadius,
    this.contentPadding,
    this.icon,
    this.elevation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double adaptiveBorderRadius = borderRadius ?? screenWidth * 0.06;
    final double adaptivePadding = screenWidth * 0.04;
    final double adaptiveFontSize = screenWidth * 0.045;

    final defaultHintStyle = Theme.of(context).textTheme.labelMedium?.copyWith(fontSize: adaptiveFontSize);
    final defaultItemStyle = Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: adaptiveFontSize);

    return Container(
      decoration: BoxDecoration(
        color: fillColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[50]),
        borderRadius: BorderRadius.circular(adaptiveBorderRadius),
        border: Border.all(
          color: borderColor ?? Colors.deepPurple,
          width: 2.0,
        ),
      ),
      child: Padding(
        padding: contentPadding ?? EdgeInsets.symmetric(horizontal: adaptivePadding),
        child: DropdownButton<String>(
          isExpanded: true,
          value: value,
          icon: icon ?? Icon(Icons.arrow_drop_down_circle_outlined, color: iconColor ?? Colors.deepPurple),
          elevation: elevation?.toInt() ?? 16,
          style: itemStyle ?? defaultItemStyle,
          onChanged: onChanged,
          underline: const SizedBox(),
          hint: Text(
            hint,
            style: hintStyle ?? defaultHintStyle,
          ),
          items: items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: itemStyle ?? defaultItemStyle,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
