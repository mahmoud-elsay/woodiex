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
            style: Fonts.nunitoSansRegular14, // Use your custom Fonts style
          ),
          TextSpan(
            text: ' Login',
            style: Fonts.darkGreyNunitoSansBold14, // Adjust as needed
          ),
        ],
      ),
    );
  }
}
