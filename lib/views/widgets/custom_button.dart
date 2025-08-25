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
    final defaultStyle = GoogleFonts.firaCode(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
    );

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      child: Text(
        text,
        style: textStyle ?? defaultStyle,
      ),
    );
  }
}
