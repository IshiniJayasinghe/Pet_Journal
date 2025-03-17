import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<Animation<double>> _pawOpacities = [];
  final List<Animation<Offset>> _pawOffsets = [];
  static const int pawCount = 8;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    // Create animations for each paw print
    for (int i = 0; i < pawCount; i++) {
      final startTime = i / pawCount;
      final endTime = (i + 1) / pawCount;

      // Opacity animation with fade out
      _pawOpacities.add(
        TweenSequence<double>([
          TweenSequenceItem(
            tween: Tween<double>(begin: 0.0, end: 1.0),
            weight: 20.0,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 1.0),
            weight: 60.0,
          ),
          TweenSequenceItem(
            tween: Tween<double>(begin: 1.0, end: 0.0),
            weight: 20.0,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(startTime, endTime, curve: Curves.easeInOut),
          ),
        ),
      );

      // Position animation with bouncy, playful movement
      final isRightPaw = i.isEven;
      final stepWidth = isRightPaw ? 0.4 : -0.4;
      final horizontalOffset = isRightPaw ? 0.15 : -0.15;
      final baseHeight = 2.0 - (i * 0.4); // More vertical spacing

      _pawOffsets.add(
        TweenSequence<Offset>([
          // Initial bounce up
          TweenSequenceItem(
            tween: Tween<Offset>(
              begin: Offset(stepWidth, baseHeight),
              end: Offset(stepWidth + horizontalOffset, baseHeight - 0.5),
            ).chain(CurveTween(curve: Curves.elasticOut)),
            weight: 30.0,
          ),
          // Playful wiggle
          TweenSequenceItem(
            tween: Tween<Offset>(
              begin: Offset(stepWidth + horizontalOffset, baseHeight - 0.5),
              end: Offset(stepWidth - horizontalOffset, baseHeight - 0.6),
            ).chain(CurveTween(curve: Curves.easeInOutBack)),
            weight: 40.0,
          ),
          // Bouncy landing
          TweenSequenceItem(
            tween: Tween<Offset>(
              begin: Offset(stepWidth - horizontalOffset, baseHeight - 0.6),
              end: Offset(stepWidth, baseHeight - 0.3),
            ).chain(CurveTween(curve: Curves.bounceOut)),
            weight: 30.0,
          ),
        ]).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Interval(startTime, endTime, curve: Curves.easeInOut),
          ),
        ),
      );
    }

    // Start the animation
    _controller.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main Content
          Positioned.fill(
            child: Column(
              children: [
                const Spacer(flex: 2),
                // Logo and App Name Container
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo
                      Image.asset(
                        'assets/images/logo.jpeg',
                        height: 400,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 32),

                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const Spacer(flex: 3),

                // Animated Paw Prints
                SizedBox(
                  height: 280,
                  child: Stack(
                children: List.generate(pawCount, (index) {
                  return AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return Opacity(
                        opacity: _pawOpacities[index].value,
                        child: SlideTransition(
                          position: _pawOffsets[index],
                          child: Transform.rotate(
                            angle: index.isEven ? 0.25 : -0.25,
                            child: const Icon(
                              Icons.pets,
                              size: 48,
                              color: Color(0xFFFFA500),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
