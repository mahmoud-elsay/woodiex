import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/onboarding/widgets/on_boarding_button.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image, filling the screen
          Positioned.fill(
            child: Image.asset(
              'assets/images/boarding.png',
              fit: BoxFit.fill,
            ),
          ),

          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.only(left: 30.w, top: 276.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MAKE YOUR',
                    style: Fonts.gelasio24SemiBold,
                  ),
                  verticalSpace(10),
                  Text('HOME BEAUTIFUL', style: Fonts.gelasio30Bold),
                  verticalSpace(35),
                  Text(
                    'The best simple place where you \n discover most wonderful furnitures\n and make your home beautiful',
                    style: Fonts.nunitoSansRegular18,
                  ),
                  verticalSpace(200),
                  Center(child: OnboardingButton())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
