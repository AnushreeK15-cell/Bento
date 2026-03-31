import 'package:flutter/material.dart';
import 'screens/auth/login_page.dart';

void main() {
  runApp(const BentoApp());
}

class BentoApp extends StatelessWidget {
  const BentoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bento – Smart Canteen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Georgia',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE8470A),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F4),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFE8470A),
          foregroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          titleTextStyle: TextStyle(
            fontFamily: 'Georgia',
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFE8470A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Georgia',
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0D5CF)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE0D5CF)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFE8470A), width: 2),
          ),
          labelStyle: const TextStyle(color: Color(0xFF8A7570)),
          hintStyle: const TextStyle(color: Color(0xFFBBADA8)),
        ),
      ),
      home: const LoginPage(),
    );
  }
}
