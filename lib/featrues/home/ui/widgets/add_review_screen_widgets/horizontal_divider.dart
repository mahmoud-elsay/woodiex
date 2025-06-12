import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HorizontalDivider extends StatelessWidget {
  final double? thickness;
  final Color? color;
  const HorizontalDivider({super.key, this.thickness, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color ?? ColorsManager.secondaryGrey,
      height: 0.2.h,
      thickness: thickness,
    );
  }
}
