import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';

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
            onPressed: () {
              context.pushNamed(Routes.checkoutScreen);
            })
      ],
    );
  }
}
