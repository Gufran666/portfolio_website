import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';
import 'package:portfolio_website/views/widgets/binary_background.dart';

class IntroSection extends StatelessWidget {
  const IntroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    final headingStyle = GoogleFonts.firaCode(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.bold,
        height: 1.3,
      ),
    );

    final subheadingStyle = GoogleFonts.firaCode(
      textStyle: const TextStyle(
        color: Colors.cyanAccent,
        fontSize: 18,
        height: 1.5,
      ),
    );

    final quoteStyle = GoogleFonts.firaCode(
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontStyle: FontStyle.italic,
        height: 1.4,
      ),
    );

    final authorStyle = GoogleFonts.firaCode(
      textStyle: const TextStyle(
        color: Colors.cyanAccent,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );

    return Stack(
      children: [
        const BinaryBackground(),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.cyanAccent, width: 0.1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Section
              Flex(
                direction: isMobile ? Axis.vertical : Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Text Block
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: isMobile ? 0 : 48,
                        right: isMobile ? 0 : 24,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Elias is a web designer\nand front-end developer',
                            style: headingStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'He crafts responsive websites\nwhere technologies meet creativity',
                            style: subheadingStyle,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 28),
                          CustomButton(
                            text: 'Contact me!!',
                            textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            onPressed: () {},
                            color: Colors.cyanAccent.shade700,
                          ),
                          const SizedBox(height: 32),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.cyanAccent, width: 1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Currently working on Portfolio',
                              style: subheadingStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 32, height: 32),

                  // Image Block
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        'assets/images/elias_photo.png', // Replace with your exported asset
                        width: isMobile ? 220 : 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 64),

              // Quote Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      '"With great power comes great electricity bill"',
                      style: quoteStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '- Dr. Who',
                      style: authorStyle,
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
