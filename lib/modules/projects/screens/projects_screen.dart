import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/modules/projects/controllers/project_controller.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';

class ProjectsScreen extends GetView<ProjectsController> {
  final void Function(String projectId)? onProjectTap;

  const ProjectsScreen({super.key, this.onProjectTap});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return BackgroundWidget(
          child: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 32,
                vertical: isMobile ? 24 : 48,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildText('Projects', fontSize: isMobile ? 36 : 48),
                  SizedBox(height: isMobile ? 16 : 24),
                  Expanded(
                    child: Obx(() {
                      if (controller.projects.isEmpty) {
                        return Center(
                          child: Text(
                            'No projects available',
                            style: GoogleFonts.montserrat(
                              fontSize: isMobile ? 14 : 16,
                              color: Colors.white.withOpacity(0.6),
                            ),
                          ),
                        );
                      }
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: isMobile ? 1 : 2,
                          crossAxisSpacing: isMobile ? 8 : 16,
                          mainAxisSpacing: isMobile ? 8 : 16,
                          childAspectRatio: isMobile ? 1.5 : 1.2,
                        ),
                        itemCount: controller.projects.length,
                        itemBuilder: (context, index) {
                          final project = controller.projects[index];
                          return _buildProjectCard(project, isMobile);
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildText(
    String text, {
    required double fontSize,
    Color textColor = Colors.white,
  }) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Text(
        text,
        style: GoogleFonts.montserrat(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isHovering ? Colors.white : textColor.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _buildProjectCard(ProjectModel project, bool isMobile) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => GestureDetector(
        onTap: () => onProjectTap?.call(project.id),
        child: Container(
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isHovering ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (project.imageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    project.imageUrl!,
                    height: isMobile ? 120 : 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: isMobile ? 120 : 150,
                      color: const Color(0xFF2A2A2A),
                      child: Icon(
                        Icons.image_not_supported,
                        size: isMobile ? 40 : 50,
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: isMobile ? 8 : 12),
              Text(
                project.title,
                style: GoogleFonts.montserrat(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: isMobile ? 4 : 8),
              Text(
                project.description,
                style: GoogleFonts.montserrat(
                  fontSize: isMobile ? 12 : 14,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
                maxLines: isMobile ? 2 : 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
