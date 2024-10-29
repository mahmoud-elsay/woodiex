import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/theming/font_weight.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';

class ProductInfo extends StatelessWidget {
  final FurnitureItemModel item;

  const ProductInfo({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: Fonts.gelasio24SemiBold.copyWith(
              color: ColorsManager.mainBlack,
              fontWeight: FontWeightHelper.medium),
        ),
        SizedBox(height: 20.h),
        Text(
          '\$50',
          style: Fonts.darkNnitoSansBold20.copyWith(fontSize: 30.sp),
        ),
      ],
    );
  }
}
