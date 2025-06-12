import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class WriteReviewPart extends StatelessWidget {
  final TextEditingController? controller;

  const WriteReviewPart({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Write a review ',
            style: Fonts.nunitoSans14RegularMainBlack,
            children: [
              TextSpan(
                text: '*',
                style: Fonts.nunitoSans14RegularMainBlack.copyWith(
                  color: ColorsManager.red, 
                ),
              ),
            ],
          ),
        ),
        verticalSpace(10),
        Container(
          width: 353.w,
          height: 147.h,
          decoration: BoxDecoration(
            color: ColorsManager.lightGrey, // Adjusted to match theme
            border: Border.all(color: ColorsManager.mainBlack),
            borderRadius: BorderRadius.circular(10.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
          child: TextFormField(
            controller: controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Write a review for the product',
              hintStyle: Fonts.nunitoSans14RegularSecondaryGrey,
            ),
          ),
        ),
      ],
    );
  }
}