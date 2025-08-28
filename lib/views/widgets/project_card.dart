import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _animationController;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;
  final GlobalKey _imageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.6).animate(_animationController);
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () {
            Feedback.forTap(context);
            ref.read(selectedProjectProvider.notifier).state = widget.project;
          },
          child: MouseRegion(
            onEnter: (_) => setState(() {
              _isHovered = true;
              _animationController.forward();
            }),
            onExit: (_) => setState(() {
              _isHovered = false;
              _animationController.reverse();
            }),
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(_isHovered ? 0.02 : 0.0)
                    ..rotateX(_isHovered ? -0.02 : 0.0)
                    ..scale(_isHovered ? 1.05 : 1.0),
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      // Phone frame mockup
                      Container(
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
                            child: Container(),
                          ),
                        ),
                      ),
                      // Content inside "phone"
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (widget.project.images.isNotEmpty)
                              Hero(
                                tag: 'project-image-${widget.project.title}',
                                child: GestureDetector(
                                  onPanUpdate: (details) {
                                    // Simple pan for zoom effect, but limited
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(24),
                                    child: AnimatedScale(
                                      scale: _isHovered ? 1.1 : 1.0,
                                      duration: const Duration(milliseconds: 300),
                                      child: Image.network(
                                        widget.project.images[0],
                                        key: _imageKey,
                                        height: 240,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (context, child, loadingProgress) {
                                          if (loadingProgress == null) return child;
                                          return Container(
                                            height: 240,
                                            color: Colors.purple.shade900,
                                            child: const Center(
                                              child: CircularProgressIndicator(color: Color(0xFFA020F0)),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            else
                              Container(
                                height: 240,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(24),
                                  color: Colors.purple.shade900,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.purpleAccent.withOpacity(0.4),
                                      blurRadius: 12,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Project Preview',
                                  style: CyberpunkTextStyles.subheading.copyWith(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 16),
                            Text(widget.project.title, style: CyberpunkTextStyles.heading.copyWith(color: Colors.white)),
                            const SizedBox(height: 8),
                            Text(widget.project.description, style: CyberpunkTextStyles.subheading.copyWith(color: Colors.white70)),
                            const SizedBox(height: 8),
                            AnimatedOpacity(
                              opacity: _isHovered ? 1.0 : 0.8,
                              duration: const Duration(milliseconds: 300),
                              child: Text('Tech Stack: ${widget.project.techStack}', style: CyberpunkTextStyles.author.copyWith(color: Colors.white)),
                            ),
                            const SizedBox(height: 16),
                            if (widget.project.githubUrl.isNotEmpty)
                              CustomButton(
                                text: 'GitHub →',
                                onPressed: () async {
                                  final uri = Uri.parse(widget.project.githubUrl);
                                  if (await canLaunchUrl(uri)) {
                                    await launchUrl(uri);
                                  }
                                },
                                color: const Color(0xFF00FFFF),
                                textStyle: CyberpunkTextStyles.heading.copyWith(fontSize: 14),
                              ),
                          ],
                        ),
                      ),
                      // Glowing effects
                      Positioned.fill(
                        child: IgnorePointer(
                          child: AnimatedBuilder(
                            animation: _glowAnimation,
                            builder: (context, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFA020F0).withOpacity(_glowAnimation.value),
                                      blurRadius: 30,
                                      spreadRadius: 10,
                                    ),
                                    BoxShadow(
                                      color: const Color(0xFF00FFFF).withOpacity(_glowAnimation.value - 0.2),
                                      blurRadius: 20,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}