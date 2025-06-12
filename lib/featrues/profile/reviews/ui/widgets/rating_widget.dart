import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingWidget extends StatelessWidget {
  final int rating;
  final double starSize;

  const RatingWidget({
    super.key,
    this.rating = 5,
    this.starSize = 18,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: SvgPicture.asset(
            'assets/svgs/star.svg',
            width: starSize,
            height: starSize,
            color: index < rating ? Color(0xFFF2C94C) : Colors.grey,
          ),
        );
      }),
    );
  }
}
