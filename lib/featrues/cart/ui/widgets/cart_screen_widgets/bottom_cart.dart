import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';

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
              style: Fonts.nunitoSans18BoldSecondaryGrey,
            ),
            Spacer(),
            Text(
              '\$50',
              style: Fonts.nunitoSans20BoldMainBlack,
            ),
          ],
        ),
        verticalSpace(10),
        AppTextButton(
            buttonText: 'checkout',
            textStyle: Fonts.nunitoSans20SemiBoldWhite,
            onPressed: () {
              context.pushNamed(Routes.checkoutScreen);
            })
      ],
    );
  }
}
