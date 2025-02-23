import 'package:flutter/material.dart';
import 'dart:math';

class EmissionCalculatorScreen extends StatefulWidget {
  const EmissionCalculatorScreen({super.key});

  @override
  State<EmissionCalculatorScreen> createState() => _EmissionCalculatorScreenState();
}

class _EmissionCalculatorScreenState extends State<EmissionCalculatorScreen> {
  final TextEditingController coalCombustionController = TextEditingController();
  final TextEditingController fuelOilCombustionController = TextEditingController();
  final TextEditingController coalAshContentController = TextEditingController();
  final TextEditingController fuelOilAshContentController = TextEditingController();
  final TextEditingController coalFuelMassController = TextEditingController();
  final TextEditingController fuelOilFuelMassController = TextEditingController();
  final TextEditingController dustRemovalEfficiencyController = TextEditingController();

  String result = "";

  void calculateEmissions() {
    double coalCombustion = double.tryParse(coalCombustionController.text) ?? 0.0;
    double fuelOilCombustion = double.tryParse(fuelOilCombustionController.text) ?? 0.0;
    double coalAshContent = double.tryParse(coalAshContentController.text) ?? 0.0;
    double fuelOilAshContent = double.tryParse(fuelOilAshContentController.text) ?? 0.0;
    double coalFuelMass = double.tryParse(coalFuelMassController.text) ?? 0.0;
    double fuelOilFuelMass = double.tryParse(fuelOilFuelMassController.text) ?? 0.0;
    double dustRemovalEfficiency = double.tryParse(dustRemovalEfficiencyController.text) ?? 0.0;

    var (coalEmissionIndex, coalEmission) = calculateCoalEmissions(coalCombustion, coalAshContent, coalFuelMass, dustRemovalEfficiency);
    var (fuelOilEmissionIndex, fuelOilEmission) = calculateFuelOilEmissions(fuelOilCombustion, fuelOilAshContent, fuelOilFuelMass, dustRemovalEfficiency);

    setState(() {
      result = "Валовий викид вугілля: $coalEmissionIndex т.\nЗольність вугілля: $coalEmission %\n"
          "Валовий викид мазуту: $fuelOilEmissionIndex т.\nЗольність мазуту: $fuelOilEmission %";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Розрахунок викидів',
          style: TextStyle(
            color: Color(0xFFECECEC),
          ),
        ),
        backgroundColor: const Color(0xFF38140B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildInputField("Вугілля (МДж/кг)", coalCombustionController),
              buildInputField("Мазут (МДж/кг)", fuelOilCombustionController),
              buildInputField("Вугілля (%)", coalAshContentController),
              buildInputField("Мазут (%)", fuelOilAshContentController),
              buildInputField("Вугілля (т)", coalFuelMassController),
              buildInputField("Мазут (т)", fuelOilFuelMassController),
              buildInputField("Ефективність золовловлення", dustRemovalEfficiencyController),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: calculateEmissions,
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
              Text(result, style: const TextStyle(fontSize: 16)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInputField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
        keyboardType: TextInputType.number,
      ),
    );
  }

  (double, double) calculateCoalEmissions(double coalCombustion, double coalAshContent, double coalFuelMass, double dustRemovalEfficiency) {
    double emissionIndex = pow(10, 6) / coalCombustion * 0.8 * coalAshContent / (100 - 1.5) * (1 - dustRemovalEfficiency);
    double emission = pow(10, -6) * emissionIndex * coalCombustion * coalFuelMass;
    return ((emissionIndex * 100).round() / 100, (emission * 100).round() / 100);
  }

  (double, double) calculateFuelOilEmissions(double fuelOilCombustion, double fuelOilAshContent, double fuelOilFuelMass, double dustRemovalEfficiency) {
    double emissionIndex = pow(10, 6) / fuelOilCombustion * 1 * fuelOilAshContent / (100 - 1.5) * (1 - dustRemovalEfficiency);
    double emission = pow(10, -6) * emissionIndex * fuelOilCombustion * fuelOilFuelMass;
    return ((emissionIndex * 100).round() / 100, (emission * 100).round() / 100);
  }
}