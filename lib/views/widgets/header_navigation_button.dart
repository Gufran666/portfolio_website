import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderNavigationButton extends StatefulWidget {
  const HeaderNavigationButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isSelected;

  @override
  State<HeaderNavigationButton> createState() => _HeaderNavigationButtonState();
}

class _HeaderNavigationButtonState extends State<HeaderNavigationButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final color = widget.isSelected || _isHovering ? Colors.cyan : Colors.white;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          foregroundColor: color,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: GoogleFonts.firaCode(
                textStyle: TextStyle(
                  fontSize: 16,
                  color: color,
                ),
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: 2,
              width: _isHovering || widget.isSelected ? 24.0 : 0.0,
              color: color,
            ),
          ],
        ),
      ),
    );
  }
}
