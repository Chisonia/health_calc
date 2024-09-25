**HealthCalc** 🎯



**Introduction**

HealthCalc is an app designed to streamline essential healthcare calculations, from gestational age and medication dosages to next appointment dates and fluid drip rates. Inspired by my experience working in primary healthcare, I noticed the need for an app that could make medical consultations more efficient by minimizing manual calculations that can lead to errors.
Project Blog Article | Author LinkedIn (www.linkedin.com/in/chinenye-akukalia)


**Project Inspiration & Vision** 💡

Working as a medical doctor for 10+ years, I encountered the recurring problem of calculating vital metrics such as:

Gestational age & expected delivery dates for pregnant women

Medication dosages based on patient weight

Fluid administration rates

Counting the days to the next patient visit

These tasks are not only time-consuming but prone to errors, which can negatively impact patient care. I wanted to create a solution to speed up patient consultation and reduce calculation errors, making healthcare delivery more efficient.

This app started as a simple idea during my time working at a busy primary health center. With time and iteration, I realized the potential of HealthCalc to enhance patient care by allowing healthcare workers to focus more on their patients rather than on manual calculations.


**Technology & Architecture** 🛠️

HealthCalc was developed using the following technologies:

**Flutter**: Used to build the cross-platform mobile app.

**Dart**: The core programming language.

**State Management**: Initially considered using BLoC for state management but found that StatefulWidget was more suitable given the app's simplicity.

**Shared Preferences**: Local storage used for saving recent calculations.
**JSON**: For storing and retrieving data.


**Here’s a visual overview of the architecture:**

![health_calc_homescreen](https://github.com/user-attachments/assets/1b0dbb1c-c39b-4a86-b13a-a084a6e3360c)



**Core Algorithms** 🧠

**Gestational Age Calculation**

DateTime currentDate = DateTime.now();

Duration difference = currentDate.difference(lastMenstrualPeriod);

int weeks = (daysDifference ~/ 7);

int days = daysDifference % 7;

int months = daysDifference ~/ 30;

int days = daysDifference % 30;



**Next Appointment Date Calculation:**

duration = const Duration(days: 7);

duration = const Duration(days: 14);

duration = const Duration(days: 30);

duration = const Duration(days: 60);

duration = const Duration(days: 90);

duration = const Duration(days: 365);

duration = const Duration(days: 1095);

duration = const Duration(days: 1825);

**Medication Dosage Calculation:**

final double totalDosage = dosage * weight; // Total dosage = dosage * weight

// Calculate dosage in ml

final double dosageInMl = totalDosage / concentration; // ml


**Fluid Drops per Minute:**

final double durationInMinutes = durationInHours * 60.0;

final double dropsPerMinute = (volume * dropFactor) / durationInMinutes;

**Weight For Age**

final expectedWeight = (ageValue + 9) / 2;

final expectedWeight = 2 * (ageValue + 5);

final expectedWeight = 4 * ageValue;


**Screenshots** 📸
![account_p](https://github.com/user-attachments/assets/bda11ef5-c515-4b1b-9f20-6c1e60121543)
![history_p](https://github.com/user-attachments/assets/9131b3c8-8ad3-4013-9f02-62d451d7c9fd)
![drops_min](https://github.com/user-attachments/assets/c57db60f-0ea8-490b-8b76-1feb393c0496)
![total_dose](https://github.com/user-attachments/assets/6ba639bd-e7af-4342-b13e-b299e1fe65e7)
![bmi](https://github.com/user-attachments/assets/de384275-51f8-4537-a22f-a06584f4e01b)
![nxt_visit](https://github.com/user-attachments/assets/0ebe4b2c-e6d3-4b15-ab7d-dc46adbd1f1d)
![ga_edd](https://github.com/user-attachments/assets/56c972b8-f6f3-441c-a9ed-5650f18c2594)
![health_calc_WA](https://github.com/user-attachments/assets/a5d1aaba-8904-4a69-b5e3-4b8f4b81bb08)






**Challenges & Solutions** 🚧

One of the major challenges I faced during development was the initial plan to use BLoC for state management. BLoC turned out to be unnecessarily complex for this small-scale project. After testing several approaches, I switched to using StatefulWidget, which streamlined the workflow and improved performance.

Another technical challenge was integrating local storage. I wanted users to have access to their recent calculations, so I implemented Shared Preferences for storing data. This allowed for a more seamless user experience.

**Learnings & Future Plans** 🚀

Throughout the development of HealthCalc, I deepened my understanding of mobile app architecture, specifically:

Local storage techniques using Shared Preferences.

Optimizing the user interface for healthcare workers, ensuring simplicity and clarity.

How to make medical apps intuitive for non-technical users.


**For the next iteration, I plan to:**

Expand the calculation features to include more specific medication dosages and clinical tools.

Integrate cloud storage to allow for cross-device data sharing.

Enhance the UI/UX based on feedback from healthcare professionals.

**Installation & Setup 🔧

To get started with HealthCalc:**

To set up the project on your local machine, follow these steps:

**Clone the repository:**

git clone https://github.com/yourusername/healthcalc.git

**Navigate to the project folder:**

cd healthcalc

**Install dependencies:**

flutter pub get


**Run the app:**

flutter run

**Usage**

HealthCalc allows healthcare workers to perform the following calculations easily:

Gestational Age & Expected Delivery Date

Input the last menstrual period, and the app will calculate the gestational age and expected delivery date for pregnant women.

Medication Dosage
Input the medication strength and patient weight, and the app will compute the total dosage needed.

Fluid Drops Per Minute
Enter the total volume of fluid and the drip factor to calculate the drops per minute required for intravenous fluids.

Weight for Age
Input a child's weight and age to determine if their weight falls within the normal range for their age.

**Contributing** 🤝

Contributions are welcome!

**To contribute:**

Fork the repository.

Create a new branch (git checkout -b feature-branch).

Make your changes and commit them (git commit -m 'Add new feature').

Push to the branch (git push origin feature-branch).

Open a Pull Request.



License 📝
This project is licensed under the MIT License. See the LICENSE file for more details.
