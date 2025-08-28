import 'package:flutter/material.dart';

class BinaryBackground extends StatefulWidget {
  final List<Widget> children;

  const BinaryBackground({super.key, required this.children});

  @override
  State<BinaryBackground> createState() => _BinaryBackgroundState();
}

class _BinaryBackgroundState extends State<BinaryBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _tiltAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat(reverse: true);

    _tiltAnimation = Tween<double>(begin: -0.005, end: 0.005).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOutSine),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    final screenSize = MediaQuery.of(context).size;

    return Container(
      color: Colors.black,
      child: Stack(
        children: [
          /// Background with subtle tilt effect
          AnimatedBuilder(
            animation: _tiltAnimation,
            builder: (_, __) => Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.002) // Perspective for depth
                ..rotateX(_tiltAnimation.value)
                ..rotateY(_tiltAnimation.value)
                ..scale(1.1),
              alignment: Alignment.center,
              child: Opacity(
                opacity: 0.2,
                child: Image.asset(
                  'assets/images/cyberpunk.jpeg',
                  fit: BoxFit.cover,
                  width: screenSize.width,
                  height: screenSize.height,
                ),
              ),
            ),
          ),

          /// Painted binary patterns
          RepaintBoundary(
            child: CustomPaint(
              painter: BinaryPainter(isMobile: isMobile),
              size: Size.infinite,
            ),
          ),

          /// Foreground children
          ...widget.children,
        ],
      ),
    );
  }
}

class BinaryPainter extends CustomPainter {
  final bool isMobile;

  BinaryPainter({required this.isMobile});

  static final Paint _silhouettePaint = Paint()
    ..color = const Color(0xFFA020F0).withOpacity(0.1)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;

  static final TextStyle _textStyle = TextStyle(
    color: Colors.white54,
    fontSize: 10,
    fontFamily: 'RobotoMono',
  );

  @override
  void paint(Canvas canvas, Size size) {
    // Device silhouette
    final silhouetteWidth = isMobile ? size.width * 0.5 : 200.0;
    final silhouetteHeight = isMobile ? size.height * 0.4 : 400.0;
    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            (size.width - silhouetteWidth) / 2,
            (size.height - silhouetteHeight) / 2,
            silhouetteWidth,
            silhouetteHeight,
          ),
          const Radius.circular(40),
        ),
      );
    canvas.drawPath(path, _silhouettePaint);

    // Binary pattern text (cached per paint)
    final textPainter = TextPainter(
      text: TextSpan(text: '0101 1010 1110', style: _textStyle.copyWith(
        fontSize: isMobile ? 8 : 10,
        color: Colors.white.withOpacity(0.1),
      )),
      textDirection: TextDirection.ltr,
    )..layout();

    final spacing = isMobile ? 40.0 : 50.0;
    for (double y = 0; y < size.height; y += spacing) {
      for (double x = 0; x < size.width; x += spacing * 2) {
        textPainter.paint(canvas, Offset(x, y));
      }
    }
  }

  @override
  bool shouldRepaint(covariant BinaryPainter oldDelegate) =>
      oldDelegate.isMobile != isMobile;
}
