import 'colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fonts {
  static TextStyle gelasio24SemiBold = GoogleFonts.gelasio(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: ColorsManager.moreDarkGrey,
  );

  static TextStyle gelasio30Bold = GoogleFonts.gelasio(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: ColorsManager.darkGrey,
  );

  static TextStyle nunitoSansRegular18 = GoogleFonts.nunitoSans(
    fontSize: 18,
    fontWeight: FontWeight.w400, // Regular
    color: ColorsManager.secondaryGrey,
  );
}
