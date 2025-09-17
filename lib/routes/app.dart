import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio_website/modules/about/screens/about_screen.dart';
import 'package:portfolio_website/modules/contact/screens/contact_screen.dart';
import 'package:portfolio_website/modules/home/controllers/home_controller.dart';
import 'package:portfolio_website/modules/home/screens/home_screen.dart';
import 'package:portfolio_website/modules/projects/screens/project_detail_screen.dart';
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
  final List<String> _sectionNames = ['home', 'about', 'projects', 'testimonials', 'contact'];
  final Map<String, GlobalKey> _sectionKeys = {
    'home': GlobalKey(),
    'about': GlobalKey(),
    'projects': GlobalKey(),
    'testimonials': GlobalKey(),
    'contact': GlobalKey(),
  };
  String _activeSection = 'home';
  bool _isNavbarExpanded = false;
  bool _showProjectDetail = false;
  String? _selectedProjectId;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_updateActiveSection);
    Get.put(HomeController(onViewWorkCallback: () => _navigateToSection('projects')));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_updateActiveSection);
    _scrollController.dispose();
    super.dispose();
  }

  void _updateActiveSection() {
    if (_showProjectDetail) return;
    double scrollPosition = _scrollController.position.pixels;
    String? newActiveSection;

    for (var section in _sectionNames.reversed) {
      final key = _sectionKeys[section];
      final context = key?.currentContext;
      if (context != null) {
        final renderBox = context.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          final offset = renderBox.localToGlobal(Offset.zero).dy;
          if (scrollPosition >= offset - 50) {
            newActiveSection = section;
            break;
          }
        }
      }
    }

    if (newActiveSection != null && newActiveSection != _activeSection) {
      setState(() {
        _activeSection = newActiveSection!;
      });
    }
  }

  void _navigateToSection(String section) {
    setState(() {
      _showProjectDetail = false;
      _selectedProjectId = null;
    });
    final key = _sectionKeys[section];
    if (key?.currentContext != null) {
      final context = key!.currentContext!;
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox != null) {
        final offset = renderBox.localToGlobal(Offset.zero).dy;
        _scrollController.animateTo(
          offset,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    }
    setState(() {
      _isNavbarExpanded = false;
    });
  }

  void _showProjectDetailScreen(String projectId) {
    setState(() {
      _showProjectDetail = true;
      _selectedProjectId = projectId;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isMobile = screenSize.width < 600;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          if (!_showProjectDetail)
            SingleChildScrollView(
              controller: _scrollController,
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    key: _sectionKeys['home'],
                    width: screenSize.width,
                    height: screenSize.height,
                    child: const HomeScreen(),
                  ),
                  SizedBox(
                    key: _sectionKeys['about'],
                    width: screenSize.width,
                    height: screenSize.height,
                    child: const AboutView(),
                  ),
                  SizedBox(
                    key: _sectionKeys['projects'],
                    width: screenSize.width,
                    height: screenSize.height,
                    child: ProjectsScreen(
                      onProjectTap: _showProjectDetailScreen,
                    ),
                  ),
                  SizedBox(
                    key: _sectionKeys['testimonials'],
                    width: screenSize.width,
                    height: screenSize.height,
                    child: const TestimonialsScreen(),
                  ),
                  SizedBox(
                    key: _sectionKeys['contact'],
                    width: screenSize.width,
                    height: screenSize.height,
                    child: const ContactScreen(),
                  ),
                ],
              ),
            ),
          if (_showProjectDetail)
            ProjectDetailScreen(
              key: ValueKey(_selectedProjectId),
            ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Material(
              color: Colors.transparent,
              elevation: 12,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: CustomNavbar(
                  activeSection: _activeSection,
                  onNavTap: _navigateToSection,
                  isMobile: isMobile,
                  isExpanded: _isNavbarExpanded,
                  onToggle: () {
                    setState(() {
                      _isNavbarExpanded = !_isNavbarExpanded;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
