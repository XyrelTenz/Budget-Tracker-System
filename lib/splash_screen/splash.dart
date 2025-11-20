import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

class CustomSplashScreen extends StatefulWidget {
  const CustomSplashScreen({super.key});

  @override
  State<CustomSplashScreen> createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  late AnimationController _textAnimationController;
  late Animation<double> _textOpacityAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _smartBudgetScale;
  late Animation<double> _phScale;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _logoAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: const Interval(0.0, 1.0, curve: Curves.elasticOut),
      ),
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    _glowAnimation.addListener(() {
      if (_glowAnimation.status == AnimationStatus.completed) {
        _logoAnimationController.repeat(
          reverse: true,
          period: const Duration(seconds: 2),
        );
      }
    });

    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _textOpacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textAnimationController, curve: Curves.easeIn),
    );

    _textSlideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _textAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _smartBudgetScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: const Interval(0.0, 0.7, curve: Curves.easeOutBack),
      ),
    );

    _phScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
      ),
    );

    _logoAnimationController.forward().then((_) {
      _textAnimationController.forward();
    });

    _navigateNext();
  }

  _navigateNext() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) {
      SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.manual,
        overlays: SystemUiOverlay.values,
      );
      context.go('/OnBoardingScreen');
    }
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const brandBlue = Color(0xFF0046FF);
    const darkGrey = Color(0xFF313131);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedBuilder(
              animation: _glowAnimation,
              builder: (context, child) {
                return ScaleTransition(
                  scale: _scaleAnimation,
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      "assets/1.png",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          Icon(Icons.wallet, size: 60, color: brandBlue),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 10),
            FadeTransition(
              opacity: _textOpacityAnimation,
              child: SlideTransition(
                position: _textSlideAnimation,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ScaleTransition(
                      scale: _smartBudgetScale,
                      child: const Text(
                        "Smart Budget",
                        style: TextStyle(
                          color: darkGrey,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    ScaleTransition(
                      scale: _phScale,
                      child: const Text(
                        "PH",
                        style: TextStyle(
                          color: brandBlue,
                          fontSize: 32,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
