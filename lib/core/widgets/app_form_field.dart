import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String hintText;
  final bool? isObscureText;
  final Widget? suffixIcon;
  final Color? backgroundColor;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.isObscureText,
    this.suffixIcon,
    this.backgroundColor,
    this.validator,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        focusedBorder: focusedBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.mainBlack,
                width: 1.3,
              ),
            ),
        enabledBorder: enabledBorder ??
            const UnderlineInputBorder(
              borderSide: BorderSide(
                color: ColorsManager.lightGrey,
                width: 1.3,
              ),
            ),
        hintStyle: hintStyle ?? Fonts.nunitoSans18RegularSecondaryGrey,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? Colors.transparent,
        filled: true,
      ),
      obscureText: isObscureText ?? false,
      style: inputTextStyle ?? Fonts.nunitoSans18RegularSecondaryGrey,
      validator: validator,
    );
  }
}
