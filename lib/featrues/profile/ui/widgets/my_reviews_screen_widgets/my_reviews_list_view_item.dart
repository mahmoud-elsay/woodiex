import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/my_reviews_screen_widgets/rating_widget.dart';

class MyReviewsListViewItem extends StatelessWidget {
  const MyReviewsListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 242.h,
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 75.w,
                  height: 75.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      'assets/images/prod.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                horizontalSpace(25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Coffe table',
                      style: Fonts.nunitoSans16BoldSecondaryGrey,
                    ),
                    verticalSpace(10),
                    Text(
                      '\$50',
                      style: Fonts.nunitoSans16BoldMainBlack,
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(15),
            Row(
              children: [
                RatingWidget(),
                Spacer(),
                Text(
                  '22/10/2020',
                  style: Fonts.nunitoSans14RegularSecondaryGrey,
                ),
              ],
            ),
            verticalSpace(15),
            Expanded(
              child: Text(
                'Nice Furniture with good delivery\n. The delivery time is very fast. Then products look like exactly \n the picture in the app. Besides, color is also the \n same  and quality is very good despite \n very cheap price',
                style: Fonts.nunitoSans14RegularMainBlack,
              ),
            )
          ],
        ),
      ),
    );
  }
}
