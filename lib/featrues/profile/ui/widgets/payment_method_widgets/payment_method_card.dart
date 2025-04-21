import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodCard extends StatelessWidget {
  final bool isChecked;
  final ValueChanged<bool?> onCheckboxChanged;

  const PaymentMethodCard({
    super.key,
    required this.isChecked,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 300.w,
          height: 150.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Image.asset(
              isChecked
                  ? 'assets/images/Payment_card.png'
                  : 'assets/images/unselcted_Payment_card.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        verticalSpace(10),
        Row(
          children: [
            Checkbox(
              activeColor: ColorsManager.mainBlack,
              checkColor: ColorsManager.white,
              onChanged: onCheckboxChanged,
              value: isChecked,
            ),
            Text(
              'Use this payment method ',
              style: Fonts.nunitoSans18RegularMainBlack,
            ),
          ],
        ),
      ],
    );
  }
}
