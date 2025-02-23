import 'package:calculator1/screen1.dart';
import 'package:calculator1/screen2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const FuelCalculatorApp());
}

class FuelCalculatorApp extends StatelessWidget {
  const FuelCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор палива',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                child: Text(
                  'Калькулятор 1',
                  style: TextStyle(
                    color: Color(0xFFECECEC),
                      fontSize: 20,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/task1');
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                child: Text(
                  'Калькулятор 2',
                  style: TextStyle(
                    color: Color(0xFFECECEC),
                    fontSize: 20,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/task2');
              },
            ),
          ],
        ),
      ),
    );
  }
}
