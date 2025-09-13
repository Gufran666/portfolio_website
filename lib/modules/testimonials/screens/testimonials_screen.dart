import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/models/testimonial_model.dart';
import 'package:portfolio_website/modules/testimonials/controllers/testimonial_controller.dart';
import 'package:portfolio_website/widgets/background_widget.dart';

class TestimonialsScreen extends GetView<TestimonialsController> {
  const TestimonialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BackgroundWidget(
      child: Container(
        constraints: BoxConstraints(minHeight: screenHeight),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGlowingText('Testimonials', fontSize: 64),
            const SizedBox(height: 48),
            Obx(() => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.testimonials.length,
                  itemBuilder: (context, index) {
                    final testimonial = controller.testimonials[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: _buildTestimonialCard(testimonial),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildGlowingText(
    String text, {
    required double fontSize,
    Color textColor = Colors.white,
    Color glowColor = const Color(0xFF4C00C2),
  }) {
    return Text(
      text,
      style: GoogleFonts.orbitron(
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

  Widget _buildTestimonialCard(TestimonialModel testimonial) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4C00C2).withOpacity(0.4),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C7FF).withOpacity(0.2),
            blurRadius: 30,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF00C7FF).withOpacity(0.5),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00C7FF).withOpacity(0.5),
                  blurRadius: 15,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ClipOval(
              child: testimonial.clientImageUrl != null
                  ? Image.asset(
                      testimonial.clientImageUrl!,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person,
                        size: 80,
                        color: Colors.white70,
                      ),
                    )
                  : const Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.white70,
                    ),
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildGlowingText(
                  testimonial.clientName,
                  fontSize: 24,
                  glowColor: const Color(0xFF00C7FF),
                ),
                if (testimonial.role != null)
                  Text(
                    testimonial.role!,
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      color: Colors.white54,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  testimonial.feedback,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    color: Colors.white70,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
