import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/profile/ui/widgets/settings_screen_widgets/custom_switch.dart';

class NotificationsWidgets extends StatelessWidget {
  const NotificationsWidgets({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: Fonts.nunitoSans16BoldSecondaryGrey,
        ),
        verticalSpace(15),
        _buildNotificationOption(
          title: 'Sales',
          trailing: CustomSwitch(),
        ),
        verticalSpace(15),
        _buildNotificationOption(
          title: 'New arrivals',
          trailing: CustomSwitch(),
        ),
        verticalSpace(15),
        _buildNotificationOption(
          title: 'Delivery status changes',
        ),
      ],
    );
  }

  Widget _buildNotificationOption({required String title, Widget? trailing}) {
    return Container(
      width: 335.w,
      height: 54.h,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
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
      child: Row(
        children: [
          Text(
            title,
            style: Fonts.nunitoSans16SemiBoldMainBlack,
          ),
          Spacer(),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
