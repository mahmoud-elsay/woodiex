import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
// Ensure you import your Fonts class.

class AlreadyHaveAccountText extends StatelessWidget {
  const AlreadyHaveAccountText({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Already have an account?',
            style: Fonts.nunitoSans14RegularSecondaryGrey,
          ),
          TextSpan(
            text: ' Login',
            style: Fonts.nunitoSans14BoldDarkGrey,
          ),
        ],
      ),
    );
  }
}
