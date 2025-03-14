import 'package:flutter/material.dart';

class Task2Screen extends StatefulWidget {
  const Task2Screen({super.key});

  @override
  State<Task2Screen> createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  final TextEditingController _emergencyLossRateController = TextEditingController();
  final TextEditingController _plannedLossRateController = TextEditingController();
  double? result;

  void calculateResults() {
    final double? emergencyRate = double.tryParse(_emergencyLossRateController.text);
    final double? plannedRate = double.tryParse(_plannedLossRateController.text);

    if (emergencyRate != null && plannedRate != null) {
      setState(() {
        result = calculatePowerLoss(emergencyRate, plannedRate);
      });
    }
  }

  double calculatePowerLoss(
      double emergencyRate, double plannedRate,
      {double emergencyPowerLoss = 14900.0, double plannedPowerLoss = 132400.0}) {
    return (emergencyRate * emergencyPowerLoss) + (plannedRate * plannedPowerLoss);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Розрахунок збитків',
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
              controller: _emergencyLossRateController,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: "Питомі збитки аварійних вимкнень (грн/кВт·год)"),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _plannedLossRateController,
              keyboardType: TextInputType.number,
              decoration:
              const InputDecoration(labelText: "Питомі збитки планових вимкнень (грн/кВт·год)"),
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
            if (result != null)
              Text("Збитки: ${result!.toStringAsFixed(2)} грн",
                  style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
