import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationListViewItem extends StatelessWidget {
  const NotificationListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, // Aligns top
          children: [
            // Image container with fixed size
            SizedBox(
              width: 70.w,
              height: 70.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.asset(
                  'assets/images/prod.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            horizontalSpace(10), // Add some space between image and text

            // Use Expanded to prevent overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your order #123456789 has been canceled',
                    style: Fonts.darkNnitoSansBold12,
                    maxLines: 1, // Prevent text overflow with single line
                    overflow:
                        TextOverflow.ellipsis, // Add ellipsis if it overflows
                  ),
                  verticalSpace(5),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Turpis pretium et in arcu adipiscing nec.',
                    style: Fonts.nunitoSansRegular14.copyWith(
                      fontSize: 10.sp,
                      color: ColorsManager.secondaryGrey,
                    ),
                    maxLines: 2, // Limit to two lines to avoid overflow
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
        verticalSpace(10),
        Divider(
          height: 1.h,
          color: Colors.grey.shade300,
        ),
        verticalSpace(5),
      ],
    );
  }
}
