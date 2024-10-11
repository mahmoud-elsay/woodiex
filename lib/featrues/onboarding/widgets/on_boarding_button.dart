import 'package:flutter/material.dart';
import '../../../core/routing/routes.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingButton extends StatelessWidget {
  const OnboardingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pushNamed(Routes.loginScreen); // Navigate to the login screen
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(ColorsManager.mainBlack),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: WidgetStateProperty.all(
          Size(159.w, 54.h), // Match the dimensions from XML
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
      child: Text(
        'Get Started', // Button label text
        style: Fonts.whiteGelasio18SemiBold, // Apply white Gelasio font style
      ),
    );
  }
}
