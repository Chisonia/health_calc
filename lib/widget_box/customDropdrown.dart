import 'package:flutter/material.dart';

// Reusable Custom Dropdown widget
class CustomDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  const CustomDropdown({
    Key? key,
    required this.value,
    required this.hint,
    required this.items,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.black54 : Colors.grey[50],
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(
          color: Colors.deepPurple,
          width: 2.0,
        ),
      ),
      child: DropdownButton<String>(
        isExpanded: true,
        value: value,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined, color: Colors.deepPurple),
        elevation: 16,
        style: Theme.of(context).textTheme.headlineMedium,
        onChanged: onChanged,
        hint: Text(
          hint,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          );
        }).toList(),
      ),
    );
  }
}