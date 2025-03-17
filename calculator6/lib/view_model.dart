import 'dart:math';
import 'data.dart';

class CalculatorViewModel {
  List<Equipment> equipmentList = getInitialEquipmentList();
  CalculationState calculationState = CalculationState();
  String activeCoefficient = "1.25";
  String transformerCoefficient = "0.7";

  void calculateEquipmentParameters() {
    double sumOfPowerProduct = 0.0;
    double sumOfPowerUtilProduct = 0.0;
    double sumOfSquaredPowerProduct = 0.0;

    for (final equipment in equipmentList) {
      final quantity = double.tryParse(equipment.quantity) ?? 0.0;
      final power = double.tryParse(equipment.nominalPower) ?? 0.0;
      final totalPower = quantity * power;

      equipment.totalPower = totalPower.toString();
      equipment.current = calculateCurrent(
        totalPower,
        double.tryParse(equipment.voltage) ?? 0.38,
        double.tryParse(equipment.powerFactor) ?? 0.9,
        double.tryParse(equipment.efficiency) ?? 0.92,
      ).toString();

      sumOfPowerProduct += totalPower;
      sumOfPowerUtilProduct += totalPower * (double.tryParse(equipment.utilizationFactor) ?? 0.0);
      sumOfSquaredPowerProduct += quantity * power * power;
    }

    updateCalculationState(sumOfPowerProduct, sumOfPowerUtilProduct, sumOfSquaredPowerProduct);
  }

  double calculateCurrent(double power, double voltage, double powerFactor, double efficiency) {
    return roundToTwoDecimalPlaces(power / (sqrt(3.0) * voltage * powerFactor * efficiency));
  }

  void updateCalculationState(
      double totalPower,
      double totalPowerUtil,
      double totalSquaredPower,
      ) {
    final groupUtilCoef = roundToTwoDecimalPlaces(totalPowerUtil / totalPower);
    final effectiveAmount = roundToTwoDecimalPlaces((totalPower * totalPower) / totalSquaredPower);

    final activeCoef = double.tryParse(activeCoefficient) ?? 1.25;
    const voltage = 0.38;
    const nominalPower = 23.0;
    const tangentPhi = 1.58;

    final activeLoad = roundToTwoDecimalPlaces(activeCoef * totalPowerUtil);
    final reactiveLoad = roundToTwoDecimalPlaces(groupUtilCoef * nominalPower * tangentPhi);
    final fullPower = roundToTwoDecimalPlaces(sqrt(activeLoad * activeLoad + reactiveLoad * reactiveLoad));
    final groupCurrent = roundToTwoDecimalPlaces(activeLoad / voltage);

    calculationState = calculationState.copyWith(
      groupUtilizationCoefficient: groupUtilCoef,
      effectiveEpAmount: effectiveAmount,
      calculatedPower: PowerCalculations(
        activeLoad: activeLoad,
        reactiveLoad: reactiveLoad,
        fullPower: fullPower,
        groupCurrent: groupCurrent,
      ),
      departmentCalculations: const DepartmentCalculations(
        utilizationCoefficient: 752.0 / 2330.0,
        effectiveAmount: 2330.0 * 2330.0 / 96399.0,
      ),
    );

    calculateTransformerParameters();
  }

  void calculateTransformerParameters() {
    final coefficient = double.tryParse(transformerCoefficient) ?? 0.7;
    final activeLoad = roundToTwoDecimalPlaces(coefficient * 752.0);
    final reactiveLoad = roundToTwoDecimalPlaces(coefficient * 657.0);
    final fullPower = roundToTwoDecimalPlaces(sqrt(activeLoad * activeLoad + reactiveLoad * reactiveLoad));
    final groupCurrent = roundToTwoDecimalPlaces(activeLoad / 0.38);

    calculationState = calculationState.copyWith(
      transformerCalculations: TransformerCalculations(
        activeLoad: activeLoad,
        reactiveLoad: reactiveLoad,
        fullPower: fullPower,
        groupCurrent: groupCurrent,
      ),
    );
  }

  void calculate() {
    calculateEquipmentParameters();
  }

  double roundToTwoDecimalPlaces(double value) {
    return double.parse((value).toStringAsFixed(2));
  }
}

List<Equipment> getInitialEquipmentList() {
  return [
    Equipment(
      name: "Шліфувальний верстат",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "4",
      nominalPower: "20",
      utilizationFactor: "0.15",
      reactivePowerFactor: "1.33",
    ),
    Equipment(
      name: "Свердлильний верстат",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "2",
      nominalPower: "14",
      utilizationFactor: "0.12",
      reactivePowerFactor: "1",
    ),
    Equipment(
      name: "Фугувальний верстат",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "4",
      nominalPower: "42",
      utilizationFactor: "0.15",
      reactivePowerFactor: "1.33",
    ),
    Equipment(
      name: "Циркулярна пила",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "1",
      nominalPower: "36",
      utilizationFactor: "0.3",
      reactivePowerFactor: "1.52",
    ),
    Equipment(
      name: "Прес",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "1",
      nominalPower: "20",
      utilizationFactor: "0.5",
      reactivePowerFactor: "0.75",
    ),
    Equipment(
      name: "Полірувальний верстат",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "1",
      nominalPower: "40",
      utilizationFactor: "0.2",
      reactivePowerFactor: "1",
    ),
    Equipment(
      name: "Фрезерний верстат",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "2",
      nominalPower: "32",
      utilizationFactor: "0.2",
      reactivePowerFactor: "1",
    ),
    Equipment(
      name: "Вентилятор",
      efficiency: "0.92",
      powerFactor: "0.9",
      voltage: "0.38",
      quantity: "1",
      nominalPower: "20",
      utilizationFactor: "0.65",
      reactivePowerFactor: "0.75",
    ),
  ];
}