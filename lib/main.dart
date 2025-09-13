import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/routes/app.dart';
import 'package:portfolio_website/routes/app_bindings.dart';

void main() {
  AppBindings.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF121212),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyLarge: GoogleFonts.inter(fontSize: 16, color: Colors.white70),
          bodyMedium: GoogleFonts.inter(fontSize: 14, color: Colors.white70),
        ),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Colors.blueAccent,
          background: const Color(0xFF121212),
        ),
      ),
      home: const PortfolioScreen(), // Your scroll-based layout
      debugShowCheckedModeBanner: false,
    );
  }
}
