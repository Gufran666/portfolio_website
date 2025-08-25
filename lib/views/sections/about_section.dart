import 'package:flutter/material.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: MediaQuery.of(context).size.width < 600 ? Axis.vertical : Axis.horizontal,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('#about-me', style: TextStyle(fontSize: 24, color: Colors.purple)),
            Text('About me text here...'), // Add your actual bio
          ],
        ),
        // Placeholder for image
        Image.network('https://example.com/about-photo.png', width: 200),
      ],
    );
  }
}