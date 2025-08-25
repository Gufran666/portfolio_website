import 'package:flutter/material.dart';
import '../../../models/skill_model.dart';
import '../widgets/skill_box.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final skills = getSkills();
    return Column(
      children: [
        const Text('#skills', style: TextStyle(fontSize: 24, color: Colors.purple)),
        Wrap(
          spacing: 16,
          children: skills.map((cat) => SkillBox(category: cat)).toList(),
        ),
      ],
    );
  }
}