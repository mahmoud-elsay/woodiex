import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class AppTopBar extends StatelessWidget {
  final Widget title;

  const AppTopBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w), // Adjusted padding
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/svgs/search.svg',
            height: 24.h,
            width: 24.h,
          ),
          Spacer(), // Pushes the title to the center
          title,
          Spacer(), // Pushes the cart icon to the right
          SvgPicture.asset(
            'assets/svgs/cartsvg.svg',
            height: 24.h,
            width: 24.h,
          ),
        ],
      ),
    );
  }
}
