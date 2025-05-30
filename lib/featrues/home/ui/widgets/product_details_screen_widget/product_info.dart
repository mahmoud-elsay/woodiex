import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';

class ProductInfo extends StatelessWidget {
  final ProductData item;

  const ProductInfo({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.name,
          style: Fonts.gelasio24MediumMainBlack,
        ),
        SizedBox(height: 20.h),
        Text(
          '\$50',
          style: Fonts.nunitoSans30BoldMainBlack,
        ),
      ],
    );
  }
}
