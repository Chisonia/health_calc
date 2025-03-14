import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widget_box/calculateButton.dart';
import '../widget_box/calculatePageTitle.dart';
import '../widget_box/customDropdrown.dart';
import '../widget_box/customTextField.dart';

class PredictDiabetesPage extends StatefulWidget {
  @override
  _PredictDiabetesPageState createState() => _PredictDiabetesPageState();
}

class _PredictDiabetesPageState extends State<PredictDiabetesPage> {
  final TextEditingController ageController = TextEditingController();
  final TextEditingController bmiController = TextEditingController();
  final TextEditingController hba1cController = TextEditingController();
  final TextEditingController glucoseController = TextEditingController();
  bool isHighRisk = false;

  String? selectedGender;
  String? hasHypertension;
  String? doesSmoke;

  String diabetesRiskMessage = '';

  // Method to save data to SharedPreferences
  Future<void> saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save the data as key-value pairs
    prefs.setString('age', ageController.text);
    prefs.setString('bmi', bmiController.text);
    prefs.setString('hba1c', hba1cController.text);
    prefs.setString('glucose', glucoseController.text);
    prefs.setString('gender', selectedGender ?? '');
    prefs.setString('hypertension', hasHypertension ?? '');
    prefs.setString('smoke', doesSmoke ?? '');

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data saved successfully!')),
    );

    // Calculate risk and show message
    calculateDiabetesRisk();
  }

  // Method to load saved data from SharedPreferences
  Future<void> loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ageController.text = prefs.getString('age') ?? '';
      bmiController.text = prefs.getString('bmi') ?? '';
      hba1cController.text = prefs.getString('hba1c') ?? '';
      glucoseController.text = prefs.getString('glucose') ?? '';
      selectedGender = prefs.getString('gender');
      hasHypertension = prefs.getString('hypertension');
      doesSmoke = prefs.getString('smoke');
    });
  }

  // Method to calculate the diabetes risk
  void calculateDiabetesRisk() {
    // Parsing input values to integers/doubles
    int age = int.tryParse(ageController.text) ?? 0;
    double bmi = double.tryParse(bmiController.text) ?? 0;
    double hba1c = double.tryParse(hba1cController.text) ?? 0;
    double glucose = double.tryParse(glucoseController.text) ?? 0;

    // Risk logic based on the factors


    // Age Risk: 45 or above
    if (age >= 45) {
      isHighRisk = true;
    }

    // BMI Risk: 25 or above
    if (bmi >= 25) {
      isHighRisk = true;
    }

    // HbA1c Risk: 6.5% or more
    if (hba1c >= 6.5) {
      isHighRisk = true;
    }

    // Glucose Risk: Fasting glucose over 126 mg/dL
    if (glucose > 126) {
      isHighRisk = true;
    }

    // Hypertension Risk
    if (hasHypertension == 'Yes') {
      isHighRisk = true;
    }

    // Smoking Risk
    if (doesSmoke == 'Yes') {
      isHighRisk = true;
    }

    // Set the message based on the risk
    setState(() {
      if (isHighRisk) {
        diabetesRiskMessage = 'High risk for Diabetes';
      } else {
        diabetesRiskMessage = 'Low risk for Diabetes';
      }
    });
  }

  @override
  void initState() {
    super.initState();
    loadData(); // Load the data when the page is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomTextWidget(
          text: 'Predict Diabetes Risk',
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWideScreen = constraints.maxWidth > 600;

          return Padding(
            padding: EdgeInsets.all(isWideScreen ? 32.0 : 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isWideScreen
                    ? Row(
                  children: [
                    Expanded(
                      child: CustomDropdown(
                        value: selectedGender,
                        hint: 'Select Gender',
                        items: ['Male', 'Female'],
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomDropdown(
                        value: hasHypertension,
                        hint: 'Do you have hypertension?',
                        items: ['Yes', 'No'],
                        onChanged: (value) {
                          setState(() {
                            hasHypertension = value;
                          });
                        },
                      ),
                    ),
                  ],
                )
                    : Column(
                  children: [
                    CustomDropdown(
                      value: selectedGender,
                      hint: 'Select Gender',
                      items: ['Male', 'Female'],
                      onChanged: (value) {
                        setState(() {
                          selectedGender = value;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CustomDropdown(
                      value: hasHypertension,
                      hint: 'Do you have hypertension?',
                      items: ['Yes', 'No'],
                      onChanged: (value) {
                        setState(() {
                          hasHypertension = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                CustomDropdown(
                  value: doesSmoke,
                  hint: 'Do you smoke?',
                  items: ['Yes', 'No'],
                  onChanged: (value) {
                    setState(() {
                      doesSmoke = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    SizedBox(
                      width: isWideScreen
                          ? constraints.maxWidth / 2 - 20
                          : double.infinity,
                      child: CustomTextField(
                        label: 'Enter Age',
                        controller: ageController,
                      ),
                    ),
                    SizedBox(
                      width: isWideScreen
                          ? constraints.maxWidth / 2 - 20
                          : double.infinity,
                      child: CustomTextField(
                        label: 'Enter BMI',
                        controller: bmiController,
                      ),
                    ),
                    SizedBox(
                      width: isWideScreen
                          ? constraints.maxWidth / 2 - 20
                          : double.infinity,
                      child: CustomTextField(
                        label: 'Enter HbA1c (%)',
                        controller: hba1cController,
                      ),
                    ),
                    SizedBox(
                      width: isWideScreen
                          ? constraints.maxWidth / 2 - 20
                          : double.infinity,
                      child: CustomTextField(
                        label: 'Enter Glucose (mg/dL)',
                        controller: glucoseController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: SizedBox(
                    width: isWideScreen ? 250 : double.infinity,
                    child: CustomElevatedButton(
                      onPressed: saveData, // Save the data and calculate risk
                      text: "Submit",
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                if (diabetesRiskMessage.isNotEmpty)
                  Center(
                    child: Text(
                      diabetesRiskMessage,
                      style: TextStyle(
                        fontSize: isWideScreen ? 22 : 18,
                        fontWeight: FontWeight.bold,
                        color: isHighRisk ? Colors.red : Colors.green,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}