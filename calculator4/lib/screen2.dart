import 'package:flutter/material.dart';

class Task2Screen extends StatefulWidget {
  const Task2Screen({super.key});

  @override
  State<Task2Screen> createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final TextEditingController _pKzController = TextEditingController();
  double? _result;

  void _calculate() {
    final double? pKzValue = double.tryParse(_pKzController.text);
    if (pKzValue != null) {
      setState(() {
        _result = _calculateShortCircuitCurrent(pKzValue);
      });
    }
  }

  double _calculateShortCircuitCurrent(double pKz) {
    const double voltage = 10000.0;
    const double resistanceK1 = 0.55;
    const double resistanceK2 = 1.84;
    const double sqrt3 = 1.732; // sqrt(3) ≈ 1.732

    return pKz / (voltage * sqrt3 * (resistanceK1 + resistanceK2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Розрахунок однофазного КЗ',
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
              controller: _pKzController,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: "Введіть потужність КЗ (кВт)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
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
              "Результат: ${_result != null ? _result!.toStringAsFixed(8) : "—"} кА",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
