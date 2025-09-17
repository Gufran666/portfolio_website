import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';
import 'package:portfolio_website/modules/projects/controllers/project_detail_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailScreen extends GetView<ProjectDetailController> {
  const ProjectDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return BackgroundWidget(
          child: SizedBox.expand(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 32,
                  vertical: isMobile ? 24 : 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _buildButton(
                          '← Back',
                          onPressed: () => Get.back(),
                          isMobile: isMobile,
                        ),
                      ],
                    ),
                    SizedBox(height: isMobile ? 16 : 24),
                    _buildText(
                      controller.project.title,
                      fontSize: isMobile ? 36 : 48,
                      fontBuilder: GoogleFonts.montserrat,
                    ),
                    SizedBox(height: isMobile ? 24 : 32),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white.withOpacity(0.2)),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          controller.project.imageUrl ?? 'assets/images/placeholder.jpg',
                          width: double.infinity,
                          height: isMobile ? 200 : 320,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            height: isMobile ? 200 : 320,
                            color: const Color(0xFF2A2A2A),
                            child: const Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isMobile ? 24 : 32),
                    _buildText(
                      'Description',
                      fontSize: isMobile ? 20 : 24,
                      fontBuilder: GoogleFonts.montserrat,
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    Text(
                      controller.project.description,
                      style: GoogleFonts.montserrat(
                        fontSize: isMobile ? 13 : 15,
                        color: Colors.white.withOpacity(0.7),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(height: isMobile ? 24 : 32),
                    _buildText(
                      'Technologies',
                      fontSize: isMobile ? 20 : 24,
                      fontBuilder: GoogleFonts.montserrat,
                    ),
                    SizedBox(height: isMobile ? 8 : 12),
                    Wrap(
                      spacing: isMobile ? 6 : 8,
                      runSpacing: isMobile ? 6 : 8,
                      children: controller.project.technologies.map(_buildTechChip).toList(),
                    ),
                    SizedBox(height: isMobile ? 24 : 32),
                    if (controller.project.githubUrl != null || controller.project.liveUrl != null)
                      _buildText(
                        'Links',
                        fontSize: isMobile ? 20 : 24,
                        fontBuilder: GoogleFonts.montserrat,
                      ),
                    if (controller.project.githubUrl != null || controller.project.liveUrl != null)
                      SizedBox(height: isMobile ? 8 : 12),
                    Row(
                      children: [
                        if (controller.project.githubUrl != null)
                          _buildButton(
                            'GitHub',
                            onPressed: () => _launchUrl(controller.project.githubUrl!),
                            isMobile: isMobile,
                          ),
                        if (controller.project.githubUrl != null && controller.project.liveUrl != null)
                          SizedBox(width: isMobile ? 8 : 12),
                        if (controller.project.liveUrl != null)
                          _buildButton(
                            'Live Demo',
                            onPressed: () => _launchUrl(controller.project.liveUrl!),
                            isMobile: isMobile,
                          ),
                      ],
                    ),
                  ],
                ),
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
    required TextStyle Function({
      double? fontSize,
      FontWeight? fontWeight,
      Color? color,
    }) fontBuilder,
    Color textColor = Colors.white,
  }) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Text(
        text,
        style: fontBuilder(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: isHovering ? Colors.white : textColor.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _buildButton(
    String text, {
    required VoidCallback onPressed,
    required bool isMobile,
  }) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => Material(
        color: isHovering ? const Color(0xFF1E1E1E) : const Color(0xFF121212),
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 24,
              vertical: isMobile ? 10 : 12,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: isHovering ? const Color(0xFFFFD700) : Colors.white.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                fontSize: isMobile ? 13 : 15,
                fontWeight: FontWeight.w600,
                color: isHovering ? const Color(0xFFFFD700) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTechChip(String tech) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        tech,
        style: GoogleFonts.montserrat(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
    );
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Could not launch $url', backgroundColor: Colors.red);
    }
  }
}
