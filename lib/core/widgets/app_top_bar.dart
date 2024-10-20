import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTopBar extends StatelessWidget {
  final Widget title; // Allows flexibility to pass any widget as the title

  const AppTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h),
      child: Row(
        children: [
          SvgPicture.asset('assets/svgs/search.svg'),
          horizontalSpace(60),
          Expanded(child: title), // Center the title widget
          SvgPicture.asset('assets/svgs/cartsvg.svg'),
        ],
      ),
    );
  }
}
