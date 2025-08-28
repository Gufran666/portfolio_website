import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_website/controllers/project_controller.dart';
import 'package:portfolio_website/models/project_model.dart';
import 'package:portfolio_website/providers.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/views/sections/project_detail_dialog.dart';
import 'package:portfolio_website/views/widgets/project_card.dart';
import 'package:portfolio_website/views/widgets/binary_background.dart';
import 'package:visibility_detector/visibility_detector.dart';

class ProjectsSection extends ConsumerStatefulWidget {
  const ProjectsSection({super.key});

  @override
  ConsumerState<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends ConsumerState<ProjectsSection> with SingleTickerProviderStateMixin {
  bool _isVisible = false;
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final projectState = ref.watch(projectsProvider);
    final isMobile = MediaQuery.of(context).size.width < 700;

    ref.listen<Project?>(selectedProjectProvider, (previous, next) {
      if (next != null && previous != next) {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (ctx, anim1, anim2) => ProjectDetailDialog(project: next!),
            transitionsBuilder: (ctx, anim1, anim2, child) {
              final curve = CurvedAnimation(parent: anim1, curve: Curves.easeOutBack);
              return SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(curve),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: FadeTransition(
                    opacity: curve,
                    child: child,
                  ),
                ),
              );
            },
            transitionDuration: const Duration(milliseconds: 600),
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.6),
            fullscreenDialog: true,
          ),
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

    return VisibilityDetector(
      key: const Key('projects-section'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.5 && !_isVisible) {
          setState(() => _isVisible = true);
          _entranceController.forward();
        }
      },
      child: BinaryBackground(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 24, 32, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 500),
                childAnimationBuilder: (widget) => SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
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
                      enableInfiniteScroll: true,
                      autoPlayCurve: Curves.easeInOutCubic,
                      pageSnapping: true,
                    ),
                    items: projectState.state.projects
                        .asMap()
                        .entries
                        .map(
                          (entry) {
                            int index = entry.key;
                            Project project = entry.value;
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 600),
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: SizedBox(
                                    width: isMobile ? MediaQuery.of(context).size.width * 0.9 : 400,
                                    child: ProjectCard(project: project),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

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
}