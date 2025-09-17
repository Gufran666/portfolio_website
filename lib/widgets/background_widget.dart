import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/app_assets.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;
  final double pageOffset;

  const BackgroundWidget({
    super.key,
    required this.child,
    this.pageOffset = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
      
        Positioned.fill(
          child: Opacity(
            opacity: 0.1, 
            child: Image.asset(
              AppAssets.background,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF1E1E1E),
              ),
            ),
          ),
        ),

        // Gradient overlay layer
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.3),
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),

        // Content layer
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
