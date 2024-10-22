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
      onTap: onTap, // Trigger the onTap callback when clicked
      child: Container(
        width: 335.w,
        height: 80.h,
        color: ColorsManager.white,
        child: Row(
          children: [
            Expanded(
              // Use Expanded to take full width and avoid using Column here
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the start
                children: [
                  Text(
                    title,
                    style: Fonts.darkNnitoSansBold20.copyWith(fontSize: 18.sp),
                  ),
                  verticalSpace(5),
                  Text(
                    subtitle,
                    style: Fonts.nunitoSansRegular14.copyWith(fontSize: 12),
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
