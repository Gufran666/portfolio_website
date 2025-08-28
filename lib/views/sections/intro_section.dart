import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';
import 'package:visibility_detector/visibility_detector.dart';

class IntroSection extends StatefulWidget {
  const IntroSection({super.key});

  @override
  State<IntroSection> createState() => _IntroSectionState();
}

class _IntroSectionState extends State<IntroSection>
    with TickerProviderStateMixin {
  late AnimationController _typewriterController;
  late AnimationController _tiltController;
  late Animation<int> _typewriter;
  late Animation<double> _tilt;

  bool _isVisible = false;

  final String quote = '"With great power comes great electricity bill"';

  @override
  void initState() {
    super.initState();

    // typewriter controller
    _typewriterController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );
    _typewriter = StepTween(
      begin: 0,
      end: quote.length,
    ).animate(
      CurvedAnimation(parent: _typewriterController, curve: Curves.easeOut),
    );

    // tilt controller
    _tiltController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat(reverse: true);
    _tilt = Tween<double>(begin: -0.02, end: 0.02).animate(
      CurvedAnimation(parent: _tiltController, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _typewriterController.dispose();
    _tiltController.dispose();
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
    final imageHeight = isMobile ? 300.0 : 430.0;

    return VisibilityDetector(
      key: const Key('intro-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_isVisible) {
          setState(() => _isVisible = true);
          _typewriterController.forward();
        }
      },
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
              padding: EdgeInsets.fromLTRB(padding, 20, padding, padding),
              child: AnimationLimiter(
                child: Column(
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(milliseconds: 600),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      verticalOffset: 50.0,
                      child: FadeInAnimation(child: widget),
                    ),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: padding,
                                right: padding / 2,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildGlitchHeading(
                                    'Gufran is a Mobile Application Developer\nand Software Engineer',
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'He crafts high-end Apps\nwhere technologies meet creativity',
                                    style: CyberpunkTextStyles.subheading.copyWith(
                                      fontSize: isMobile ? 14 : 16,
                                    ),
                                  ),
                                  const SizedBox(height: 24),
                                  CustomButton(
                                    text: 'Contact me!!',
                                    textStyle: CyberpunkTextStyles.heading.copyWith(
                                      fontSize: isMobile ? 16 : 18,
                                      color: Colors.white,
                                    ),
                                    onPressed: () {
                                      Feedback.forTap(context);
                                    },
                                    color: const Color(0xFFA020F0),
                                  ),
                                  const SizedBox(height: 24),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFFA020F0), width: 0.5),
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.transparent,
                                    ),
                                    child: Text(
                                      'Currently working on Portfolio',
                                      style:
                                          CyberpunkTextStyles.subheading.copyWith(
                                        fontSize: isMobile ? 12 : 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: AnimatedBuilder(
                              animation: _tilt,
                              builder: (context, child) {
                                return Transform(
                                  transform: Matrix4.identity()
                                    ..setEntry(3, 2, 0.001)
                                    ..rotateY(_tilt.value)
                                    ..rotateX(-_tilt.value),
                                  alignment: Alignment.center,
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        left: padding / 2, right: padding),
                                    height: imageHeight,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFFA020F0)
                                              .withOpacity(0.05),
                                          blurRadius: 30,
                                          spreadRadius: 6,
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Stack(
                                        fit: StackFit.expand,
                                        children: [
                                          Image.asset(
                                            'assets/images/gufran_image_edited.png',
                                            fit: BoxFit.cover,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.black.withOpacity(0.4),
                                                  Colors.transparent,
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 32),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 28),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white24, width: 1),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.transparent,
                        ),
                        child: Column(
                          children: [
                            AnimatedBuilder(
                              animation: _typewriter,
                              builder: (context, child) {
                                final visibleText =
                                    quote.substring(0, _typewriter.value);
                                return Text(
                                  visibleText,
                                  style: CyberpunkTextStyles.quote.copyWith(
                                    fontSize: isMobile ? 16 : 18,
                                  ),
                                  textAlign: TextAlign.center,
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '- Dr. Who',
                              style: CyberpunkTextStyles.author.copyWith(
                                fontSize: isMobile ? 12 : 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
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
  }
}
