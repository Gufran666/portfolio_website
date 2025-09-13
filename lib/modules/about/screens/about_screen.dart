import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BackgroundWidget(
      child: Container(
        constraints: BoxConstraints(minHeight: screenHeight),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGlowingText('About Me', fontSize: 64),
              const SizedBox(height: 48),
              _buildGlowingPanel(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(child: _buildGlowingPortrait('assets/images/profile.jpg')),
                    const SizedBox(height: 32),
                    Text(
                      'I’m Gufran, a passionate developer with a knack for creating innovative and user-friendly solutions. With 5+ years of experience in Flutter and UI/UX, I specialize in crafting high-quality applications that solve real-world problems. My goal is to deliver seamless experiences that delight clients and users alike.',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.white70,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              _buildGlowingText('My Skills', fontSize: 36),
              const SizedBox(height: 24),
              _buildGlowingPanel(
                Obx(() {
                  final skills = controller.skills;
                  if (skills.isEmpty) {
                    return const Text(
                      'Loading skills...',
                      style: TextStyle(color: Colors.white54),
                    );
                  }
                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: skills.map((skill) => _buildTechChip(skill)).toList(),
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGlowingText(String text, {required double fontSize}) {
    return Text(
      text,
      style: GoogleFonts.orbitron(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        shadows: [
          Shadow(color: const Color(0xFF4C00C2).withOpacity(0.6), blurRadius: 15),
          Shadow(color: const Color(0xFF4C00C2).withOpacity(0.3), blurRadius: 30),
        ],
      ),
    );
  }

  Widget _buildGlowingPanel(Widget child) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C7FF).withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildGlowingPortrait(String imagePath) {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFF00C7FF).withOpacity(0.5),
          width: 3,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C7FF).withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: Colors.grey,
            child: const Icon(Icons.person, size: 100, color: Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: const Color(0xFF4C00C2).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C00C2).withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        tech,
        style: GoogleFonts.montserrat(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF00C7FF),
        ),
      ),
    );
  }
}
