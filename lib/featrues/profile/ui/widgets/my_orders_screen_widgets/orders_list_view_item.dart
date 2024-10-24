import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/theming/font_weight.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrdersListViewItem extends StatelessWidget {
  const OrdersListViewItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      margin: EdgeInsets.all(10),
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Order No238562312',
                  style: Fonts.secondaryGreyNunitoSansSemiBold18
                      .copyWith(fontSize: 16),
                ),
                Spacer(),
                Text(
                  '22/10/2020',
                  style: Fonts.nunitoSansRegular14,
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade200,
              height: 0.3.h,
            ),
            verticalSpace(25),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Quantity: ',
                        style: Fonts.nunitoSansRegular14.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeightHelper.semiBold,
                        ),
                      ),
                      TextSpan(
                        text: '03',
                        style:
                            Fonts.blacknNnitoSansBold18.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Amount: ',
                        style: Fonts.nunitoSansRegular14.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeightHelper.semiBold,
                        ),
                      ),
                      TextSpan(
                        text: '\$50',
                        style:
                            Fonts.blacknNnitoSansBold18.copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(50),
            Row(
              children: [
                Container(
                  width: 100.h,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainBlack,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'detail',
                      style: Fonts.whiteNunitoSansSemiBold18
                          .copyWith(fontSize: 16),
                    ),
                  ),
                ),
                Spacer(), // Use Spacer for flexible spacing
                Text(
                  'Delivered',
                  style: Fonts.darkNnitoSansSemiBold18.copyWith(
                    fontSize: 16,
                    color: ColorsManager.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
