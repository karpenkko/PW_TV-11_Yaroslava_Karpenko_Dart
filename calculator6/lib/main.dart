import 'package:calculator6/view_model.dart';
import 'package:flutter/material.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equipment Calculator',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFECECEC),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: Color(0xFF38140B)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF602E2E)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF38140B),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
        ),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorViewModel _viewModel = CalculatorViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: const Color(0xFFECECEC),
        title: const Text(
          'Калькулятор обладнання',
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
            EquipmentTable(equipmentList: _viewModel.equipmentList),
            CalculateButton(onPressed: () {
              setState(() {
                _viewModel.calculate();
              });
            }),
            CalculationResults(state: _viewModel.calculationState),
            CoefficientInputs(viewModel: _viewModel, onChanged: () {
              setState(() {});
            }),
            TransformerResults(calculations: _viewModel.calculationState.transformerCalculations),
          ],
        ),
      ),
    );
  }
}

class EquipmentTable extends StatefulWidget {
  final List<Equipment> equipmentList;

  const EquipmentTable({super.key, required this.equipmentList});

  @override
  State<EquipmentTable> createState() => _EquipmentTableState();
}

class _EquipmentTableState extends State<EquipmentTable> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFECECEC),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: widget.equipmentList.map((equipment) {
            return Column(
              children: [
                EquipmentParameterRow(
                  label: "Найменування ЕП",
                  value: equipment.name,
                  onValueChange: (value) {
                    setState(() {
                      equipment.name = value;
                    });
                  },
                ),
                EquipmentParameterRow(
                  label: "Номінальне значення ККД",
                  value: equipment.efficiency,
                  onValueChange: (value) {
                    setState(() {
                      equipment.efficiency = value;
                    });
                  },
                ),
                EquipmentParameterRow(
                  label: "Коефіцієнт потужності",
                  value: equipment.powerFactor,
                  onValueChange: (value) {
                    setState(() {
                      equipment.powerFactor = value;
                    });
                  },
                ),
                EquipmentParameterRow(
                  label: "Напруга навантаження",
                  value: equipment.voltage,
                  onValueChange: (value) {
                    setState(() {
                      equipment.voltage = value;
                    });
                  },
                ),
                EquipmentParameterRow(
                  label: "Кількість ЕП",
                  value: equipment.quantity,
                  onValueChange: (value) {
                    setState(() {
                      equipment.quantity = value;
                    });
                  },
                ),
                EquipmentParameterRow(
                  label: "Номінальна потужність",
                  value: equipment.nominalPower,
                  onValueChange: (value) {
                    setState(() {
                      equipment.nominalPower = value;
                    });
                  },
                ),
                EquipmentParameterRow(
                  label: "Коефіцієнт використання",
                  value: equipment.utilizationFactor,
                  onValueChange: (value) {
                    setState(() {
                      equipment.utilizationFactor = value;
                    });
                  },
                ),
                EquipmentParameterRow(
                  label: "Коефіцієнт реактивної потужності",
                  value: equipment.reactivePowerFactor,
                  onValueChange: (value) {
                    setState(() {
                      equipment.reactivePowerFactor = value;
                    });
                  },
                ),
                const Divider(height: 16),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class EquipmentParameterRow extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onValueChange;

  const EquipmentParameterRow({
    super.key,
    required this.label,
    required this.value,
    required this.onValueChange,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(label),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: TextField(
                controller: TextEditingController(text: value),
                onChanged: onValueChange,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CalculateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Align(
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
          child: Text(
            'Обчислити',
            style: TextStyle(
              color: Color(0xFFECECEC),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}

class CalculationResults extends StatelessWidget {
  final CalculationState state;

  const CalculationResults({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResultText("Груповий коефіцієнт використання", state.groupUtilizationCoefficient),
          ResultText("Ефективна кількість ЕП", state.effectiveEpAmount),
          ResultText("Розрахункове активне навантаження", state.calculatedPower.activeLoad),
          ResultText("Розрахункове реактивне навантаження", state.calculatedPower.reactiveLoad),
          ResultText("Повна потужність", state.calculatedPower.fullPower),
          ResultText("Розрахунковий груповий струм", state.calculatedPower.groupCurrent),
        ],
      ),
    );
  }
}

class CoefficientInputs extends StatelessWidget {
  final CalculatorViewModel viewModel;
  final VoidCallback onChanged;

  const CoefficientInputs({
    super.key,
    required this.viewModel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          TextField(
            controller: TextEditingController(text: viewModel.activeCoefficient),
            onChanged: (value) {
              viewModel.activeCoefficient = value;
              onChanged();
            },
            decoration: const InputDecoration(
              labelText: "Розрахунковий коефіцієнт активної потужності",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: TextEditingController(text: viewModel.transformerCoefficient),
            onChanged: (value) {
              viewModel.transformerCoefficient = value;
              onChanged();
            },
            decoration: const InputDecoration(
              labelText: "Коефіцієнт трансформатора",
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}

class TransformerResults extends StatelessWidget {
  final TransformerCalculations calculations;

  const TransformerResults({super.key, required this.calculations});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResultText("Активне навантаження на шинах 0,38 кВ ТП", calculations.activeLoad),
          ResultText("Реактивне навантаження на шинах 0,38 кВ ТП", calculations.reactiveLoad),
          ResultText("Повна потужність на шинах 0,38 кВ ТП", calculations.fullPower),
          ResultText("Розрахунковий груповий струм на шинах 0,38 кВ ТП", calculations.groupCurrent),
        ],
      ),
    );
  }
}

class ResultText extends StatelessWidget {
  final String label;
  final double value;

  const ResultText(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: Text(
              value.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}