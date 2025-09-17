import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/models/testimonial_model.dart';
import 'package:portfolio_website/modules/testimonials/controllers/testimonial_controller.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';

class TestimonialsScreen extends GetView<TestimonialsController> {
  const TestimonialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return BackgroundWidget(
          child: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 32,
                vertical: isMobile ? 24 : 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText('Testimonials', fontSize: isMobile ? 36 : 48),
                  SizedBox(height: isMobile ? 16 : 24),
                  Expanded(
                    child: Obx(
                      () => Stack(
                        children: [
                          PageView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: controller.pageController,
                            itemCount: controller.testimonials.length,
                            itemBuilder: (context, index) {
                              final testimonial = controller.testimonials[index];
                              return Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 8 : 12,
                                  vertical: isMobile ? 8 : 12,
                                ),
                                child: _buildTestimonialCard(testimonial, isMobile),
                              );
                            },
                          ),
                          if (!isMobile && controller.testimonials.length > 1)
                            Positioned(
                              bottom: 12,
                              left: 0,
                              right: 0,
                              child: _buildCarouselDots(),
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
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
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isHovering ? Colors.white : textColor.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _buildTestimonialCard(TestimonialModel testimonial, bool isMobile) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Container(
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        margin: EdgeInsets.symmetric(horizontal: isMobile ? 8 : 12),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isHovering ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: isMobile ? 50 : 60,
              height: isMobile ? 50 : 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isHovering ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
                ),
              ),
              child: ClipOval(
                child: testimonial.clientImageUrl != null
                    ? Image.asset(
                        testimonial.clientImageUrl!,
                        width: isMobile ? 50 : 60,
                        height: isMobile ? 50 : 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.person,
                          size: isMobile ? 30 : 40,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      )
                    : Icon(
                        Icons.person,
                        size: isMobile ? 30 : 40,
                        color: Colors.white.withOpacity(0.7),
                      ),
              ),
            ),
            SizedBox(width: isMobile ? 12 : 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText(
                    testimonial.clientName,
                    fontSize: isMobile ? 18 : 20,
                  ),
                  if (testimonial.role != null)
                    Text(
                      testimonial.role!,
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 12 : 14,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  SizedBox(height: isMobile ? 8 : 12),
                  Text(
                    testimonial.feedback,
                    style: GoogleFonts.montserrat(
                      fontSize: isMobile ? 12 : 14,
                      color: Colors.white.withOpacity(0.7),
                      height: 1.5,
                    ),
                    textAlign: TextAlign.justify,
                    maxLines: isMobile ? 5 : 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarouselDots() {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          controller.testimonials.length,
          (index) => GestureDetector(
            onTap: () => controller.pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: controller.pageController.page?.round() == index
                    ? const Color(0xFFFFD700)
                    : Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
