import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_website/providers.dart';
import 'package:portfolio_website/views/sections/about_section.dart';
import 'package:portfolio_website/views/sections/certifications_section.dart';
import 'package:portfolio_website/views/sections/contacts_section.dart';
import 'package:portfolio_website/views/sections/intro_section.dart';
import 'package:portfolio_website/views/sections/projects_section.dart';
import 'package:portfolio_website/views/sections/skills_section.dart';
import 'package:portfolio_website/views/sections/testimonials_section.dart';
import 'package:portfolio_website/views/widgets/header_widget.dart';
import 'package:portfolio_website/views/widgets/binary_background.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Small typed container for section metadata (safer than raw Map)
class SectionInfo {
  final int index;
  final GlobalKey key;
  final String title;
  final Widget Function({Key? key}) builder;

  const SectionInfo({
    required this.index,
    required this.key,
    required this.title,
    required this.builder,
  });
}

class HomeView extends ConsumerWidget {
  const HomeView({super.key});

  static final List<SectionInfo> sections = [
    SectionInfo(index: 1, key: GlobalKey(), title: 'Intro', builder: ({Key? key}) => IntroSection(key: key)),
    SectionInfo(index: 2, key: GlobalKey(), title: 'Projects', builder: ({Key? key}) => ProjectsSection(key: key)),
    SectionInfo(index: 3, key: GlobalKey(), title: 'Skills', builder: ({Key? key}) => SkillsSection(key: key)),
    SectionInfo(index: 4, key: GlobalKey(), title: 'Certifications', builder: ({Key? key}) => CertificationsSection(key: key)),
    SectionInfo(index: 5, key: GlobalKey(), title: 'About', builder: ({Key? key}) => AboutSection(key: key)),
    SectionInfo(index: 6, key: GlobalKey(), title: 'Testimonials', builder: ({Key? key}) => TestimonialsSection(key: key)),
    SectionInfo(index: 7, key: GlobalKey(), title: 'Contacts', builder: ({Key? key}) => ContactsSection(key: key)),
  ];

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  Widget _safeSection(Widget child, String name) {
    try {
      return child;
    } catch (e, stack) {
      // Log & return a friendly error box instead of letting the failure crash the app.
      debugPrint("⚠️ Error building $name: $e\n$stack");
      return Container(
        height: 100,
        color: Colors.red,
        alignment: Alignment.center,
        child: Text(
          "Error loading $name",
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Compute environment once for the whole build
    final media = MediaQuery.of(context);
    final isMobile = media.size.width < 700;
    final screenWidth = media.size.width;
    final sectionPadding = isMobile ? 16.0 : screenWidth * 0.05;
    final sectionHeightFactor = isMobile ? 0.8 : 1.0;
    final totalSections = sections.length;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BinaryBackground(
        children: [
          CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverHeaderDelegate(
                  child: HeaderWidget(
                    onNavigate: _scrollToSection,
                    sections: sections,
                  ),
                ),
              ),

              // Use a lazy SliverChildBuilderDelegate instead of building the whole list at once.
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final section = sections[index];

                    // Per-item animation + visibility detection
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 600),
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: FadeInAnimation(
                          child: VisibilityDetector(
                            key: ValueKey('section-${section.title}'),
                            onVisibilityChanged: (info) {
                              // Reserved spot to trigger behaviors when a section becomes visible.
                              // Keep this lightweight: avoid heavy work here.
                              if (info.visibleFraction > 0.5) {
                                // Optionally notify providers, analytics, etc.
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: sectionPadding,
                                vertical: isMobile ? 20 : 40,
                              ),
                              height: media.size.height * sectionHeightFactor,
                              child: _safeSection(
                                // Use the typed builder to create the section widget with the stored key.
                                section.builder(key: section.key),
                                section.title,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: totalSections,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverHeaderDelegate({required this.child});

  @override
  double get minExtent => 70;
  @override
  double get maxExtent => 70;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  bool shouldRebuild(covariant _SliverHeaderDelegate oldDelegate) {
    // Rebuild only when the child instance changed (rare)
    return oldDelegate.child != child;
  }
}
