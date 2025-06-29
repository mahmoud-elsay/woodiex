import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';

class BottomCart extends StatelessWidget {
  final double total;
  final VoidCallback? onCheckout;

  const BottomCart({super.key, required this.total, this.onCheckout});

  @override
  Widget build(BuildContext context) {
    print('BottomCart build - total: $total');

    return Column(
      children: [
        Row(
          children: [
            Text(
              'Total:',
              style: Fonts.nunitoSans18BoldSecondaryGrey,
            ),
            const Spacer(),
            Text(
              '\$${total.toStringAsFixed(2)}',
              style: Fonts.nunitoSans20BoldMainBlack,
            ),
          ],
        ),
        verticalSpace(10),
        AppTextButton(
          buttonText: 'Checkout',
          textStyle: Fonts.nunitoSans20SemiBoldWhite,
          onPressed: total > 0
              ? (onCheckout ??
                  () {
                    print(
                        'BottomCart default onPressed - navigating with total: $total');
                    context.pushNamed(Routes.checkoutScreen,
                        arguments: {'total': total});
                  })
              : null,
        ),
      ],
    );
  }
}
