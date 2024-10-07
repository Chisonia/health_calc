import 'package:flutter/material.dart';

class CustomInfoTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign textAlign;

  const CustomInfoTextWidget({
    Key? key,
    required this.text,
    this.style,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.bodyMedium,
      textAlign: textAlign,
    );
  }
}
