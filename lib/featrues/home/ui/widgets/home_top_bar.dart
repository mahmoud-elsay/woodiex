import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTopBar extends StatelessWidget {
  const HomeTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        children: [
          SvgPicture.asset('assets/svgs/search.svg'),
          horizontalSpace(60),
          Column(
            children: [
              Text(
                'Make Home',
                style: Fonts.gelasio18Regular,
              ),
              verticalSpace(2),
              Text(
                'BEAUTIFUL',
                style: Fonts.mainBlackGelasio18Bold,
              )
            ],
          ),
          Spacer(),
          SvgPicture.asset('assets/svgs/cartsvg.svg'),
        ],
      ),
    );
  }
}
