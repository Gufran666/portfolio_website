import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CyberpunkTextStyles {
  static final heading = GoogleFonts.audiowide(
    textStyle: const TextStyle(
      color: Color(0xFFFF00FF), 
      fontSize: 40,
      fontWeight: FontWeight.w900,
      letterSpacing: 2.0,
      shadows: [
        Shadow(color: Color(0xFFFF00FF), blurRadius: 14),
        Shadow(color: Colors.black, blurRadius: 2),
      ],
    ),
  );

  static final subheading = GoogleFonts.orbitron(
    textStyle: const TextStyle(
      color: Color(0xFFFFFFFF), // Toxic yellow
      fontSize: 24,
      fontWeight: FontWeight.w700,
      letterSpacing: 1.5,
      shadows: [
        Shadow(color: Color(0xFFA020F0), blurRadius: 5),
      ],
    ),
  );

  static final quote = GoogleFonts.orbitron(
    textStyle: const TextStyle(
      color: Color(0xFFFFFFFF), 
      fontSize: 22,
      fontStyle: FontStyle.italic,
      fontWeight: FontWeight.w600,
      shadows: [
        Shadow(color: Color(0xFFFFFFFF), blurRadius: 8),
      ],
    ),
  );

  static final author = GoogleFonts.orbitron(
    textStyle: const TextStyle(
      color: Color(0xFF8800FF), 
      fontSize: 18,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.2,
      shadows: [
        Shadow(color: Color(0xFF8800FF), blurRadius: 6),
      ],
    ),
  );
}
