import 'package:flutter/material.dart';
import 'package:portfolio_website/modules/about/screens/about_screen.dart';
import 'package:portfolio_website/modules/contact/screens/contact_screen.dart';
import 'package:portfolio_website/modules/home/screens/home_screen.dart';
import 'package:portfolio_website/modules/projects/screens/projects_screen.dart';
import 'package:portfolio_website/modules/testimonials/screens/testimonials_screen.dart';
import 'package:portfolio_website/widgets/custom_nav_bar.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey testimonialsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  String currentSection = 'home';

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScrollSpy);
  }

  void _handleScrollSpy() {
    final scrollY = _scrollController.offset;

    final positions = {
      'home': _getOffset(homeKey),
      'about': _getOffset(aboutKey),
      'projects': _getOffset(projectsKey),
      'testimonials': _getOffset(testimonialsKey),
      'contact': _getOffset(contactKey),
    };

    for (final entry in positions.entries) {
      final offset = entry.value;
      if (offset != null && scrollY >= offset - 100) {
        if (currentSection != entry.key) {
          setState(() => currentSection = entry.key);
        }
      }
    }
  }

  double? _getOffset(GlobalKey key) {
    final context = key.currentContext;
    if (context == null) return null;
    final box = context.findRenderObject();
    if (box is RenderBox && box.hasSize) {
      final scrollBox = context.findAncestorRenderObjectOfType<RenderBox>();
      final offset = box.localToGlobal(Offset.zero, ancestor: scrollBox).dy;
      return offset;
    }
    return null;
  }

  void scrollTo(GlobalKey key) {
    final offset = _getOffset(key);
    if (offset != null) {
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomNavbar(
            onNavTap: (section) {
              switch (section) {
                case 'home': scrollTo(homeKey); break;
                case 'about': scrollTo(aboutKey); break;
                case 'projects': scrollTo(projectsKey); break;
                case 'testimonials': scrollTo(testimonialsKey); break;
                case 'contact': scrollTo(contactKey); break;
              }
            },
            activeSection: currentSection,
          ),
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  Container(
                    key: homeKey,
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: HomeScreen(onViewWork: () => scrollTo(projectsKey)),
                  ),
                  Container(
                    key: aboutKey,
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: const AboutView(),
                  ),
                  Container(
                    key: projectsKey,
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: const ProjectsScreen(),
                  ),
                  Container(
                    key: testimonialsKey,
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: const TestimonialsScreen(),
                  ),
                  Container(
                    key: contactKey,
                    padding: const EdgeInsets.symmetric(vertical: 64),
                    child: const ContactScreen(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
