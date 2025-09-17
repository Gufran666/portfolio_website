import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';
import 'package:portfolio_website/modules/about/controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 800;
        final double panelHeight = isMobile ? 500 : 600;

        return BackgroundWidget(
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 64,
                  vertical: isMobile ? 32 : 64,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildText('About Me', fontSize: isMobile ? 48 : 64),
                    SizedBox(height: isMobile ? 32 : 48),
                    isMobile
                        ? Column(
                            children: [
                              _buildPortrait(
                                'assets/images/profile.jpg',
                                isMobile,
                                panelHeight,
                              ),
                              SizedBox(height: 24),
                              _buildDescriptionAndSkills(isMobile, panelHeight),
                            ],
                          )
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 4,
                                child: _buildPortrait(
                                  'assets/images/profile.jpg',
                                  isMobile,
                                  panelHeight,
                                ),
                              ),
                              SizedBox(width: 48),
                              Expanded(
                                flex: 6,
                                child: _buildDescriptionAndSkills(
                                  isMobile,
                                  panelHeight,
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildText(
    String text, {
    required double fontSize,
    Color textColor = Colors.white,
  }) {
    return HoverEffect(
      hoverColor: Colors.black,
      builder: (isHovering) => Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.5,
          color: isHovering
              ? Colors.white.withOpacity(0.9)
              : textColor.withOpacity(0.95),
        ),
      ),
    );
  }

  Widget _buildDescriptionAndSkills(bool isMobile, double height) {
    return _buildPanel(
      SizedBox(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'I’m Gufran, a passionate developer with a knack for creating innovative and user-friendly solutions. With 5+ years of experience in Flutter and UI/UX, I specialize in crafting high-quality applications that solve real-world problems. My goal is to deliver seamless experiences that delight clients and users alike.',
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 18 : 20,
                color: Colors.white.withOpacity(0.75),
                height: 1.7,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: isMobile ? 32 : 48),
            _buildText('My Skills', fontSize: isMobile ? 24 : 32),
            SizedBox(height: isMobile ? 16 : 24),
            Obx(() {
              final skills = controller.skills;
              if (skills.isEmpty) {
                return Text(
                  'Loading skills...',
                  style: GoogleFonts.montserrat(
                    fontSize: isMobile ? 14 : 16,
                    color: Colors.white.withOpacity(0.6),
                  ),
                );
              }
              return Wrap(
                spacing: isMobile ? 8 : 12,
                runSpacing: isMobile ? 8 : 12,
                alignment: WrapAlignment.center,
                children: skills
                    .map((skill) => _buildTechChip(skill, isMobile))
                    .toList(),
              );
            }),
          ],
        ),
      ),
      isMobile: isMobile,
    );
  }

  Widget _buildPanel(Widget child, {required bool isMobile}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.15)),
      ),
      child: child,
    );
  }

  Widget _buildPortrait(String imagePath, bool isMobile, double height) {
    final size = isMobile ? height * 0.6 : height;
    return HoverEffect(
      hoverColor: Colors.black,
      builder: (isHovering) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovering
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.2),
            width: 2,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Container(
            color: const Color(0xFF2A2A2A),
            child: Icon(
              Icons.person,
              size: isMobile ? 60 : 100,
              color: Colors.white.withOpacity(0.7),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech, bool isMobile) {
    return HoverEffect(
      hoverColor: Colors.black,
      builder: (isHovering) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: isHovering
                ? Colors.white.withOpacity(0.3)
                : Colors.white.withOpacity(0.2),
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          tech,
          style: GoogleFonts.montserrat(
            fontSize: isMobile ? 13 : 14,
            fontWeight: FontWeight.w500,
            color: isHovering ? Colors.white : Colors.white.withOpacity(0.85),
          ),
        ),
      ),
    );
  }
}
