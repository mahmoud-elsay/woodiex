import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpCenterWidget extends StatelessWidget {
  const HelpCenterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Help',
          style: Fonts.blacknNnitoSansBold18.copyWith(
            fontSize: 16.sp,
            color: ColorsManager.secondaryGrey,
          ),
        ),
        verticalSpace(15),
        Container(
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
                'FAQ',
                style: Fonts.darkNnitoSansSemiBold18.copyWith(fontSize: 16.sp),
              ),
              Spacer(),
              SvgPicture.asset('assets/svgs/next_arrow.svg')
            ],
          ),
        )
      ],
    );
  }
}
