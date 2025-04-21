import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistButton extends StatelessWidget {
  final bool isSaved;
  final VoidCallback onToggle;

  const WishlistButton(
      {super.key, required this.isSaved, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      child: Container(
        width: 50.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: ColorsManager.lightGrey,
        ),
        child: SvgPicture.asset(
          isSaved
              ? 'assets/svgs/saved_product.svg'
              : 'assets/svgs/whishlist.svg',
          color: ColorsManager.mainBlack,
          width: 24.w,
          height: 24.h,
        ),
      ),
    );
  }
}
