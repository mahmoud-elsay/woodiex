import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListViewItem extends StatelessWidget {
  const NotificationListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70.w,
          height: 70.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.asset(
              'assets/images/prod.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Column(
          children: [
            Text(
              'Your order #123456789 has been canceled',
              style: Fonts.darkNnitoSansBold12,
            ),
            verticalSpace(10),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Turpis pretium et in arcu adipiscing nec. Turpis pretium et in arcu adipiscing nec. ',
              style: Fonts.nunitoSansRegular14.copyWith(
                  fontSize: 10.sp, color: ColorsManager.secondaryGrey),
            )
          ],
        )
      ],
    );
  }
}
