import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/widgets/background_widget.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/project_detail_controller.dart';

class ProjectDetailScreen extends GetView<ProjectDetailController> {
  const ProjectDetailScreen({super.key});

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
            Row(
              children: [
                _buildGlowingButton(
                  '← Back',
                  onPressed: () => Get.back(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            _buildGlowingText(
              controller.project.title,
              fontSize: 64,
              fontBuilder: GoogleFonts.orbitron,
            ),
            const SizedBox(height: 48),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF4C00C2).withOpacity(0.4),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00C7FF).withOpacity(0.2),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                  BoxShadow(
                    color: const Color(0xFF4C00C2).withOpacity(0.2),
                    blurRadius: 50,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  controller.project.imageUrl,
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 400,
                    color: Colors.grey,
                    child: const Icon(Icons.broken_image, size: 50, color: Colors.white70),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            _buildGlowingText(
              'Description',
              fontSize: 28,
              fontBuilder: GoogleFonts.orbitron,
              glowColor: const Color(0xFF00C7FF),
            ),
            const SizedBox(height: 16),
            Text(
              controller.project.description,
              style: GoogleFonts.montserrat(
                fontSize: 16,
                color: Colors.white70,
                height: 1.5,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 48),
            _buildGlowingText(
              'Technologies',
              fontSize: 28,
              fontBuilder: GoogleFonts.orbitron,
              glowColor: const Color(0xFF00C7FF),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: controller.project.technologies
                  .map((tech) => _buildTechChip(tech))
                  .toList(),
            ),
            const SizedBox(height: 48),
            if (controller.project.githubUrl != null || controller.project.liveUrl != null)
              _buildGlowingText(
                'Links',
                fontSize: 28,
                fontBuilder: GoogleFonts.orbitron,
                glowColor: const Color(0xFF00C7FF),
              ),
            const SizedBox(height: 16),
            Row(
              children: [
                if (controller.project.githubUrl != null)
                  _buildGlowingButton(
                    'GitHub',
                    onPressed: () => _launchUrl(controller.project.githubUrl!),
                  ),
                const SizedBox(width: 16),
                if (controller.project.liveUrl != null)
                  _buildGlowingButton(
                    'Live Demo',
                    onPressed: () => _launchUrl(controller.project.liveUrl!),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlowingText(
    String text, {
    required double fontSize,
    required TextStyle Function({
      double? fontSize,
      FontWeight? fontWeight,
      Color? color,
      List<Shadow>? shadows,
    }) fontBuilder,
    Color textColor = Colors.white,
    Color glowColor = const Color(0xFF4C00C2),
  }) {
    return Text(
      text,
      style: fontBuilder(
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

  Widget _buildGlowingButton(String text, {required VoidCallback onPressed}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: HoverEffect(
        builder: (isHovering) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: isHovering
                ? (Matrix4.identity()..scale(1.05))
                : Matrix4.identity(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                colors: isHovering
                    ? [const Color(0xFF00C7FF), const Color(0xFF4C00C2)]
                    : [const Color(0xFF4C00C2), const Color(0xFF00C7FF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00C7FF).withOpacity(isHovering ? 0.8 : 0.4),
                  blurRadius: isHovering ? 20 : 10,
                  spreadRadius: isHovering ? 4 : 2,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onPressed,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
                  child: Text(
                    text,
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      shadows: const [
                        Shadow(color: Colors.white, blurRadius: 1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
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

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      print('Could not launch $url');
    }
  }
}
