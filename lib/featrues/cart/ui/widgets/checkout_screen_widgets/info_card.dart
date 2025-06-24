import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final String cardText;
  final VoidCallback? onEditTap;

  const InfoCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.cardText,
    this.onEditTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: Fonts.nunitoSans18SemiBoldSecondaryGrey,
            ),
            const Spacer(),
            GestureDetector(
              onTap: onEditTap,
              child: SvgPicture.asset('assets/svgs/edit_icon.svg'),
            ),
          ],
        ),
        verticalSpace(10),
        Container(
          width: 335.w,
          height: 68.h,
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
              SvgPicture.asset(iconPath),
              horizontalSpace(20),
              Text(
                cardText,
                style: Fonts.nunitoSans14SemiBoldMainBlack,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
