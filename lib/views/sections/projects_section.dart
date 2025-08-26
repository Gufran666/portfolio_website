import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/controllers/project_controller.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/providers.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/views/sections/project_detail_dialog.dart';
import 'package:portfolio_website/views/widgets/project_card.dart';
import 'package:portfolio_website/views/widgets/binary_background.dart';

class ProjectsSection extends ConsumerWidget {
  const ProjectsSection({super.key});

  Widget _buildGlitchHeading(String text) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFFA020F0), Color(0xFFFFFFFF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        style: CyberpunkTextStyles.heading.copyWith(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final projectState = ref.watch(projectsProvider);
    final isMobile = MediaQuery.of(context).size.width < 700;

    ref.listen<Project?>(selectedProjectProvider, (previous, next) {
      if (next != null && previous != next) {
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel: 'Dismiss',
          barrierColor: Colors.black.withOpacity(0.6),
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (ctx, anim1, anim2) => ProjectDetailDialog(project: next),
          transitionBuilder: (ctx, anim1, anim2, child) {
            final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutBack);
            return FadeTransition(
              opacity: curve,
              child: ScaleTransition(
                scale: curve,
                child: child,
              ),
            );
          },
        ).then((_) => ref.read(selectedProjectProvider.notifier).state = null);
      }
    });

    if (projectState.state.status == LoadingStatus.loading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFFA020F0)),
      );
    }

    if (projectState.state.status == LoadingStatus.error) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'Error: ${projectState.state.failure?.message ?? 'Unknown'}',
          style: CyberpunkTextStyles.quote,
        ),
      );
    }

    return BinaryBackground(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGlitchHeading('#projects'),
              const SizedBox(height: 24),
              CarouselSlider(
                options: CarouselOptions(
                  height: isMobile ? 450 : 550,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  enlargeCenterPage: true,
                  viewportFraction: isMobile ? 0.9 : 0.4,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal,
                ),
                items: projectState.state.projects
                    .map(
                      (project) => SizedBox(
                        width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 400,
                        child: ProjectCard(project: project),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}