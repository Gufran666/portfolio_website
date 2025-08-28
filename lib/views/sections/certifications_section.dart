import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CertificationsSection extends StatefulWidget {
  const CertificationsSection({super.key});

  @override
  State<CertificationsSection> createState() => _CertificationsSectionState();
}

class _CertificationsSectionState extends State<CertificationsSection>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<double> _tiltAnimation;

  final List<Map<String, String>> certifications = const [
    {
      'title': 'Flutter Certified Developer',
      'issuer': 'Google',
      'year': '2024',
      'image': 'https://via.placeholder.com/300x200/FF0000/FFFFFF?text=Flutter+Cert',
    },
    {
      'title': 'AWS Certified Solutions Architect',
      'issuer': 'Amazon Web Services',
      'year': '2023',
      'image': 'https://via.placeholder.com/300x200/00FF00/FFFFFF?text=AWS+Cert',
    },
    {
      'title': 'Professional Scrum Master I',
      'issuer': 'Scrum.org',
      'year': '2022',
      'image': 'https://via.placeholder.com/300x200/0000FF/FFFFFF?text=Scrum+Cert',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true); // continuous gentle tilt

    _tiltAnimation = Tween<double>(begin: -0.01, end: 0.01).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildGlitchHeading(String text) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFA020F0), Color(0xFFFFFFFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: CyberpunkTextStyles.heading.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final screenWidth = MediaQuery.of(context).size.width;
    final padding = isMobile ? 16.0 : screenWidth * 0.05;
    final certWidth = isMobile ? screenWidth * 0.8 : screenWidth * 0.3;

    return VisibilityDetector(
      key: const Key('certifications-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_isVisible) {
          setState(() => _isVisible = true);
          // Removed _controller.forward(); it already repeats continuously.
        }
      },
      child: AnimatedBuilder(
        animation: _tiltAnimation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(_tiltAnimation.value)
              ..rotateX(-_tiltAnimation.value),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                border: Border.all(color: Colors.white.withOpacity(0.2), width: 4),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
                color: Colors.grey.shade900,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Padding(
                    padding: EdgeInsets.all(padding),
                    // FIX: Use AnimationLimiter + toStaggeredList (correct API)
                    child: AnimationLimiter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: AnimationConfiguration.toStaggeredList(
                          duration: const Duration(milliseconds: 600),
                          childAnimationBuilder: (widget) => SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(child: widget),
                          ),
                          children: [
                            _buildGlitchHeading('#certifications'),
                            const SizedBox(height: 16),
                            CarouselSlider(
                              options: CarouselOptions(
                                height: isMobile ? 350 : 400,
                                autoPlay: true,
                                autoPlayInterval: const Duration(seconds: 5),
                                enlargeCenterPage: true,
                                viewportFraction: isMobile ? 0.9 : 0.4,
                                enlargeFactor: 0.3,
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: true,
                                autoPlayCurve: Curves.easeInOutCubic,
                              ),
                              items: certifications.asMap().entries.map((entry) {
                                final index = entry.key;
                                final cert = entry.value;
                                // Keep a simple slide+fade for each item; no nested staggeredList misuse
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 500),
                                  child: SlideAnimation(
                                    horizontalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: Container(
                                        width: certWidth,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.white.withOpacity(0.2)),
                                          color: Colors.grey.shade900,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(12),
                                              child: Image.network(
                                                cert['image']!,
                                                height: isMobile ? 150 : 200,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return const Center(
                                                    child: CircularProgressIndicator(
                                                      color: Color(0xFFA020F0),
                                                    ),
                                                  );
                                                },
                                                errorBuilder: (context, error, stack) => Container(
                                                  height: isMobile ? 150 : 200,
                                                  alignment: Alignment.center,
                                                  child: const Icon(Icons.broken_image),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              cert['title']!,
                                              style: CyberpunkTextStyles.subheading.copyWith(
                                                fontSize: isMobile ? 14 : 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              'Issuer: ${cert['issuer']}',
                                              style: CyberpunkTextStyles.author.copyWith(
                                                fontSize: isMobile ? 12 : 14,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Year: ${cert['year']}',
                                              style: CyberpunkTextStyles.author.copyWith(
                                                fontSize: isMobile ? 12 : 14,
                                                color: Colors.white70,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
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
