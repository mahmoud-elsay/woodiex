import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';

class RatingSection extends StatelessWidget {
  final double rating;
  final int reviews;

  const RatingSection({Key? key, required this.rating, required this.reviews})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/svgs/star.svg'),
        horizontalSpace(10),
        Text(
          rating.toString(),
          style: Fonts.blacknNnitoSansBold18,
        ),
        horizontalSpace(15),
        Text(
          '($reviews reviews)',
          style: Fonts.nunitoSansRegular14.copyWith(fontSize: 14),
        ),
      ],
    );
  }
}
