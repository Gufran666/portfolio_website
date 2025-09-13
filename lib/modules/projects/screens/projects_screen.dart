import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/modules/projects/controllers/project_controller.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';

class ProjectsScreen extends GetView<ProjectsController> {
  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return BackgroundWidget(
      child: Container(
        constraints: BoxConstraints(minHeight: screenHeight),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGlowingText('My Projects', fontSize: 64),
            const SizedBox(height: 24),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 450,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  childAspectRatio: 0.8,
                ),
                itemCount: controller.projects.length,
                itemBuilder: (context, index) {
                  final project = controller.projects[index];
                  return _buildProjectCard(project);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlowingText(
    String text, {
    required double fontSize,
    Color textColor = Colors.white,
    Color glowColor = const Color(0xFF4C00C2),
  }) {
    return Text(
      text,
      textAlign: TextAlign.start,
      style: GoogleFonts.orbitron(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        color: textColor,
        shadows: [
          Shadow(color: glowColor.withOpacity(0.6), blurRadius: 15),
          Shadow(color: glowColor.withOpacity(0.3), blurRadius: 30),
        ],
      ),
    );
  }

  Widget _buildProjectCard(ProjectModel project) {
    return HoverEffect(
      builder: (isHovering) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
          transform: isHovering
              ? (Matrix4.identity()..translate(0.0, -10.0))
              : Matrix4.identity(),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isHovering
                  ? const Color(0xFF00C7FF).withOpacity(0.8)
                  : Colors.white10,
              width: 2,
            ),
            gradient: LinearGradient(
              colors: [
                Colors.black.withOpacity(0.4),
                Colors.black.withOpacity(0.2),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00C7FF).withOpacity(isHovering ? 0.6 : 0.2),
                blurRadius: isHovering ? 25 : 10,
                spreadRadius: isHovering ? 3 : 1,
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () => Get.toNamed('/project-detail', arguments: project),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
                  child: Image.asset(
                    project.imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Colors.grey,
                      child: const Icon(Icons.broken_image, size: 50, color: Colors.white70),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        project.title,
                        style: GoogleFonts.orbitron(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              color: const Color(0xFF00C7FF).withOpacity(0.5),
                              blurRadius: 5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        project.description,
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          color: Colors.white70,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: project.technologies.map(_buildTechChip).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        border: Border.all(color: const Color(0xFF4C00C2).withOpacity(0.5)),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4C00C2).withOpacity(0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Text(
        tech,
        style: GoogleFonts.montserrat(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: const Color(0xFF00C7FF),
        ),
      ),
    );
  }
}
