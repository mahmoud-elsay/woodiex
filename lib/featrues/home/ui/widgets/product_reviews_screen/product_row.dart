import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRow extends StatelessWidget {
  final String imageUrl; // Add imageUrl parameter
  final String name; // Add name parameter

  const ProductRow({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          height: 100.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              imageUrl, // Use dynamic imageUrl
              fit: BoxFit.fill,
            ),
          ),
        ),
        horizontalSpace(15),
        Column(
          children: [
            Text(
              name, // Use dynamic name
              style: Fonts.nunitoSans14RegularMainBlack,
            ),
            verticalSpace(10),
            Row(
              children: [
                SvgPicture.asset('assets/svgs/star.svg'),
                horizontalSpace(5),
                Text(
                  '4.5', // This could be dynamic if passed
                  style: Fonts.nunitoSans24BoldMainBlack,
                )
              ],
            ),
            verticalSpace(7),
            Text(
              '10 reviews', // This could be dynamic if passed
              style: Fonts.nunitoSans18SemiBoldMainBlack,
            )
          ],
        )
      ],
    );
  }
}
