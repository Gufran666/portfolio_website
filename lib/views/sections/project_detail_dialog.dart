import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:portfolio_website/models/project_model.dart';
// ignore: unused_import
import 'package:portfolio_website/providers.dart';
import 'package:portfolio_website/views/widgets/custom_button.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:url_launcher/url_launcher.dart';

class ProjectDetailDialog extends StatelessWidget {
  final Project project;

  const ProjectDetailDialog({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: isMobile ? MediaQuery.of(context).size.width * 0.95 : MediaQuery.of(context).size.width * 0.7,
          height: isMobile ? MediaQuery.of(context).size.height * 0.9 : MediaQuery.of(context).size.height * 0.8,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0xFFA020F0), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFA020F0).withOpacity(0.4),
                blurRadius: 30,
                spreadRadius: 8,
              ),
              BoxShadow(
                color: const Color(0xFF00FFFF).withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      project.title,
                      style: CyberpunkTextStyles.heading.copyWith(fontSize: 28, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    if (project.images.isNotEmpty)
                      CarouselSlider(
                        options: CarouselOptions(
                          height: isMobile ? 200 : 300,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 4),
                          enlargeCenterPage: true,
                          viewportFraction: 1.0,
                        ),
                        items: project.images
                            .map(
                              (img) => ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image.network(
                                  img,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  loadingBuilder: (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return const Center(child: CircularProgressIndicator(color: Color(0xFFA020F0)));
                                  },
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    const SizedBox(height: 24),
                    Text(
                      project.description,
                      style: CyberpunkTextStyles.subheading.copyWith(color: Colors.white70),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tech Stack: ${project.techStack}',
                      style: CyberpunkTextStyles.author.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 24),
                    if (project.githubUrl.isNotEmpty)
                      CustomButton(
                        text: 'GitHub →',
                        onPressed: () async {
                          final uri = Uri.parse(project.githubUrl);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          }
                        },
                        color: const Color(0xFF00FFFF),
                        textStyle: CyberpunkTextStyles.heading.copyWith(fontSize: 16),
                      ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 32),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}