import 'package:flutter/material.dart';
import 'dart:math';

class MathCalc extends StatefulWidget {
  const MathCalc({super.key});

  @override
  State<MathCalc> createState() => _MathCalcState();
}

class _MathCalcState extends State<MathCalc> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _result = '';

  // Compute method from HW1
  void compute(String action, double v1, double v2) {
    double result = 0;
    switch (action) {
      case "add":
        result = add(v1, v2);
        setState(() {
          _result = '$v1 + $v2 = $result';
        });
        break;
      case "subtract":
        result = subtract(v1, v2);
        setState(() {
          _result = '$v1 − $v2 = $result';
        });
        break;
      case "multiply":
        result = multiply(v1, v2);
        setState(() {
          _result = '$v1 × $v2 = $result';
        });
        break;
      case "divide":
        result = divide(v1, v2);
        setState(() {
          _result = '$v1 ÷ $v2 = $result';
        });
        break;
      case "modulo":
        result = modulo(v1, v2);
        setState(() {
          _result = '$v1 % $v2 = $result';
        });
        break;
      case "power":
        result = power(v1, v2).toDouble();
        setState(() {
          _result = '$v1 ^ $v2 = $result';
        });
        break;
      default:
        setState(() {
          _result = result.toString();
        });
    }
  }

  double add(double v1, double v2) => v1 + v2;
  double subtract(double v1, double v2) => v1 - v2;
  double multiply(double v1, double v2) => v1 * v2;
  double divide(double v1, double v2) => v1 / v2;
  double modulo(double v1, double v2) => v1 % v2;
  num power(double v1, double v2) => pow(v1, v2);

  // Helper function to parse the user input
  double _parseInput(String input) => double.tryParse(input) ?? 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "Enter 2 numbers, then tap the desired calculation type.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              ),
              // First number field
              TextField(
                controller: _controller1,
                decoration: const InputDecoration(
                  labelText: 'First number',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              // Second number field
              TextField(
                controller: _controller2,
                decoration: const InputDecoration(
                  labelText: 'Second number',
                  border: OutlineInputBorder(),
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              // Buttons for operations using a wrap widget for responsive layout
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  ElevatedButton(
                    // Add
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(105, 25),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      double v1 = _parseInput(_controller1.text);
                      double v2 = _parseInput(_controller2.text);
                      compute("add", v1, v2);
                    },
                    child: const Text("Add"),
                  ),
                  ElevatedButton(
                    // Subtract
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(105, 25),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      double v1 = _parseInput(_controller1.text);
                      double v2 = _parseInput(_controller2.text);
                      compute("subtract", v1, v2);
                    },
                    child: const Text("Subtract"),
                  ),
                  ElevatedButton(
                    // Multiply
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(105, 25),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      double v1 = _parseInput(_controller1.text);
                      double v2 = _parseInput(_controller2.text);
                      compute("multiply", v1, v2);
                    },
                    child: const Text("Multiply"),
                  ),
                  ElevatedButton(
                    // Divide
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(105, 25),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      double v1 = _parseInput(_controller1.text);
                      double v2 = _parseInput(_controller2.text);
                      compute("divide", v1, v2);
                    },
                    child: const Text("Divide"),
                  ),
                  ElevatedButton(
                    // Modulo
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(105, 25),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      double v1 = _parseInput(_controller1.text);
                      double v2 = _parseInput(_controller2.text);
                      compute("modulo", v1, v2);
                    },
                    child: const Text("Modulo"),
                  ),
                  ElevatedButton(
                    // Power
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(105, 25),
                      backgroundColor:
                          Theme.of(context).colorScheme.inversePrimary,
                    ),
                    onPressed: () {
                      double v1 = _parseInput(_controller1.text);
                      double v2 = _parseInput(_controller2.text);
                      compute("power", v1, v2);
                    },
                    child: const Text("Power"),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Result display
              Text(
                _result,
                style: const TextStyle(fontSize: 24),
              )
            ],
          ),
        ),
      ),
    );
  }
}
