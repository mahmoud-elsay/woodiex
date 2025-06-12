import 'package:flutter/widgets.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRowForReview extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ProductRowForReview({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 74.w,
          height: 60.h,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.3.w,
              color: ColorsManager.mainBlack,
            ),
            borderRadius: BorderRadius.circular(5.r),
          ),
          child: Image.network(
            imageUrl, // Use dynamic imageUrl
            fit: BoxFit.cover,
          ),
        ),
        horizontalSpace(15),
        Column(
          children: [
            Text(name, style: Fonts.nunitoSans14RegularMainBlack),
            verticalSpace(20),
            Text('4.5', style: Fonts.nunitoSans12BoldMainBlack),
          ],
        )
      ],
    );
  }
}
