import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListViewItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ProfileListViewItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335.w,
        height: 80.h,
        color: ColorsManager.white,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Fonts.nunitoSans18BoldMainBlack,
                  ),
                  verticalSpace(5),
                  Text(
                    subtitle,
                    style: Fonts.nunitoSans12RegularSecondaryGrey,
                  ),
                ],
              ),
            ),
            SvgPicture.asset('assets/svgs/next_arrow.svg')
          ],
        ),
      ),
    );
  }
}
