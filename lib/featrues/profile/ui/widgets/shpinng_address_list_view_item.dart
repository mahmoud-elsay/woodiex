import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShpinngAddressListViewItem extends StatefulWidget {
  const ShpinngAddressListViewItem({super.key});

  @override
  State<ShpinngAddressListViewItem> createState() =>
      _ShpinngAddressListViewItemState();
}

class _ShpinngAddressListViewItemState
    extends State<ShpinngAddressListViewItem> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: ColorsManager.mainBlack,
              checkColor: ColorsManager.secondaryGrey,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
              value: _isChecked,
            ),
            Text(
              'Use as the shipping address',
              style: Fonts.nunitoSansRegular18,
            ),
          ],
        ),
        verticalSpace(5),
        Container(
          height: 127.h,
          width: 335.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey
                    .withOpacity(0.2), // Shadow color with transparency
                spreadRadius: 2, // How much the shadow spreads
                blurRadius: 6, // How soft the shadow appears
                offset: const Offset(0, 3), // Position of the shadow (x, y)
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
                      'mostfa naf3',
                      style: Fonts.blacknNnitoSansBold18,
                    ),
                    horizontalSpace(200),
                    SvgPicture.asset('assets/svgs/edit_icon.svg'),
                  ],
                ),
                verticalSpace(7),
                Divider(
                  color: ColorsManager.secondaryGrey,
                  height: 1.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
