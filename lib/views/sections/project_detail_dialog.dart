import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ProjectDetailDialog extends StatefulWidget {
  final Project project;

  const ProjectDetailDialog({super.key, required this.project});

  @override
  State<ProjectDetailDialog> createState() => _ProjectDetailDialogState();
}

class _ProjectDetailDialogState extends State<ProjectDetailDialog> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
    _rotationAnimation = Tween<double>(begin: -0.01, end: 0.01).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: _rotationAnimation,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(_rotationAnimation.value)
                ..rotateX(-_rotationAnimation.value),
              alignment: Alignment.center,
              child: Container(
                width: isMobile ? MediaQuery.of(context).size.width * 0.95 : MediaQuery.of(context).size.width * 0.7,
                height: isMobile ? MediaQuery.of(context).size.height * 0.9 : MediaQuery.of(context).size.height * 0.8,
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
                    child: Stack(
                      children: [
                        SingleChildScrollView(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    widget.project.title,
                                    textStyle: CyberpunkTextStyles.heading.copyWith(fontSize: 28, color: Colors.white),
                                    speed: const Duration(milliseconds: 100),
                                  ),
                                ],
                                totalRepeatCount: 1,
                              ),
                              const SizedBox(height: 16),
                              if (widget.project.images.isNotEmpty)
                                Hero(
                                  tag: 'project-image-${widget.project.title}',
                                  child: CarouselSlider(
                                    options: CarouselOptions(
                                      height: isMobile ? 200 : 300,
                                      autoPlay: true,
                                      autoPlayInterval: const Duration(seconds: 4),
                                      enlargeCenterPage: true,
                                      viewportFraction: 1.0,
                                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                      autoPlayCurve: Curves.easeInOut,
                                    ),
                                    items: widget.project.images
                                        .map(
                                          (img) => ClipRRect(
                                            borderRadius: BorderRadius.circular(16),
                                            child: GestureDetector(
                                              onTap: () {
                                                // Zoom in on tap
                                                showDialog(
                                                  context: context,
                                                  builder: (ctx) => InteractiveViewer(
                                                    child: Image.network(img, fit: BoxFit.contain),
                                                  ),
                                                );
                                              },
                                              child: Image.network(
                                                img,
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                                loadingBuilder: (context, child, loadingProgress) {
                                                  if (loadingProgress == null) return child;
                                                  return const Center(child: CircularProgressIndicator(color: Color(0xFFA020F0)));
                                                },
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              const SizedBox(height: 24),
                              AnimatedTextKit(
                                animatedTexts: [
                                  TypewriterAnimatedText(
                                    widget.project.description,
                                    textStyle: CyberpunkTextStyles.subheading.copyWith(color: Colors.white70),
                                    speed: const Duration(milliseconds: 50),
                                  ),
                                ],
                                totalRepeatCount: 1,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Tech Stack: ${widget.project.techStack}',
                                style: CyberpunkTextStyles.author.copyWith(color: Colors.white),
                              ),
                              const SizedBox(height: 24),
                              if (widget.project.githubUrl.isNotEmpty)
                                ScaleTransition(
                                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                                    CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
                                  ),
                                  child: CustomButton(
                                    text: 'GitHub →',
                                    onPressed: () async {
                                      final uri = Uri.parse(widget.project.githubUrl);
                                      if (await canLaunchUrl(uri)) {
                                        await launchUrl(uri);
                                      }
                                    },
                                    color: const Color(0xFF00FFFF),
                                    textStyle: CyberpunkTextStyles.heading.copyWith(fontSize: 16),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            icon: const Icon(Icons.close, color: Colors.white, size: 32),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}