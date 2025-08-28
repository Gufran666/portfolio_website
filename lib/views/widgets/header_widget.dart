import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:portfolio_website/core/cyberpunk_text_styles.dart';
import 'package:portfolio_website/views/screens/home_view.dart';

class HeaderWidget extends StatelessWidget {
  final Function(GlobalKey) onNavigate;
  final List<SectionInfo> sections;

  const HeaderWidget({
    super.key,
    required this.onNavigate,
    required this.sections,
  });

  static const _headerColor = Colors.black;
  static const _dividerColor = Colors.white12;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 16 : 32,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: _headerColor.withOpacity(0.85),
        border: const Border(bottom: BorderSide(color: _dividerColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAnimatedNavItem(
            index: 0,
            child: Text(
              'Portfolio',
              style: CyberpunkTextStyles.heading.copyWith(color: Colors.white),
              semanticsLabel: "Website Logo - Home",
            ),
          ),
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              tooltip: "Open navigation menu",
              onPressed: () {
                Feedback.forTap(context);
                showModalBottomSheet(
                  context: context,
                  backgroundColor: _headerColor.withOpacity(0.95),
                  isScrollControlled: true,
                  builder: (context) => FractionallySizedBox(
                    heightFactor: 0.7,
                    child: _buildMenu(context),
                  ),
                );
              },
            )
          else
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: 12,
                  children: sections.asMap().entries.map((entry) {
                    final index = entry.key;
                    final section = entry.value;
                    return _buildAnimatedNavItem(
                      index: index + 1,
                      child: TextButton(
                        onPressed: () => onNavigate(section.key),
                        child: Text(
                          section.title,
                          style: CyberpunkTextStyles.subheading.copyWith(
                            color: Colors.white70,
                            fontSize: isMobile ? 14 : 16,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Reusable animation builder
  Widget _buildAnimatedNavItem({required int index, required Widget child}) {
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 600),
      child: SlideAnimation(
        horizontalOffset: index.isEven ? -50.0 : 50.0,
        child: FadeInAnimation(child: child),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return SafeArea(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: sections.length,
        itemBuilder: (context, index) {
          final section = sections[index];
          return _buildAnimatedNavItem(
            index: index,
            child: ListTile(
              title: Text(
                section.title,
                style: CyberpunkTextStyles.subheading.copyWith(color: Colors.white),
              ),
              onTap: () {
                Feedback.forTap(context);
                onNavigate(section.key);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
