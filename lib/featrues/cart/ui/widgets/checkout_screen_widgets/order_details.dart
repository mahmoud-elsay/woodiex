import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 135.h,
      width: 335.w,
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Order :',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                Spacer(),
                Text(
                  '\$90',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                )
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Text(
                  'Delivery: :',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                Spacer(),
                Text(
                  '\$10',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                )
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Text(
                  'Order :',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                Spacer(),
                Text(
                  '\$100',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                )
              ],
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
