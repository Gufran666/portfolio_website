import 'package:flutter/material.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';
import 'package:portfolio_website/views/widgets/binary_background.dart';

class IntroSection extends StatefulWidget {
  const IntroSection({super.key});

  @override
  State<IntroSection> createState() => _IntroSectionState();
}

class _IntroSectionState extends State<IntroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _typewriter;

  final String quote = '"With great power comes great electricity bill"';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..forward();

    _typewriter = StepTween(
      begin: 0,
      end: quote.length,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
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

    return BinaryBackground(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            32,
            20, // 🔹 No extra top padding
            32,
            32,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 48,
                        right: 16,
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
                            style: CyberpunkTextStyles.subheading,
                          ),
                          const SizedBox(height: 24),
                          CustomButton(
                            text: 'Contact me!!',
                            textStyle: CyberpunkTextStyles.heading.copyWith(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                            onPressed: () {},
                            color: const Color(0xFFA020F0),
                          ),
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Color(0xFFA020F0),
                                width: 0.5,
                              ),
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.transparent,
                            ),
                            child: Text(
                              'Currently working on Portfolio',
                              style: CyberpunkTextStyles.subheading,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin: const EdgeInsets.only(left: 24, right: 32),
                      height: isMobile ? 300 : 430, // 🔹 Fixed height
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFA020F0).withOpacity(0.05),
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
                              'assets/images/gufran_image.png',
                              fit: BoxFit.cover, // 🔹 Fill the box neatly
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
                  ),
                ],
              ),

              const SizedBox(height: 32),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
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
                        final visibleText = quote.substring(
                          0,
                          _typewriter.value,
                        );
                        return Text(
                          visibleText,
                          style: CyberpunkTextStyles.quote,
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '- Dr. Who',
                      style: CyberpunkTextStyles.author,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
