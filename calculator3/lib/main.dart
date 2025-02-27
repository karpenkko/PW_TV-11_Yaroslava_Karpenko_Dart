import 'package:flutter/material.dart';
import 'package:untitled/power_profit_calculator.dart';

void main() {
  runApp(const SolarPowerProfitApp());
}

class SolarPowerProfitApp extends StatelessWidget {
  const SolarPowerProfitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Solar Power Profit Calculator',
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
      home: const SolarPowerProfitCalculator(),
    );
  }
}