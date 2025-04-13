import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrease,
    required this.onDecrease,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onIncrease,
          child: SvgPicture.asset('assets/svgs/add.svg'),
        ),
        horizontalSpace(10),
        Text(
          quantity.toString(),
          style: Fonts.nunitoSans18SemiBoldMainBlack,
        ),
        horizontalSpace(10),
        GestureDetector(
          onTap: onDecrease,
          child: SvgPicture.asset('assets/svgs/decrease.svg'),
        ),
      ],
    );
  }
}
