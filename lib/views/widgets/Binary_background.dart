import 'package:flutter/material.dart';

class BinaryBackground extends StatelessWidget {
  final List<Widget> children;

  const BinaryBackground({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.195,
              child: Image.asset(
                'assets/images/cyberpunk.jpeg', 
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),

          ...children,
        ],
      ),
    );
  }
}
