import 'colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woodiex/core/theming/font_weight.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Fonts {
  static TextStyle gelasio24SemiBold = GoogleFonts.gelasio(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.moreDarkGrey,
    height: 1.25,
  );

  static TextStyle merriweather30regular = GoogleFonts.merriweather(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.moreDarkGrey,
    height: 1.25,
  );

  static TextStyle gelasio30Bold = GoogleFonts.gelasio(
    fontSize: 30.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.darkGrey,
    height: 1.27,
  );

  static TextStyle merriweather24bold = GoogleFonts.merriweather(
    fontSize: 24.sp,
    fontWeight: FontWeightHelper.bold,
    color: ColorsManager.darkGrey,
    height: 1.25,
  );

  static TextStyle nunitoSansRegular18 = GoogleFonts.nunitoSans(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.regular, // Regular
    color: ColorsManager.secondaryGrey,
  );
  static TextStyle whiteGelasio18SemiBold = GoogleFonts.gelasio(
    fontSize: 18.sp,
    fontWeight: FontWeightHelper.semiBold,
    color: ColorsManager.white,
  );

  static TextStyle nunitoSansRegular14 = GoogleFonts.nunitoSans(
    fontSize: 14.sp,
    fontWeight: FontWeightHelper.regular,
    color: ColorsManager.secondaryGrey,
  );
}
