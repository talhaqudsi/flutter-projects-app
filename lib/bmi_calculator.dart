import 'package:flutter/material.dart';

class BMICalc extends StatefulWidget {
  const BMICalc({super.key});

  @override
  State<BMICalc> createState() => _BMICalcState();
}

class _BMICalcState extends State<BMICalc> {
  int selectedCalcIndex = 0;
  String result = "0";

  // Text controllers for the two text fields
  var firstNumController = TextEditingController();
  var secondNumController = TextEditingController();
  var thirdNumController = TextEditingController();

  // Focus node for the first text field
  FocusNode firstNumFocusNode = FocusNode();

  // List of calculation types for the dropdown menu making
  // use of the Calc class
  final List<Calc> _calcs = [
    Calc(type: "Imperial", color: Colors.black),
    Calc(type: "Metric", color: Colors.black),
  ];

  // Called when the state object is created and inserted into the tree
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   FocusScope.of(context).requestFocus(firstNumFocusNode);
    //});
  }

  // Called when the state object is removed from the tree
  // discarding any resources used by the object
  @override
  void dispose() {
    // Disposing of the text controllers
    firstNumController.dispose();
    secondNumController.dispose();
    thirdNumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "Select a calculation type, enter your height and weight, then press Calculate.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ),
                DropdownButtonFormField<Calc>(
                  value: _calcs[selectedCalcIndex],
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  items: _calcs
                      .map((calc) => DropdownMenuItem<Calc>(
                            value: calc,
                            child: Text(
                              calc.type,
                              style: TextStyle(color: calc.color),
                            ),
                          ))
                      .toList(),
                  onChanged: (calc) {
                    setState(() {
                      selectedCalcIndex = _calcs.indexOf(calc!);
                    });
                  },
                ),
                SizedBox(height: 24),
                TextFormField(
                  controller: firstNumController,
                  autofocus: false,
                  focusNode: firstNumFocusNode,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: selectedCalcIndex == 0
                        ? 'Height (feet)'
                        : 'Height (meters)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: secondNumController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: selectedCalcIndex == 0
                        ? 'Height (inches)'
                        : 'Weight (kg)',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: thirdNumController,
                  enabled: selectedCalcIndex == 0,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: selectedCalcIndex == 0 ? 'Weight (lbs)' : '',
                    border: OutlineInputBorder(),
                    filled: selectedCalcIndex != 0,
                    fillColor:
                        selectedCalcIndex != 0 ? Colors.grey.shade200 : null,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        firstNumController.clear();
                        secondNumController.clear();
                        thirdNumController.clear();
                        firstNumFocusNode.requestFocus();
                        setState(() {
                          result = '';
                        });
                      },
                      child: const Text(
                        "Clear",
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                      ),
                      onPressed: () {
                        setState(() {
                          result =
                              Calc.calculate(_calcs[selectedCalcIndex].type)
                                  .perform(
                            firstNumController.text,
                            secondNumController.text,
                            thirdNumController.text,
                          );
                        });
                      },
                      child: Text(
                        "Calculate",
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 48),
                Text(
                  result,
                  style: const TextStyle(fontSize: 32),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Calc {
  String type;
  Color? color;
  String res = "0";
  Calc({required this.type, required this.color});
  Calc.calculate(this.type) : color = null;
  // Main calculation method for the four basic math operations
  String perform(String firstNum, String secondNum, String thirdNum) {
    double num1 = 0;
    double num2 = 0;
    double num3 = 0;
    double bmi = 0;
    String category = '';
    ImperialBMICalculator imperialBMICalculator;
    MetricBMICalculator metricBMICalculator;

    switch (type) {
      case "Imperial":
        num1 = double.parse(firstNum);
        num2 = double.parse(secondNum);
        num3 = double.parse(thirdNum);
        imperialBMICalculator = ImperialBMICalculator(num1, num2, num3);
        bmi = imperialBMICalculator.calculateBMI();
        category = imperialBMICalculator.getBMICategory(bmi);
      case "Metric":
        num1 = double.parse(firstNum);
        num2 = double.parse(secondNum);
        metricBMICalculator = MetricBMICalculator(num1, num2);
        bmi = metricBMICalculator.calculateBMI();
        category = metricBMICalculator.getBMICategory(bmi);
      default:
        res = "Nothing to do";
    }

    res = 'BMI: ${bmi.toStringAsFixed(1)} \nCategory: $category';
    //bmi = calculator.calculateBMI();
    return res;
  }
}

// BMICalculator interface
abstract class BMICalculator {
  double calculateBMI();
}

// BMICategory - Mixin to provide a common method for determining BMI Category
// Categories per CDC:
// Underweight <18.5, Healthy >18.5 and <25, Overweight >25 and <30, Obesity >30
mixin BMICategory {
  // Return BMI category as a string bsed on BMI value
  String getBMICategory(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 25) {
      return 'Healthy Weight';
    } else if (bmi < 30) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }
}

// Imperial BMICalculator implementation
// Takes in height as feet and inches, weight in pounds
class ImperialBMICalculator with BMICategory implements BMICalculator {
  final double feet;
  final double inches;
  final double weightPounds;

  ImperialBMICalculator(this.feet, this.inches, this.weightPounds);

  // Convert height to total inches and calculates BMI with the following formula:
  // BMI (Imperial) = (weight in lbs * 703) / (height in inches)^2
  @override
  double calculateBMI() {
    double totalInches = (feet * 12) + inches;
    return (weightPounds * 703) / (totalInches * totalInches);
  }
}

// Metric BMICalculator implementation
// Takes in height as meters, weight in kilograms
class MetricBMICalculator with BMICategory implements BMICalculator {
  final double meters;
  final double weightKilograms;

  MetricBMICalculator(this.meters, this.weightKilograms);

  // Calculate BMI with the following formula:
  // BMI (Metric) = weight in kg / (height in meters)^2
  @override
  double calculateBMI() {
    return weightKilograms / (meters * meters);
  }
}
