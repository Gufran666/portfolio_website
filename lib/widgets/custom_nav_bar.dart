import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio_website/widgets/hover_effect.dart';

class CustomNavbar extends StatelessWidget {
  final void Function(String section) onNavTap;
  final String activeSection;
  final bool isMobile;
  final bool isExpanded;
  final VoidCallback onToggle;

  const CustomNavbar({
    super.key,
    required this.onNavTap,
    required this.activeSection,
    required this.isMobile,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildLogo(),
                    if (isMobile) _buildMobileMenuButton() else _buildDesktopNav(),
                  ],
                ),
              ),
            ),
          ),
          if (isExpanded && isMobile)
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildMobileMenuOverlay(context),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Text(
      'Gufran.dev',
      style: GoogleFonts.montserrat(
        fontSize: isMobile ? 22 : 26,
        fontWeight: FontWeight.w700,
        color: const Color(0xFFFFD700),
        letterSpacing: 1.2,
      ),
    );
  }

  Widget _buildDesktopNav() {
    final navItems = [
      {'title': 'Home', 'key': 'home'},
      {'title': 'About', 'key': 'about'},
      {'title': 'Projects', 'key': 'projects'},
      {'title': 'Testimonials', 'key': 'testimonials'},
      {'title': 'Contact', 'key': 'contact'},
    ];

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: navItems.map((item) {
        return _NavItem(
          title: item['title']!,
          isActive: activeSection == item['key'],
          onTap: () => onNavTap(item['key']!),
          isMobile: false,
        );
      }).toList(),
    );
  }

  Widget _buildMobileMenuButton() {
    return GestureDetector(
      onTap: onToggle,
      child: Icon(
        isExpanded ? Icons.close : Icons.menu,
        color: Colors.white,
        size: isMobile ? 26 : 30,
      ),
    );
  }

  Widget _buildMobileMenuOverlay(BuildContext context) {
    final navItems = [
      {'title': 'Home', 'key': 'home'},
      {'title': 'About', 'key': 'about'},
      {'title': 'Projects', 'key': 'projects'},
      {'title': 'Testimonials', 'key': 'testimonials'},
      {'title': 'Contact', 'key': 'contact'},
    ];

    return Container(
      width: MediaQuery.of(context).size.width * 0.75,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: const Color(0xFF121212).withOpacity(0.95),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(16)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: navItems.map((item) {
          return _NavItem(
            title: item['title']!,
            isMobile: true,
            isActive: activeSection == item['key'],
            onTap: () {
              onNavTap(item['key']!);
              onToggle();
            },
          );
        }).toList(),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String title;
  final bool isActive;
  final VoidCallback onTap;
  final bool isMobile;

  const _NavItem({
    required this.title,
    required this.isActive,
    required this.onTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return HoverEffect(
      hoverColor: const Color(0xFFFFD700),
      builder: (isHovering) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 24,
            vertical: isMobile ? 18 : 12,
          ),
          margin: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isActive ? Colors.white.withOpacity(0.08) : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isHovering ? const Color(0xFFFFD700) : Colors.transparent,
              width: 1.2,
            ),
          ),
          child: Text(
            title,
            style: GoogleFonts.montserrat(
              fontSize: isMobile ? 18 : 16,
              fontWeight: FontWeight.w600,
              color: isActive
                  ? const Color(0xFFFFD700)
                  : (isHovering ? Colors.white : Colors.white.withOpacity(0.75)),
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
