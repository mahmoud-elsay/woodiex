import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationsTopBar extends StatelessWidget {
  const NotificationsTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svgs/search.svg',
            height: 24.h,
            width: 24.h,
          ),
          horizontalSpace(50),
          Text(
            'Notification',
            style: Fonts.merriweather16BoldMainBlack,
          ),
        ],
      ),
    );
  }
}
