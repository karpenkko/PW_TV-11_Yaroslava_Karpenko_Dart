import 'dart:math';
import 'package:flutter/material.dart';

class SolarPowerProfitCalculator extends StatefulWidget {
  const SolarPowerProfitCalculator({super.key});

  @override
  State<SolarPowerProfitCalculator> createState() =>
      _SolarPowerProfitCalculatorState();
}

class _SolarPowerProfitCalculatorState
    extends State<SolarPowerProfitCalculator> {
  final TextEditingController powerController =
      TextEditingController(text: "5");
  final TextEditingController deviationInitialController =
      TextEditingController(text: "1");
  final TextEditingController deviationImprovedController =
      TextEditingController(text: "0.25");
  final TextEditingController costPerKWhController =
      TextEditingController(text: "7");
  String result = "";

  void calculateProfit() {
    double averageCapacity = double.tryParse(powerController.text) ?? 0.0;
    double sigma1 = double.tryParse(deviationInitialController.text) ?? 0.0;
    double sigma2 = double.tryParse(deviationImprovedController.text) ?? 0.0;
    double cost = double.tryParse(costPerKWhController.text) ?? 0.0;

    double probabilityNoImbalance1 =
        calculateNormalProbability(5.0, sigma1, 4.75, 5.25);
    double probabilityNoImbalance2 =
        calculateNormalProbability(5.0, sigma2, 4.75, 5.25);

    double w1NoImbalance = averageCapacity * 24 * probabilityNoImbalance1;
    double w1Imbalance = averageCapacity * 24 * (1 - probabilityNoImbalance1);
    double w2NoImbalance = averageCapacity * 24 * probabilityNoImbalance2;
    double w2Imbalance = averageCapacity * 24 * (1 - probabilityNoImbalance2);

    double p1 = w1NoImbalance * cost;
    double i1 = w1Imbalance * cost;
    double profitInitial = p1 - i1;

    double p2 = w2NoImbalance * cost;
    double i2 = w2Imbalance * cost;
    double profitImproved = p2 - i2;

    setState(() {
      result =
          "Прибуток після покращення: ${profitImproved.toStringAsFixed(2)} тис. грн";
    });
  }

  double calculateNormalProbability(
      double mean, double stdDev, double lower, double upper) {
    double normalPdf(double x, double mean, double stdDev) {
      return (1 / (stdDev * sqrt(2 * pi))) *
          exp(-0.5 * pow((x - mean) / stdDev, 2));
    }

    int steps = 1000;
    double stepSize = (upper - lower) / steps;
    double area = 0.0;
    for (int i = 0; i < steps; i++) {
      double x1 = lower + i * stepSize;
      double x2 = x1 + stepSize;
      area += (normalPdf(x1, mean, stdDev) + normalPdf(x2, mean, stdDev)) /
          2 *
          stepSize;
    }
    return area;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Розрахунок прибутку',
          style: TextStyle(
            color: Color(0xFFECECEC),
          ),
        ),
        backgroundColor: const Color(0xFF38140B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            PowerTextField(
              label: "Потужність (кВт)",
              controller: powerController,
            ),
            PowerTextField(
              label: "Початкова похибка (%)",
              controller: deviationInitialController,
            ),
            PowerTextField(
              label: "Покращена похибка (%)",
              controller: deviationImprovedController,
            ),
            PowerTextField(
              label: "Вартість за кВт·год (грн)",
              controller: costPerKWhController,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateProfit,
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
            if (result.isNotEmpty)
              Text(
                result,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

class PowerTextField extends StatelessWidget {
  const PowerTextField({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
