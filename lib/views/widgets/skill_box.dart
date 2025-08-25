import 'package:flutter/material.dart';
import '../../models/skill_model.dart';

class SkillBox extends StatelessWidget {
  final SkillCategory category;

  const SkillBox({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.purple)),
      child: Column(
        children: [
          Text(category.category, style: const TextStyle(color: Colors.white)),
          ...category.items.map((item) => Text(item, style: const TextStyle(color: Colors.grey))),
        ],
      ),
    );
  }
}