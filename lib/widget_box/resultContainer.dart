import 'package:flutter/material.dart';

// Custom widget for displaying result containers
class ResultContainer extends StatelessWidget {
  final String label;
  final String result;

  const ResultContainer({
    Key? key,
    required this.label,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "$label $result",
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    );
  }
}