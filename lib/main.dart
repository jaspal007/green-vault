import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_vault/screens/main_screen.dart';
import 'package:green_vault/screens/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: GoogleFonts.merriweather(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.merriweather(color: Colors.indigo),
          bodyMedium: GoogleFonts.merriweather(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: GoogleFonts.merriweather(color: Colors.green),
          titleLarge: GoogleFonts.merriweather(color: Colors.yellow),
          titleMedium: GoogleFonts.merriweather(color: Colors.pink),
          titleSmall: GoogleFonts.merriweather(color: Colors.red),
          headlineLarge: GoogleFonts.merriweather(backgroundColor: Colors.grey),
          headlineMedium:
              GoogleFonts.merriweather(backgroundColor: Colors.orange),
          headlineSmall: GoogleFonts.merriweather(backgroundColor: Colors.red),
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.black),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 300,
        splash: const SplashScreen(),
        nextScreen: const MyHome(),
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 100,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
    );
  }
}
