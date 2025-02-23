import 'package:flutter/material.dart';
import 'calculation_screen.dart';

void main() {
  runApp(const EmissionCalculatorApp());
}

class EmissionCalculatorApp extends StatelessWidget {
  const EmissionCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emission Calculator',
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
      home: const EmissionCalculatorScreen(),
    );
  }
}