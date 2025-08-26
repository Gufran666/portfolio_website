import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = Colors.transparent,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    final defaultStyle = GoogleFonts.orbitron(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        shadows: [
          Shadow(
            color: Color(0xFFFFFFFF), 
            blurRadius: 8,
          ),
        ],
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(
            color: Color(0xFFFF00FF), 
            width: 1.5,
          ),
        ),
      ),
      child: Text(
        text,
        style: textStyle ?? defaultStyle,
      ),
    );
  }
}
