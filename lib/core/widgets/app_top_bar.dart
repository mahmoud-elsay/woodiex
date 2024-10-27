import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTopBar extends StatelessWidget {
  final Widget title;
  final String rightIconAsset; // New parameter for the right icon asset

  const AppTopBar({
    super.key,
    required this.title,
    required this.rightIconAsset, // Required asset for right icon
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
          Spacer(), // Pushes the right icon to the right
          GestureDetector(
            onTap: () {
              // Add logic based on the rightIconAsset
              if (rightIconAsset == 'assets/svgs/cart.svg') {
                context.pushNamed(Routes.cartScreen);
              } else if (rightIconAsset == 'assets/svgs/logout.svg') {
                // Implement logic for logout
              }
            },
            child: SvgPicture.asset(
              rightIconAsset, // Using the passed icon asset
              height: 24.h,
              width: 24.h,
            ),
          ),
        ],
      ),
    );
  }
}
