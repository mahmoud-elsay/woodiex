import 'package:flutter/widgets.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRowForReview extends StatelessWidget {
  const ProductRowForReview({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Product Image
        Container(
          width: 74.w,
          height: 60.h,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.3.w,
              color: ColorsManager.mainBlack, // Adjusted to match theme
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Image.asset('assets/images/prod.png'), // Adjusted asset
        ),
        horizontalSpace(15),
        Column(
          children: [
            Text('Minimal Stand', style: Fonts.nunitoSans14RegularMainBlack),
            verticalSpace(20),
            Text('4.5', style: Fonts.nunitoSans12BoldMainBlack),
          ],
        )
      ],
    );
  }
}
