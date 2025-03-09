import 'dart:math';
import 'package:flutter/material.dart';

class Task1Screen extends StatefulWidget {
  const Task1Screen({super.key});

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  final TextEditingController _voltageController = TextEditingController();
  double? economicSection;
  double? thermalSection;

  void calculateCableParameters() {
    double? voltage = double.tryParse(_voltageController.text);
    if (voltage != null) {
      setState(() {
        var result = _calculateCableParameters(voltage);
        economicSection = result.item1;
        thermalSection = result.item2;
      });
    }
  }

  Tuple2<double, double> _calculateCableParameters(double voltage) {
    const double shortCircuitCurrent = 2500.0;
    const double disconnectionTime = 2.5;
    const double loadPower = 1300.0;
    const double economicDensity = 1.4;
    const double thermalConstant = 92.0;

    double inNormal = loadPower / (2 * sqrt(3) * voltage);
    double economicSection = inNormal / economicDensity;
    double thermalSection =
        shortCircuitCurrent * sqrt(disconnectionTime) / thermalConstant;

    return Tuple2(economicSection, thermalSection);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Розрахунок трифазного КЗ',
          style: TextStyle(
            color: Color(0xFFECECEC),
          ),
        ),
        backgroundColor: const Color(0xFF38140B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: _voltageController,
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: "Введіть напругу (кВ)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateCableParameters,
              child: const Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                  child: Text(
                    'Розрахувати',
                    style: TextStyle(
                      color: Color(0xFFECECEC),
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Економічний переріз: ${economicSection != null ? "${economicSection!.toStringAsFixed(2)} мм²" : "—"}",
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              "Термічний переріз: ${thermalSection != null ? "${thermalSection!.toStringAsFixed(2)} мм²" : "—"}",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;
  Tuple2(this.item1, this.item2);
}
