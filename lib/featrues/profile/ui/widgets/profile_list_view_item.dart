import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileListViewItem extends StatelessWidget {
  const ProfileListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 80.h,
      color: ColorsManager.white,
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'My orders',
                style: Fonts.darkNnitoSansBold20.copyWith(fontSize: 18.sp),
              ),
              verticalSpace(5),
              Text(
                'Already have 10 orders',
                style: Fonts.nunitoSansRegular14.copyWith(fontSize: 12),
              )
            ],
          ),
          Spacer(),
          SvgPicture.asset('assets/svgs/next_arrow.svg')
        ],
      ),
    );
  }
}
