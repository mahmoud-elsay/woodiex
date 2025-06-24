import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/fillter_option_model.dart';

class FilterOptionItem extends StatelessWidget {
  final FilterOption option;
  final VoidCallback onTap;

  const FilterOptionItem({
    super.key,
    required this.option,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44.w,
            height: 44.h,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: option.isSelected
                  ? ColorsManager.mainBlack
                  : ColorsManager.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: SvgPicture.asset(
              option.iconPath,
              width: 24.w,
              height: 24.h,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            option.label,
            style: option.isSelected
                ? Fonts.nunitoSans14BoldMainBlack
                : Fonts.nunitoSans14RegularSecondaryGrey,
          ),
        ],
      ),
    );
  }
}
