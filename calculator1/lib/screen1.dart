import 'package:flutter/material.dart';

class Task1Screen extends StatefulWidget {
  const Task1Screen({super.key});

  @override
  State<Task1Screen> createState() => _Task1ScreenState();
}

class _Task1ScreenState extends State<Task1Screen> {
  // Контролери для полів введення
  final TextEditingController _hpController = TextEditingController();
  final TextEditingController _cpController = TextEditingController();
  final TextEditingController _spController = TextEditingController();
  final TextEditingController _npController = TextEditingController();
  final TextEditingController _opController = TextEditingController();
  final TextEditingController _wpController = TextEditingController();
  final TextEditingController _apController = TextEditingController();

  // Результати
  String _result = '';

  // Функція форматування значень до 2 знаків після коми
  double formatValue(double value) {
    return double.parse(value.toStringAsFixed(2));
  }

  // Розрахунок коефіцієнта переходу: наприклад, для сухої маси – вологість,
  // а для горючої – вологість плюс зольність.
  double calculateCoefficient(double moistureOrCombined) {
    return formatValue(100 / (100 - moistureOrCombined));
  }

  // Розрахунок маси компонента з урахуванням коефіцієнта
  double calculateMass(double component, double coefficient) {
    return formatValue(component * coefficient);
  }

  // Розрахунок нижчої теплоти згоряння для робочої маси (МДж/кг)
  double calculateHeat(double cp, double hp, double sp, double op, double wp) {
    // Розрахунок для робочої маси, потім переводимо в МДж/кг
    double qWorking = 339 * cp + 1030 * hp - 108.8 * (op - sp) - 25 * wp;
    return formatValue(qWorking / 1000);
  }

  // Розрахунок теплоти згоряння з урахуванням вологи і (для горючої) золи
  double calculateHeatMass(double baseHeat, double moisture, [double? ash]) {
    if (ash != null) {
      return formatValue(
          (baseHeat + 0.025 * moisture) * 100 / (100 - moisture - ash));
    } else {
      return formatValue(
          (baseHeat + 0.025 * moisture) * 100 / (100 - moisture));
    }
  }

  void _calculateTask1() {
    // Зчитування даних з полів (якщо порожньо – приймаємо 0)
    double hp = double.tryParse(_hpController.text) ?? 0;
    double cp = double.tryParse(_cpController.text) ?? 0;
    double sp = double.tryParse(_spController.text) ?? 0;
    double np = double.tryParse(_npController.text) ?? 0;
    double op = double.tryParse(_opController.text) ?? 0;
    double wp = double.tryParse(_wpController.text) ?? 0;
    double ap = double.tryParse(_apController.text) ?? 0;

    // Розрахунок коефіцієнтів переходу
    double coefficientDry = calculateCoefficient(wp);
    double coefficientCombustible = calculateCoefficient(wp + ap);

    // Розрахунок компонентів для сухої маси
    double hpDry = calculateMass(hp, coefficientDry);
    double cpDry = calculateMass(cp, coefficientDry);
    double spDry = calculateMass(sp, coefficientDry);
    double npDry = calculateMass(np, coefficientDry);
    double opDry = calculateMass(op, coefficientDry);
    double apDry = calculateMass(ap, coefficientDry);

    // Розрахунок компонентів для горючої маси
    double hpComb = calculateMass(hp, coefficientCombustible);
    double cpComb = calculateMass(cp, coefficientCombustible);
    double spComb = calculateMass(sp, coefficientCombustible);
    double npComb = calculateMass(np, coefficientCombustible);
    double opComb = calculateMass(op, coefficientCombustible);

    // Розрахунок нижчої теплоти згоряння для робочої маси
    double heatWorking = calculateHeat(cp, hp, sp, op, wp);
    // Перерахунок теплоти для сухої маси (без додаткового вмісту золи)
    double heatDry = calculateHeatMass(heatWorking, wp);
    // Перерахунок теплоти для горючої маси (враховуючи золу)
    double heatCombustible = calculateHeatMass(heatWorking, wp, ap);

    // Формування рядка з результатами, включаючи вхідні дані
    setState(() {
      _result = 'Вхідні дані:\n'
          'H: $hp%, C: $cp%, S: $sp%, N: $np%, O: $op%, W: $wp%, A: $ap%\n\n'
          'Коефіцієнти переходу:\n'
          'Робоча -> суха: $coefficientDry\n'
          'Робоча -> горюча: $coefficientCombustible\n\n'
          'Склад сухої маси:\n'
          'H: $hpDry%, C: $cpDry%, S: $spDry%, N: $npDry%, O: $opDry%, A: $apDry%\n\n'
          'Склад горючої маси:\n'
          'H: $hpComb%, C: $cpComb%, S: $spComb%, N: $npComb%, O: $opComb%\n\n'
          'Нижча теплота згоряння:\n'
          'Робоча маса: $heatWorking МДж/кг\n'
          'Суха маса: $heatDry МДж/кг\n'
          'Горюча маса: $heatCombustible МДж/кг';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Калькулятор 1',
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
              controller: _hpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Водень (HP)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _cpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вуглець (CP)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _spController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Сірка (SP)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _npController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Азот (NP)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _opController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Кисень (OP)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _wpController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Вологість (W)'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _apController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Зола (A)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateTask1,
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
