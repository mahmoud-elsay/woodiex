import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/helpers/extension.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    _navigateToOnboarding();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToOnboarding() async {
    await Future.delayed(const Duration(seconds: 6));
    context.pushReplacementNamed(Routes.onBoardingScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lotties/splash_lottie.json',
          options: LottieOptions(enableMergePaths: true),
          controller: _controller,
          onLoaded: (composition) {
            _controller
              ..duration = composition.duration
              ..forward();
          },
        ),
      ),
    );
  }
}
