import 'package:flutter/material.dart';
import 'package:portfolio_website/utils/app_assets.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child;

  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                Color(0x22FFFFFF),
                Color(0x151A1A1A),
              ],
              stops: [0.0, 1.0],
            ),
          ),
        ),
        
        Positioned.fill(
          child: Opacity(
            opacity: 0.1,
            child: Image.asset(
              AppAssets.background,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Colors.black,
              ),
            ),
          ),
        ),
  
        child,
      ],
    );
  }
}
