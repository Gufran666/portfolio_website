import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_website/providers.dart';
import 'package:portfolio_website/views/sections/about_section.dart';
import 'package:portfolio_website/views/sections/contacts_section.dart';
import 'package:portfolio_website/views/sections/intro_section.dart';
import 'package:portfolio_website/views/sections/projects_section.dart';
import 'package:portfolio_website/views/sections/skills_section.dart';
import 'package:portfolio_website/views/widgets/header_widget.dart';
import 'package:portfolio_website/views/widgets/binary_background.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});


  static final introSectionKey = GlobalKey();
  static final projectsSectionKey = GlobalKey();
  static final skillsSectionKey = GlobalKey();
  static final aboutSectionKey = GlobalKey();
  static final contactsSectionKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _safeSection(Widget child, String name) {
    try {
      return child;
    } catch (e, stack) {
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
    final homeState = ref.watch(homeProvider);

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
                    introKey: introSectionKey,
                    projectsKey: projectsSectionKey,
                    skillsKey: skillsSectionKey,
                    aboutKey: aboutSectionKey,
                    contactsKey: contactsSectionKey,
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 30),
                  _safeSection(IntroSection(key: introSectionKey), "IntroSection"),
                  const SizedBox(height: 100),
                  _safeSection(ProjectsSection(key: projectsSectionKey), "ProjectsSection"),
                  const SizedBox(height: 100),
                  _safeSection(SkillsSection(key: skillsSectionKey), "SkillsSection"),
                  const SizedBox(height: 100),
                  _safeSection(AboutSection(key: aboutSectionKey), "AboutSection"),
                  const SizedBox(height: 100),
                  _safeSection(ContactsSection(key: contactsSectionKey), "ContactsSection"),
                ]),
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
    return oldDelegate.child != child;
  }
}
