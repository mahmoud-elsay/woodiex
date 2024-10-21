import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomCart extends StatelessWidget {
  const BottomCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Total:',
              style: Fonts.secondaryGreyNunitoSansBold18,
            ),
            Spacer(),
            Text(
              '\$50',
              style: Fonts.darkNnitoSansBold20,
            ),
          ],
        ),
        verticalSpace(10),
        AppTextButton(
            buttonText: 'checkout',
            textStyle: Fonts.whiteNnitoSansSemiBold20,
            onPressed: () {})
      ],
    );
  }
}
