import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';

class CustomNavbar extends StatelessWidget {
  final void Function(String section) onNavTap;
  final String? activeSection;

  const CustomNavbar({
    super.key,
    required this.onNavTap,
    this.activeSection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF0A0A0A),
        border: Border.all(color: const Color(0xFF1F1F1F)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C7FF).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Portfolio',
              style: GoogleFonts.orbitron(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(color: const Color(0xFF00C7FF).withOpacity(0.8), blurRadius: 10),
                  Shadow(color: const Color(0xFF00C7FF).withOpacity(0.5), blurRadius: 20),
                ],
              ),
            ),
            Flexible(
              child: Wrap(
                spacing: 32,
                alignment: WrapAlignment.end,
                children: [
                  _buildNavItem('Home', 'home'),
                  _buildNavItem('About', 'about'),
                  _buildNavItem('Projects', 'projects'),
                  _buildNavItem('Testimonials', 'testimonials'),
                  _buildNavItem('Contact', 'contact'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, String sectionKey) {
    final isActive = activeSection == sectionKey;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HoverEffect(
        builder: (isHovering) {
          final color = isActive
              ? const Color(0xFF00C7FF)
              : (isHovering ? const Color(0xFF00C7FF) : Colors.white70);

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isHovering
                ? (Matrix4.identity()..scale(1.05))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              boxShadow: [
                if (isHovering || isActive)
                  BoxShadow(
                    color: const Color(0xFF00C7FF).withOpacity(0.7),
                    blurRadius: 15,
                    spreadRadius: 2,
                  ),
              ],
            ),
            child: GestureDetector(
              onTap: () => onNavTap(sectionKey),
              child: Semantics(
                button: true,
                label: '$title section',
                child: Text(
                  title,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: color,
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
