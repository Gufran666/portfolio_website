import 'package:flutter/material.dart';
import 'package:portfolio_website/core/app_assets.dart';
import 'header_navigation_button.dart';

class HeaderWidget extends StatelessWidget {
  final void Function(GlobalKey key) onNavigate;
  final GlobalKey introKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey aboutKey;
  final GlobalKey contactsKey;

  const HeaderWidget({
    super.key,
    required this.onNavigate,
    required this.introKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.aboutKey,
    required this.contactsKey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(color: Colors.cyan.withAlpha(5), width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(left: 20),
            padding: const EdgeInsets.all(4),
            child: Image.asset(
              AppAssets.logo,
              width: 100,
              height: 48,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, color: Colors.cyan),
            )

          ),
          Row(
            children: [
              HeaderNavigationButton(
                text: "Home",
                onPressed: () => onNavigate(introKey),
              ),
              HeaderNavigationButton(
                text: "Projects",
                onPressed: () => onNavigate(projectsKey),
              ),
              HeaderNavigationButton(
                text: "Skills",
                onPressed: () => onNavigate(skillsKey),
              ),
              HeaderNavigationButton(
                text: "About",
                onPressed: () => onNavigate(aboutKey),
              ),
              HeaderNavigationButton(
                text: "Contact",
                onPressed: () => onNavigate(contactsKey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
