import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection>
    with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<double> _tiltAnimation;

  final List<Map<String, String>> testimonials = const [
    {
      'name': 'John Doe',
      'role': 'CEO, TechCorp',
      'quote':
          'Gufran delivered an exceptional mobile app for us, blending creativity with technical expertise. Highly recommended!',
      'avatar': 'https://via.placeholder.com/100/FF0000/FFFFFF?text=JD',
    },
    {
      'name': 'Jane Smith',
      'role': 'Project Manager, InnovateX',
      'quote':
          'Working with Gufran was a pleasure. His attention to detail and innovative solutions exceeded our expectations.',
      'avatar': 'https://via.placeholder.com/100/00FF00/FFFFFF?text=JS',
    },
    {
      'name': 'Alex Brown',
      'role': 'CTO, StartupHub',
      'quote':
          'Gufran’s ability to turn complex requirements into user-friendly apps is remarkable. A true professional!',
      'avatar': 'https://via.placeholder.com/100/0000FF/FFFFFF?text=AB',
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true);

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
    final testimonialWidth = isMobile ? screenWidth * 0.9 : screenWidth * 0.4;

    return VisibilityDetector(
      key: const Key('testimonials-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_isVisible) {
          setState(() => _isVisible = true);
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
                    child: AnimationLimiter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeInAnimation(child: _buildGlitchHeading('#testimonials')),
                          const SizedBox(height: 16),
                          CarouselSlider(
                            options: CarouselOptions(
                              height: isMobile ? 300 : 350,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 5),
                              enlargeCenterPage: true,
                              viewportFraction: isMobile ? 0.9 : 0.5,
                              enlargeFactor: 0.3,
                              scrollDirection: Axis.horizontal,
                              enableInfiniteScroll: true,
                              autoPlayCurve: Curves.easeInOutCubic,
                            ),
                            items: testimonials.asMap().entries.map((entry) {
                              final index = entry.key;
                              final testimonial = entry.value;
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 600),
                                child: SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: SizedBox(
                                      width: testimonialWidth,
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(
                                              color: Colors.white.withOpacity(0.2)),
                                          color: Colors.grey.shade900,
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: isMobile ? 40 : 50,
                                              backgroundImage:
                                                  NetworkImage(testimonial['avatar']!),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              testimonial['name']!,
                                              style: CyberpunkTextStyles.subheading.copyWith(
                                                fontSize: isMobile ? 14 : 16,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              testimonial['role']!,
                                              style: CyberpunkTextStyles.author.copyWith(
                                                fontSize: isMobile ? 12 : 14,
                                                color: Colors.white70,
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              testimonial['quote']!,
                                              style: CyberpunkTextStyles.quote.copyWith(
                                                fontSize: isMobile ? 12 : 14,
                                                color: Colors.white70,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
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
          );
        },
      ),
    );
  }
}
