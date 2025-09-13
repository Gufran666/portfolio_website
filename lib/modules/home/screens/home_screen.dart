import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';
import 'package:portfolio_website/widgets/background_widget.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onViewWork;

  const HomeScreen({super.key, required this.onViewWork});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BackgroundWidget(
      child: Container(
        constraints: BoxConstraints(minHeight: screenHeight),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildGlowingText(
              'Hi, I’m Gufran',
              fontSize: 64,
              fontBuilder: GoogleFonts.orbitron,
            ),
            const SizedBox(height: 16),
            _buildGlowingText(
              'A passionate developer crafting innovative solutions',
              fontSize: 24,
              fontBuilder: GoogleFonts.montserrat,
              glowColor: const Color(0xFF00C7FF),
            ),
            const SizedBox(height: 48),
            _buildGlowingButton(
              'View My Work',
              onPressed: onViewWork,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlowingText(
    String text, {
    required double fontSize,
    required TextStyle Function({
      double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      List<Shadow>? shadows,
    }) fontBuilder,
    Color textColor = Colors.white,
    Color glowColor = const Color(0xFF4C00C2),
  }) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: fontBuilder(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: textColor,
        shadows: [
          Shadow(color: glowColor.withOpacity(0.6), blurRadius: 15),
          Shadow(color: glowColor.withOpacity(0.3), blurRadius: 30),
        ],
      ),
    );
  }

  Widget _buildGlowingButton(String text, {required VoidCallback onPressed}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HoverEffect(
        builder: (isHovering) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isHovering
                ? (Matrix4.identity()..scale(1.05))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: isHovering
                    ? [const Color(0xFF00C7FF), const Color(0xFF4C00C2)]
                    : [const Color(0xFF4C00C2), const Color(0xFF00C7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00C7FF).withOpacity(isHovering ? 0.8 : 0.4),
                  blurRadius: isHovering ? 20 : 10,
                  spreadRadius: isHovering ? 4 : 2,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: const [
                        Shadow(color: Colors.white, blurRadius: 1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
