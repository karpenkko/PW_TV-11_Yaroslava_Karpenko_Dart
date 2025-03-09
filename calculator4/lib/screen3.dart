import 'dart:math';

import 'package:flutter/material.dart';

class Task3Screen extends StatefulWidget {
  const Task3Screen({super.key});

  @override
  State<Task3Screen> createState() => _Task3ScreenState();
}

class _Task3ScreenState extends State<Task3Screen> {
  final TextEditingController _resistanceHighController =
      TextEditingController();
  final TextEditingController _reactanceHighController =
      TextEditingController();
  final TextEditingController _resistanceMediumController =
      TextEditingController();
  final TextEditingController _reactanceMediumController =
      TextEditingController();

  String _result = "";

  void _calculate() {
    final double? resistanceHigh =
        double.tryParse(_resistanceHighController.text);
    final double? reactanceHigh =
        double.tryParse(_reactanceHighController.text);
    final double? resistanceMedium =
        double.tryParse(_resistanceMediumController.text);
    final double? reactanceMedium =
        double.tryParse(_reactanceMediumController.text);

    if (resistanceHigh != null &&
        reactanceHigh != null &&
        resistanceMedium != null &&
        reactanceMedium != null) {
      setState(() {
        _result = calculateShortCircuitCurrents(
            resistanceHigh, reactanceHigh, resistanceMedium, reactanceMedium);
      });
    } else {
      setState(() {
        _result = "Будь ласка, введіть всі значення.";
      });
    }
  }

  String calculateShortCircuitCurrents(
      double Rh, double Xh, double Rm, double Xm) {
    const double nominalVoltage = 115.0;
    const double baseVoltage = 11.0;
    const double sqrt3 = 1.732;
    const double multiplier = 1000.0;

    final double Xt = (11.1 * pow(nominalVoltage, 2)) / (100 * 6.3);

    final double Zsh = sqrt(pow(Rh, 2) + pow(Xh + Xt, 2));
    final double ZshMin = sqrt(pow(Rm, 2) + pow(Xm + Xt, 2));

    final double Ish3Normal = (nominalVoltage * multiplier) / (sqrt3 * Zsh);
    final double Ish3Min = (nominalVoltage * multiplier) / (sqrt3 * ZshMin);

    final double Ish2Normal = Ish3Normal * (sqrt3 / 2);
    final double Ish2Min = Ish3Min * (sqrt3 / 2);

    final double k = pow(baseVoltage, 2) / pow(nominalVoltage, 2);
    final double ZshTrue = sqrt(pow(Rh * k, 2) + pow((Xh + Xt) * k, 2));
    final double ZshMinTrue = sqrt(pow(Rm * k, 2) + pow((Xm + Xt) * k, 2));

    final double DIsh3Normal = (baseVoltage * multiplier) / (sqrt3 * ZshTrue);
    final double DIsh3Min = (baseVoltage * multiplier) / (sqrt3 * ZshMinTrue);

    final double DIsh2Normal = DIsh3Normal * (sqrt3 / 2);
    final double DIsh2Min = DIsh3Min * (sqrt3 / 2);

    return """
Результати розрахунків:
Струм трифазного КЗ (приведений до 110 кВ):
Нормальний режим: ${Ish3Normal.toStringAsFixed(2)} А
Мінімальний режим: ${Ish3Min.toStringAsFixed(2)} А

Струм двофазного КЗ (приведений до 110 кВ):
Нормальний режим: ${Ish2Normal.toStringAsFixed(2)} А
Мінімальний режим: ${Ish2Min.toStringAsFixed(2)} А

Дійсний струм трифазного КЗ (на шинах 10 кВ):
Нормальний режим: ${DIsh3Normal.toStringAsFixed(2)} А
Мінімальний режим: ${DIsh3Min.toStringAsFixed(2)} А

Дійсний струм двофазного КЗ (на шинах 10 кВ):
Нормальний режим: ${DIsh2Normal.toStringAsFixed(2)} А
Мінімальний режим: ${DIsh2Min.toStringAsFixed(2)} А

Аварійний режим на даній підстанції не передбачений.
""";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Перевірка стійкості',
          style: TextStyle(
            color: Color(0xFFECECEC),
          ),
        ),
        backgroundColor: const Color(0xFF38140B),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _resistanceHighController,
                keyboardType: TextInputType.number,
                decoration:
                    const InputDecoration(labelText: "Опір високої сторони (Rh)"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _reactanceHighController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Реактивний опір високої сторони (Xh)"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _resistanceMediumController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Опір середньої сторони (Rm)"),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _reactanceMediumController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Реактивний опір середньої сторони (Xm)"),
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
                _result,
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
