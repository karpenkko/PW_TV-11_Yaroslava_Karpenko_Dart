class Equipment {
  String name;
  String efficiency;
  String powerFactor;
  String voltage;
  String quantity;
  String nominalPower;
  String utilizationFactor;
  String reactivePowerFactor;
  String totalPower;
  String current;

  Equipment({
    this.name = "",
    this.efficiency = "",
    this.powerFactor = "",
    this.voltage = "",
    this.quantity = "",
    this.nominalPower = "",
    this.utilizationFactor = "",
    this.reactivePowerFactor = "",
    this.totalPower = "",
    this.current = "",
  });
}

class CalculationState {
  final double groupUtilizationCoefficient;
  final double effectiveEpAmount;
  final PowerCalculations calculatedPower;
  final DepartmentCalculations departmentCalculations;
  final TransformerCalculations transformerCalculations;

  CalculationState({
    this.groupUtilizationCoefficient = 0.0,
    this.effectiveEpAmount = 0.0,
    this.calculatedPower = const PowerCalculations(),
    this.departmentCalculations = const DepartmentCalculations(),
    this.transformerCalculations = const TransformerCalculations(),
  });

  CalculationState copyWith({
    double? groupUtilizationCoefficient,
    double? effectiveEpAmount,
    PowerCalculations? calculatedPower,
    DepartmentCalculations? departmentCalculations,
    TransformerCalculations? transformerCalculations,
  }) {
    return CalculationState(
      groupUtilizationCoefficient: groupUtilizationCoefficient ?? this.groupUtilizationCoefficient,
      effectiveEpAmount: effectiveEpAmount ?? this.effectiveEpAmount,
      calculatedPower: calculatedPower ?? this.calculatedPower,
      departmentCalculations: departmentCalculations ?? this.departmentCalculations,
      transformerCalculations: transformerCalculations ?? this.transformerCalculations,
    );
  }
}

class PowerCalculations {
  final double activeLoad;
  final double reactiveLoad;
  final double fullPower;
  final double groupCurrent;

  const PowerCalculations({
    this.activeLoad = 0.0,
    this.reactiveLoad = 0.0,
    this.fullPower = 0.0,
    this.groupCurrent = 0.0,
  });
}

class DepartmentCalculations {
  final double utilizationCoefficient;
  final double effectiveAmount;

  const DepartmentCalculations({
    this.utilizationCoefficient = 0.0,
    this.effectiveAmount = 0.0,
  });
}

class TransformerCalculations {
  final double activeLoad;
  final double reactiveLoad;
  final double fullPower;
  final double groupCurrent;

  const TransformerCalculations({
    this.activeLoad = 0.0,
    this.reactiveLoad = 0.0,
    this.fullPower = 0.0,
    this.groupCurrent = 0.0,
  });
}