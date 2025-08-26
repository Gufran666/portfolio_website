import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/providers.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectCard extends StatefulWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return GestureDetector(
          onTap: () => ref.read(selectedProjectProvider.notifier).state = widget.project,
          child: MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              transform: Matrix4.identity()..scale(_isHovered ? 1.05 : 1.0),
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFA020F0), width: 1.2),
                boxShadow: _isHovered
                    ? [
                        BoxShadow(
                          color: const Color(0xFFA020F0).withOpacity(0.5),
                          blurRadius: 30,
                          spreadRadius: 10,
                        ),
                        BoxShadow(
                          color: const Color(0xFF00FFFF).withOpacity(0.4),
                          blurRadius: 20,
                          spreadRadius: 8,
                        ),
                        BoxShadow(
                          color: const Color(0xFFFF1744).withOpacity(0.3),
                          blurRadius: 15,
                          spreadRadius: 5,
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: const Color(0xFFA020F0).withOpacity(0.3),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.project.images.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.project.images[0],
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 200,
                            color: Colors.purple.shade900,
                            child: const Center(
                              child: CircularProgressIndicator(color: Color(0xFFA020F0)),
                            ),
                          );
                        },
                      ),
                    )
                  else
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.purple.shade900,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purpleAccent.withOpacity(0.4),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'Project Preview',
                        style: CyberpunkTextStyles.subheading.copyWith(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Text(widget.project.title, style: CyberpunkTextStyles.heading.copyWith(color: Colors.white)),
                  const SizedBox(height: 8),
                  Text(widget.project.description, style: CyberpunkTextStyles.subheading.copyWith(color: Colors.white70)),
                  const SizedBox(height: 8),
                  Text('Tech Stack: ${widget.project.techStack}', style: CyberpunkTextStyles.author.copyWith(color: Colors.white)),
                  const SizedBox(height: 16),
                  if (widget.project.githubUrl.isNotEmpty)
                    CustomButton(
                      text: 'GitHub →',
                      onPressed: () async {
                        final uri = Uri.parse(widget.project.githubUrl);
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(uri);
                        }
                      },
                      color: const Color(0xFF00FFFF),
                      textStyle: CyberpunkTextStyles.heading.copyWith(fontSize: 14),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}