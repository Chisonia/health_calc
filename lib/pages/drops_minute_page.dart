import 'package:flutter/material.dart';

class DropsPerMinutePage extends StatefulWidget {
  const DropsPerMinutePage({super.key});

  @override
  DropsPerMinutePageState createState() => DropsPerMinutePageState();
}

class DropsPerMinutePageState extends State<DropsPerMinutePage> {
  String selectedDropFactor = '';
  TextEditingController volumeController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  String dropsPerMinuteResult = '';

  void _calculateDropsPerMinute() {
    if (selectedDropFactor.isNotEmpty &&
        volumeController.text.isNotEmpty &&
        durationController.text.isNotEmpty) {
      try {
        final double dropFactor = double.parse(selectedDropFactor);
        final double volume = double.parse(volumeController.text);
        final double durationInHours = double.parse(durationController.text);

        // Convert hours to minutes
        final double durationInMinutes = durationInHours * 60.0;

        // Calculate drops per minute
        final double dropsPerMinute = (volume * dropFactor) / durationInMinutes;

        setState(() {
          dropsPerMinuteResult = dropsPerMinute.toStringAsFixed(0);
        });
      } catch (e) {
        setState(() {
          dropsPerMinuteResult = "Error in calculation. Check inputs.";
        });
      }
    } else {
      setState(() {
        dropsPerMinuteResult = "Please fill all fields.";
      });
    }
  }

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
              "Choose drip type, enter volume, and duration to calculate drops per minute:",
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
                value: selectedDropFactor.isNotEmpty ? selectedDropFactor : null,
                hint: const Text("Select drip drop"),
                icon: const Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: Colors.deepPurple,
                ),
                elevation: 16,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedDropFactor = newValue!;
                    dropsPerMinuteResult = ''; // Clear result when changing drop factor
                    _calculateDropsPerMinute();
                  });
                },
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
              onChanged: (value) {
                _calculateDropsPerMinute();
              },
            ),
            const SizedBox(height: 24),
            TextField(
              controller: durationController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Duration (hours)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.0),
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    width: 2.0,
                  ),
                ),
              ),
              onChanged: (value) {
                _calculateDropsPerMinute();
              },
            ),
            const SizedBox(height: 24),
            Container(
              height: 60.0,
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.shade100,
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