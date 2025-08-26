import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderNavigationButton extends StatefulWidget {
  const HeaderNavigationButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSelected = false,
    this.textStyle,
    this.hoverColor,
  });

  final String text;
  final VoidCallback onPressed;
  final bool isSelected;
  final TextStyle? textStyle;
  final Color? hoverColor;

  @override
  State<HeaderNavigationButton> createState() => _HeaderNavigationButtonState();
}

class _HeaderNavigationButtonState extends State<HeaderNavigationButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    final isActive = widget.isSelected || _isHovering;
    final baseColor = isActive
        ? widget.hoverColor ?? const Color(0xFFFF00FF)
        : widget.textStyle?.color ?? Colors.white;

    final effectiveTextStyle = (widget.textStyle ?? GoogleFonts.orbitron(
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    )).copyWith(color: baseColor);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: TextButton(
        onPressed: widget.onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          foregroundColor: baseColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text.toUpperCase(),
              style: effectiveTextStyle,
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              height: 2,
              width: isActive ? 24.0 : 0.0,
              color: baseColor,
            ),
          ],
        ),
      ),
    );
  }
}
