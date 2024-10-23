import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShpinngAddressListViewItem extends StatefulWidget {
  const ShpinngAddressListViewItem({super.key});

  @override
  State<ShpinngAddressListViewItem> createState() =>
      _ShpinngAddressListViewItemState();
}

class _ShpinngAddressListViewItemState
    extends State<ShpinngAddressListViewItem> {
  bool _isChecked = false;
  bool _isEditing = false;
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _addressController.text = 'Elmansora, Elmeena';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              activeColor: ColorsManager.mainBlack,
              checkColor: ColorsManager.white,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value ?? false;
                });
              },
              value: _isChecked,
            ),
            Text(
              'Use as the shipping address',
              style: Fonts.nunitoSansRegular18
                  .copyWith(color: ColorsManager.mainBlack),
            ),
          ],
        ),
        verticalSpace(5),
        Container(
          height: 127.h,
          width: 335.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'mostfa naf3',
                      style: Fonts.blacknNnitoSansBold18,
                    ),
                    horizontalSpace(170),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEditing = !_isEditing; // Toggle edit mode
                        });
                        // Log the edit icon click
                        debugPrint('Edit icon clicked');
                      },
                      child: SvgPicture.asset('assets/svgs/edit_icon.svg'),
                    ),
                  ],
                ),
                verticalSpace(7),
                Divider(
                  color: Colors.grey.shade200,
                  height: 0.3.h,
                ),
                _isEditing
                    ? TextField(
                        controller: _addressController,
                        style: Fonts.nunitoSansRegular14,
                        textAlign: TextAlign.left, // Align text to the left
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: ColorsManager
                                  .mainBlack, // Border color on focus
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Colors
                                  .grey.shade300, // Border color when enabled
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _isEditing = false; // Exit edit mode
                          });
                        },
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _addressController.text,
                          style: Fonts.nunitoSansRegular14,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
