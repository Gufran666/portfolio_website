import 'package:flutter/material.dart';

class BinaryBackground extends StatelessWidget {
  final List<Widget> children;

  const BinaryBackground({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.black, Colors.blueGrey],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        children: children,
      ),
    );
  }
}
