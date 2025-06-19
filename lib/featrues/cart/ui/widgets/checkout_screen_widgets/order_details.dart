import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderDetails extends StatelessWidget {
  final double? total;
  final double? subTotal;
  final double? deliveryCost;

  const OrderDetails({
    super.key,
    this.total,
    this.subTotal,
    this.deliveryCost,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTotal = total ?? 100.0; // Default value if not provided
    final effectiveSubTotal = subTotal ?? 90.0; // Default value
    final effectiveDeliveryCost = deliveryCost ?? 10.0; // Default value

    return Container(
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Subtotal :',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                const Spacer(),
                Text(
                  '\$${effectiveSubTotal.toStringAsFixed(2)}',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Text(
                  'Delivery: ',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                Spacer(),
                Text(
                  '\$${effectiveDeliveryCost.toStringAsFixed(2)}',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Text(
                  'Total :',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                Spacer(),
                Text(
                  '\$${effectiveTotal.toStringAsFixed(2)}',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                ),
              ],
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
