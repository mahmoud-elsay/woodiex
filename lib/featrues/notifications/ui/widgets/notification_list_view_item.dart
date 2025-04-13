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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
            horizontalSpace(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your order #123456789 has been canceled',
                    style: Fonts.nunitoSans12BoldMainBlack,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  verticalSpace(5),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Turpis pretium et in arcu adipiscing nec.',
                    style: Fonts.nunitoSans14RegularSecondaryGrey.copyWith(
                      fontSize: 10.sp,
                      color: ColorsManager.secondaryGrey,
                    ),
                    maxLines: 2,
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
