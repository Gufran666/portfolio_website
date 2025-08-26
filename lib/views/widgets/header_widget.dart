import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/core/app_assets.dart';
import 'header_navigation_button.dart';

class HeaderWidget extends StatelessWidget {
  final void Function(GlobalKey key) onNavigate;
  final GlobalKey introKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey aboutKey;
  final GlobalKey contactsKey;

  const HeaderWidget({
    super.key,
    required this.onNavigate,
    required this.introKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.aboutKey,
    required this.contactsKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border.all(color: const Color(0xFF800080), width: 0.3), 
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF00FF).withOpacity(0.3),
            blurRadius: 12,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          
          Container(
            margin: const EdgeInsets.only(left: 20),
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              AppAssets.logo,
              width: 100,
              height: 48,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, color: Color(0xFFFF1744)), 
            ),
          ),

        
          Row(
            children: [
              _navButton("Home", () => onNavigate(introKey)),
              _navButton("Projects", () => onNavigate(projectsKey)),
              _navButton("Skills", () => onNavigate(skillsKey)),
              _navButton("About", () => onNavigate(aboutKey)),
              _navButton("Contact", () => onNavigate(contactsKey)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _navButton(String label, VoidCallback onPressed) {
    return HeaderNavigationButton(
      text: label,
      onPressed: onPressed,
      textStyle: GoogleFonts.orbitron(
        textStyle: const TextStyle(
          color: Color(0xFFFFFFFF), 
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
      hoverColor: const Color(0xFFFF1744), 
    );
  }
}
