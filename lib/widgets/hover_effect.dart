
import 'package:flutter/material.dart';

class HoverEffect extends StatefulWidget {
  final Widget Function(bool isHovering) builder;

  const HoverEffect({super.key, required this.builder});

  @override
  _HoverEffectState createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) => setState(() => _isHovering = true),
      onExit: (event) => setState(() => _isHovering = false),
      child: widget.builder(_isHovering),
    );
  }
}