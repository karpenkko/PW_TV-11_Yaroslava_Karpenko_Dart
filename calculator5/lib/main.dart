import 'package:calculator5/screen1.dart';
import 'package:calculator5/screen2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const CurrentCalculatorApp());
}

class CurrentCalculatorApp extends StatelessWidget {
  const CurrentCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор струму',
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
      home: const HomeScreen(),
      routes: {
        '/task1': (context) => const Task1Screen(),
        '/task2': (context) => const Task2Screen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CalculatorButton(
                text: 'Розрахунок надійності',
                onPressed: () {
                  Navigator.pushNamed(context, '/task1');
                },
              ),
              const SizedBox(height: 30),
              CalculatorButton(
                text: 'Розрахунок збитків',
                onPressed: () {
                  Navigator.pushNamed(context, '/task2');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xFFECECEC),
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
