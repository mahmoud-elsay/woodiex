import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRow extends StatelessWidget {
  const ProductRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
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
        horizontalSpace(15),
        Column(
          children: [
            Text(
              'Minimal Stand',
              style: Fonts.nunitoSansRegular14
                  .copyWith(color: ColorsManager.mainBlack),
            ),
            verticalSpace(10),
            Row(
              children: [
                SvgPicture.asset('assets/svgs/star.svg'),
                horizontalSpace(5),
                Text(
                  '4.5',
                  style: Fonts.darkNnitoSansBold20.copyWith(fontSize: 24),
                )
              ],
            ),
            verticalSpace(7),
            Text(
              '10 reviews',
              style: Fonts.darkNnitoSansSemiBold18,
            )
          ],
        )
      ],
    );
  }
}
