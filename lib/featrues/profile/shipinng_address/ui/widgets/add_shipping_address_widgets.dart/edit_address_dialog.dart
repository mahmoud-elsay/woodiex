import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:woodiex/core/widgets/app_form_field.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditAddressDialog extends StatefulWidget {
  final String label;
  final String initialValue;
  final bool isDropdown;
  final List<String>? dropdownItems;
  final ValueChanged<String> onSave;

  const EditAddressDialog({
    super.key,
    required this.label,
    required this.initialValue,
    this.isDropdown = false,
    this.dropdownItems,
    required this.onSave,
  });

  @override
  _EditAddressDialogState createState() => _EditAddressDialogState();
}

class _EditAddressDialogState extends State<EditAddressDialog>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  String? _selectedValue;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
    _selectedValue = widget.initialValue;

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          backgroundColor: ColorsManager.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Edit ${widget.label}',
                  style: Fonts.nunitoSans18BoldMainBlack.copyWith(
                    color: ColorsManager.mainBlack,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpace(20),
                if (!widget.isDropdown)
                  AppTextFormField(
                    controller: _controller,
                    hintText: widget.label,
                  )
                else
                  DropdownSearch<String>(
                    selectedItem: _selectedValue,
                    items: widget.dropdownItems ?? [],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        filled: true,
                        fillColor: ColorsManager.lightGrey,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              BorderSide(color: ColorsManager.lighterGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              BorderSide(color: ColorsManager.lighterGrey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.r),
                          borderSide:
                              BorderSide(color: ColorsManager.mainBlack),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        suffixIcon: SvgPicture.asset(
                          'assets/svgs/menu_down_arrow.svg',
                          width: 16.w,
                          height: 16.h,
                          colorFilter: const ColorFilter.mode(
                            ColorsManager.mainBlack,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      baseStyle: Fonts.nunitoSans16SemiBoldMainBlack,
                    ),
                    popupProps: PopupProps.menu(
                      showSearchBox: true,
                      searchFieldProps: TextFieldProps(
                        decoration: InputDecoration(
                          hintText: 'Search ${widget.label}...',
                          hintStyle: Fonts.nunitoSans16RegularSecondaryGrey,
                          filled: true,
                          fillColor: ColorsManager.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                BorderSide(color: ColorsManager.lighterGrey),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                BorderSide(color: ColorsManager.lighterGrey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide:
                                BorderSide(color: ColorsManager.mainBlack),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 10.h),
                        ),
                      ),
                      menuProps: MenuProps(
                        backgroundColor: ColorsManager.white,
                        borderRadius: BorderRadius.circular(8.r),
                        elevation: 4,
                      ),
                      itemBuilder: (context, item, isSelected) => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        child: Text(
                          item,
                          style: isSelected
                              ? Fonts.nunitoSans16SemiBoldMainBlack
                                  .copyWith(color: ColorsManager.mainBlack)
                              : Fonts.nunitoSans16RegularSecondaryGrey,
                        ),
                      ),
                    ),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedValue = newValue;
                        });
                      }
                    },
                  ),
                verticalSpace(20),
                AppTextButton(
                  buttonText: 'Save',
                  textStyle: Fonts.nunitoSans18SemiBoldWhite,
                  backgroundColor: ColorsManager.mainBlack,
                  borderRadius: 8.r,
                  onPressed: () {
                    widget.onSave(
                        widget.isDropdown ? _selectedValue! : _controller.text);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
