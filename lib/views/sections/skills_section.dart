import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/models/skill_model.dart';
import 'package:portfolio_website/views/widgets/skill_box.dart';
import 'package:visibility_detector/visibility_detector.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<double> _tiltAnimation;
  late final skills = getSkills();

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

    return VisibilityDetector(
      key: const Key('skills-section'),
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
                gradient: LinearGradient(
                  colors: [
                    Colors.purpleAccent.withOpacity(0.3),
                    Colors.blueAccent.withOpacity(0.3),
                    Colors.cyanAccent.withOpacity(0.2),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(40),
                border: Border.all(
                  width: 2,
                  color: Colors.white.withOpacity(0.25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purpleAccent.withOpacity(0.6),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.4),
                    blurRadius: 25,
                    spreadRadius: -5,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                  child: Container(
                    color: Colors.black.withOpacity(0.4),
                    padding: EdgeInsets.all(padding),
                    child: _isVisible
                        ? AnimationLimiter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimationConfiguration.staggeredList(
                                  position: 0,
                                  duration: const Duration(milliseconds: 600),
                                  child: SlideAnimation(
                                    verticalOffset: 50.0,
                                    child: FadeInAnimation(
                                      child: _buildGlitchHeading('#skills'),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Wrap(
                                  spacing: isMobile ? 8 : 16,
                                  runSpacing: isMobile ? 8 : 16,
                                  alignment: WrapAlignment.center,
                                  children: skills
                                      .asMap()
                                      .entries
                                      .map(
                                        (entry) => AnimationConfiguration.staggeredList(
                                          position: entry.key + 1,
                                          duration: const Duration(milliseconds: 600),
                                          child: SlideAnimation(
                                            horizontalOffset: 50.0,
                                            child: FadeInAnimation(
                                              child: SkillBox(category: entry.value),
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),
                          )
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildGlitchHeading('#skills'),
                              const SizedBox(height: 16),
                              Wrap(
                                spacing: isMobile ? 8 : 16,
                                runSpacing: isMobile ? 8 : 16,
                                alignment: WrapAlignment.center,
                                children: skills
                                    .map((e) => SkillBox(category: e))
                                    .toList(),
                              ),
                            ],
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
