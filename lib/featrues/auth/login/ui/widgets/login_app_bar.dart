import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginAppBar extends StatelessWidget {
  const LoginAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 25.w),
      child: Row(
        children: [
          Container(
              width: 105.0.w,
              height: 1.0.h,
              decoration: BoxDecoration(
                color: ColorsManager.lighterGrey,
              )),
          horizontalSpace(10),
          SvgPicture.asset('assets/svgs/logo.svg'),
          horizontalSpace(10),
          Container(
              width: 105.0.w,
              height: 1.0.h,
              decoration: BoxDecoration(
                color: ColorsManager.lighterGrey,
              )),
        ],
      ),
    );
  }
}
