import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/boarding.png', // Replace SVG with PNG image
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Text('Welcome to the Onboarding Screen'),
          ),
        ],
      ),
    );
  }
}
