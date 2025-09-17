import 'package:flutter/material.dart';

class HoverEffect extends StatefulWidget {
  final Widget Function(bool isHovering) builder;
  final Color? hoverColor;
  final bool enableTouch;

  const HoverEffect({
    super.key,
    required this.builder,
    this.hoverColor,
    this.enableTouch = true,
  });

  @override
  _HoverEffectState createState() => _HoverEffectState();
}

class _HoverEffectState extends State<HoverEffect> {
  bool _isHovering = false;
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      child: GestureDetector(
        onTapDown: isMobile && widget.enableTouch ? (_) => setState(() => _isTapped = true) : null,
        onTapUp: isMobile && widget.enableTouch ? (_) => setState(() => _isTapped = false) : null,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              if (_isHovering || _isTapped)
                BoxShadow(
                  color: widget.hoverColor?.withOpacity(0.2) ?? const Color(0xFFFFD700).withOpacity(0.2),
                  blurRadius: 6,
                  spreadRadius: 1,
                ),
            ],
          ),
          child: widget.builder(_isHovering || _isTapped),
        ),
      ),
    );
  }
}