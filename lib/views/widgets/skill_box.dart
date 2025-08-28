import 'package:flutter/material.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/models/skill_model.dart';

class SkillBox extends StatefulWidget {
  final SkillCategory category;

  const SkillBox({super.key, required this.category});

  @override
  State<SkillBox> createState() => _SkillBoxState();
}

class _SkillBoxState extends State<SkillBox> with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHover(bool hovering) {
    setState(() {
      _isHovered = hovering;
      if (hovering) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final boxWidth = isMobile ? 120.0 : 150.0;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      child: AnimatedBuilder(
        animation: _glowAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _isHovered ? 1.05 : 1.0,
            child: Container(
              width: boxWidth,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
                color: Colors.grey.shade900,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFA020F0).withOpacity(_glowAnimation.value),
                    blurRadius: 12,
                    spreadRadius: 3,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    widget.category.category, // ✅ Corrected field name
                    style: CyberpunkTextStyles.subheading.copyWith(
                      fontSize: isMobile ? 14 : 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 4,
                    runSpacing: 4,
                    children: widget.category.items.map((skill) { // ✅ Corrected field name
                      return Chip(
                        label: Text(
                          skill,
                          style: CyberpunkTextStyles.author.copyWith(
                            fontSize: isMobile ? 10 : 12,
                            color: Colors.white70,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: Colors.purple.shade800.withOpacity(0.8),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
