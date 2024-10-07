import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final TextStyle? style;

  const CustomTextWidget({
    Key? key,
    required this.text,
    this.style,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style ?? Theme.of(context).textTheme.titleMedium,
    );
  }
}
