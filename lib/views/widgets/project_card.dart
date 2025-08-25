import 'package:flutter/material.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';


class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[900],
      child: Column(
        children: [
          // Placeholder for image (add AssetImage later)
          Container(height: 100, color: Colors.purple), // Replace with project image
          Text(project.title, style: const TextStyle(color: Colors.white, fontSize: 18)),
          Text(project.description, style: const TextStyle(color: Colors.grey)),
          Text(project.techStack, style: const TextStyle(color: Colors.grey)),
          Row(
            children: [
              CustomButton(text: 'Live ->', onPressed: () {} /* Launch URL */),
              if (project.cachedUrl.isNotEmpty)
                CustomButton(text: 'Cached >', onPressed: () {} /* Launch URL */),
            ],
          ),
        ],
      ),
    );
  }
}