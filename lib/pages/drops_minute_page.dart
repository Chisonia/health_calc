import 'package:flutter/material.dart';

class DropsPerMinutePage extends StatelessWidget {
  final String selectedDropFactor;
  final ValueChanged<String?> onDropFactorChanged;
  final TextEditingController volumeController;
  final String dropsPerMinuteResult;

  const DropsPerMinutePage({
    super.key,
    required this.selectedDropFactor,
    required this.onDropFactorChanged,
    required this.volumeController,
    required this.dropsPerMinuteResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple.shade100,
        title: const Text(
          'CALCULATE DROPS PER MINUTE',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16.0,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            const Text(
              "Choose drip type and enter volume to calculate drops per minute:",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedDropFactor.isNotEmpty ? selectedDropFactor : null, // No default value
                hint: const Text("Select drip drop"), // Custom hint
                icon: const Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: Colors.deepPurple
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: onDropFactorChanged,
                items: <String>['15', '20', '60']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: volumeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Volume (ml)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.deepOrangeAccent.shade100,
                borderRadius: BorderRadius.circular(24.0),
                border: Border.all(
                  color: Colors.deepPurple,
                  width: 2.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Text(
                  dropsPerMinuteResult.isEmpty
                      ? "Drops per Minute will appear here."
                      : "Drops per Minute: $dropsPerMinuteResult",
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}