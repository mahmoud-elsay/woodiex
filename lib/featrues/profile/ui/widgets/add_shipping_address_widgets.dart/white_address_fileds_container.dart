import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhiteAddressFieldsContainer extends StatelessWidget {
  final String label;
  final String value;
  final bool isDropdown;
  final VoidCallback? onTap;

  const WhiteAddressFieldsContainer({
    super.key,
    required this.label,
    required this.value,
    this.isDropdown = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 335.w,
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(
            color: ColorsManager.lighterGrey,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: Fonts.nunitoSans12Reular80Grey,
                  ),
                  Text(
                    value,
                    style: Fonts.nunitoSans16SemiBoldMainBlack,
                  ),
                ],
              ),
              if (isDropdown)
                SvgPicture.asset(
                  'assets/svgs/menu_down_arrow.svg',
                  width: 16.w, // Reduced size
                  height: 16.h,
                  colorFilter: const ColorFilter.mode(
                    ColorsManager.mainBlack,
                    BlendMode.srcIn,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
