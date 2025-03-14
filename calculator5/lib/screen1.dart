import 'package:flutter/material.dart';

class Task1Screen extends StatefulWidget {
  const Task1Screen({super.key});

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  double singleLineReliability = 0.0;
  double doubleLineReliability = 0.0;
  String moreReliableSystem = "";

  final TextEditingController lineLengthController = TextEditingController();
  final TextEditingController connectionCountController = TextEditingController();

  void calculateResults() {
    double length = double.tryParse(lineLengthController.text) ?? 0.0;
    int connections = int.tryParse(connectionCountController.text) ?? 0;

    setState(() {
      singleLineReliability = calculateReliabilitySingleLineSystem();
      doubleLineReliability = calculateReliabilityDoubleLineSystem();

      moreReliableSystem = singleLineReliability > doubleLineReliability
          ? "Одноколова система більш надійна."
          : "Двоколова система більш надійна.";
    });
  }

  double calculateReliabilitySingleLineSystem() {
    List<double> failureRates = [0.01, 0.07, 0.015, 0.02, 0.03 * 6];
    double failureRateSum = failureRates.reduce((a, b) => a + b);
    double meanRecoveryTime =
        (0.01 * 30 + 0.07 * 10 + 0.015 * 100 + 0.02 * 15 + 0.18 * 2) / failureRateSum;
    return (failureRateSum * meanRecoveryTime) / 8760;
  }

  double calculateReliabilityDoubleLineSystem() {
    double failureRateSingleLine = 0.295;
    double failureRateTwoLinesSimultaneous =
        2 * failureRateSingleLine * (13.6 * 1e-4) + 5.89 * 1e-7;
    return failureRateTwoLinesSimultaneous + 0.02;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Розрахунок надійності',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: lineLengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Довжина лінії (км)"),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: connectionCountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: "Кількість приєднань"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateResults,
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
            if (singleLineReliability != 0.0 && doubleLineReliability != 0.0) ...[
              Text("Надійність одноколової системи: ${singleLineReliability.toStringAsFixed(6)}"),
              Text("Надійність двоколової системи: ${doubleLineReliability.toStringAsFixed(6)}"),
              Text("Результат порівняння: $moreReliableSystem"),
            ]
          ],
        ),
      ),
    );
  }
}
