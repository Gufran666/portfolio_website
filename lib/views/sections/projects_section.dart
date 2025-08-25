

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/controllers/project_controller.dart';
import 'package:portfolio_website/providers.dart';
import 'package:portfolio_website/views/widgets/project_card.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectsProvider);
    final isMobile = MediaQuery.of(context).size.width < 600;

    if (projectState.status == LoadingStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (projectState.status == LoadingStatus.error) {
      return Text('Error: ${projectState.failure?.message ?? 'Unknown'}');
    }

    return Column(
      children: [
        const Text('#projects', style: TextStyle(fontSize: 24, color: Colors.purple)),
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: isMobile ? 1 : 3,
            childAspectRatio: 1.5,
          ),
          itemCount: projectState.projects.length,
          itemBuilder: (context, index) => ProjectCard(project: projectState.projects[index]),
        ),
      ],
    );
  }
}