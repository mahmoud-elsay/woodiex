import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WhishlistListViewItem extends StatelessWidget {
  const WhishlistListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  'assets/images/prod.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            horizontalSpace(30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Coffe table',
                  style: Fonts.nunitoSans14SemiBoldSecondaryGrey,
                ),
                verticalSpace(10),
                Text(
                  '\$50',
                  style: Fonts.nunitoSans16BoldMainBlack,
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                SvgPicture.asset('assets/svgs/remove.svg'),
                verticalSpace(20),
                SvgPicture.asset('assets/svgs/selected_wish_list.svg'),
              ],
            ),
          ],
        ),
        verticalSpace(10),
        Divider(
          height: 1.h,
          color: Colors.grey.shade300,
        ),
        verticalSpace(10),
      ],
    );
  }
}
