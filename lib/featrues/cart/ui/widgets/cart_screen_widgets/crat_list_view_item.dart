import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartListViewItem extends StatefulWidget {
  const CartListViewItem({super.key});

  @override
  State<CartListViewItem> createState() => _CartListViewItemState();
}

class _CartListViewItemState extends State<CartListViewItem> {
  int quantity = 1;

  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

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
                  'Coffee table',
                  style: Fonts.nunitoSans14SemiBoldSecondaryGrey,
                ),
                verticalSpace(10),
                Text(
                  '\$50',
                  style: Fonts.nunitoSans16BoldMainBlack,
                ),
                verticalSpace(20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _increaseQuantity,
                      child: SvgPicture.asset('assets/svgs/add.svg'),
                    ),
                    horizontalSpace(5),
                    Text(
                      quantity.toString(),
                      style: Fonts.nunitoSans18SemiBoldMainBlack,
                    ),
                    horizontalSpace(5),
                    GestureDetector(
                      onTap: _decreaseQuantity,
                      child: SvgPicture.asset('assets/svgs/decrease.svg'),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            SvgPicture.asset('assets/svgs/remove.svg'),
          ],
        ),
        verticalSpace(10),
        Divider(
          height: 1.h,
          color: Colors.grey.shade300,
        ),
        verticalSpace(20),
      ],
    );
  }
}
