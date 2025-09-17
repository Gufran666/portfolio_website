import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/modules/home/controllers/home_controller.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return BackgroundWidget(
          child: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 64),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => _buildText(
                          controller.heroTitle.value,
                          fontSize: isMobile ? 48 : 72,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.5,
                          textColor: Colors.white,
                        )),
                    SizedBox(height: isMobile ? 16 : 24),
                    Obx(() => _buildText(
                          controller.heroSubtitle.value,
                          fontSize: isMobile ? 28 : 36,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          textColor: Colors.white.withOpacity(0.85),
                        )),
                    SizedBox(height: isMobile ? 20 : 32),
                    Text(
                      'Crafting seamless and delightful experiences through code and design.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 18 : 22,
                        color: Colors.white.withOpacity(0.65),
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: isMobile ? 32 : 48),
                    Obx(() => _buildButton(
                          controller.ctaButtonText.value,
                          onPressed: controller.onViewWork,
                          isMobile: isMobile,
                        )),
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
    required FontWeight fontWeight,
    required double letterSpacing,
    required Color textColor,
  }) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Text(
        text,
        textAlign: TextAlign.center,
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing,
          color: isHovering ? Colors.white : textColor,
          height: 1.2,
        ),
      ),
    );
  }

  Widget _buildButton(
    String text, {
    required VoidCallback onPressed,
    required bool isMobile,
  }) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Material(
        color: isHovering ? const Color(0xFF1E1E1E) : const Color(0xFF121212),
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 20 : 32,
              vertical: isMobile ? 14 : 18,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isHovering ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: isHovering
                  ? [
                      BoxShadow(
                        color: const Color(0xFFFFD700).withOpacity(0.3),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [],
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 16 : 18,
                fontWeight: FontWeight.w600,
                color: isHovering ? const Color(0xFFFFD700) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
