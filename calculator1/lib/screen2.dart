import 'package:flutter/material.dart';

class Task2Screen extends StatefulWidget {
  const Task2Screen({super.key});

  @override
  State<Task2Screen> createState() => _Task2ScreenState();
}

class _Task2ScreenState extends State<Task2Screen> {
  // Контролери для полів введення
  final TextEditingController _carbonController = TextEditingController();
  final TextEditingController _hydrogenController = TextEditingController();
  final TextEditingController _oxygenController = TextEditingController();
  final TextEditingController _sulfurController = TextEditingController();
  final TextEditingController _oilHeatController = TextEditingController();
  final TextEditingController _fuelMoistureController = TextEditingController();
  final TextEditingController _ashController = TextEditingController();
  final TextEditingController _vanadiumController = TextEditingController();

  String _result = '';

  double formatValue(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  // Розрахунок компонентів робочої маси за коефіцієнтами, які визначаються із заданих значень
  void _calculateTask2() {
    double carbon = double.tryParse(_carbonController.text) ?? 0;
    double hydrogen = double.tryParse(_hydrogenController.text) ?? 0;
    double oxygen = double.tryParse(_oxygenController.text) ?? 0;
    double sulfur = double.tryParse(_sulfurController.text) ?? 0;
    double oilHeat = double.tryParse(_oilHeatController.text) ?? 0;
    double fuelMoisture = double.tryParse(_fuelMoistureController.text) ?? 0;
    double ash = double.tryParse(_ashController.text) ?? 0;
    double vanadium = double.tryParse(_vanadiumController.text) ?? 0;

    // Обчислення множників згідно з умовою завдання
    double factor1 = (100 - fuelMoisture - ash) / 100;
    // Для кисню використовуємо інший множник (згідно з прикладом)
    double factor2 = (100 - fuelMoisture / 10 - ash / 10) / 100;
    double factor3 = (100 - fuelMoisture) / 100;

    // Перерахунок компонентів для робочої маси
    double carbonWorking = formatValue(carbon * factor1);
    double hydrogenWorking = formatValue(hydrogen * factor1);
    double oxygenWorking = formatValue(oxygen * factor2);
    double sulfurWorking = formatValue(sulfur * factor1);
    double ashWorking = formatValue(ash * factor3);
    double vanadiumWorking = formatValue(vanadium * factor3);

    // Перерахунок нижчої теплоти згоряння для робочої маси
    double lowerHeat = formatValue(oilHeat * factor1 - 0.025 * fuelMoisture);

    setState(() {
      _result = 'Вхідні дані:\n'
          'Вуглець: $carbon%, Водень: $hydrogen%, Кисень: $oxygen%, Сірка: $sulfur%,\n'
          'Нижча теплота горючої маси: $oilHeat МДж/кг, Вологість: $fuelMoisture%, Зольність: $ash%,\n'
          'Вміст ванадію: $vanadium мг/кг\n\n'
          'Склад робочої маси мазуту:\n'
          'C: $carbonWorking%, H: $hydrogenWorking%, O: $oxygenWorking%,\n'
          'S: $sulfurWorking%, A: $ashWorking%, V: $vanadiumWorking мг/кг\n\n'
          'Нижча теплота згоряння (робоча маса): $lowerHeat МДж/кг';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Калькулятор 2',
          style: TextStyle(
            color: Color(0xFFECECEC),
          ),
        ),
        backgroundColor: const Color(0xFF38140B),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _carbonController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вуглець (%)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _hydrogenController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Водень (%)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _oxygenController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Кисень (%)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _sulfurController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Сірка (%)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _oilHeatController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Нижча теплота згоряння горючої маси (МДж/кг)',
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _fuelMoistureController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вологість робочої маси (%)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _ashController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Зольність сухої маси (%)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _vanadiumController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вміст ванадію (мг/кг)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateTask2,
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
    );
  }
}
