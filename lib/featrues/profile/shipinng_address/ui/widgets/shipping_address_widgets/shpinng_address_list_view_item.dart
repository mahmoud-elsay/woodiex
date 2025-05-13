import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';

class ShpinngAddressListViewItem extends StatefulWidget {
  final AddressData? address;

  const ShpinngAddressListViewItem({super.key, this.address});

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
    _addressController.text = widget.address?.fullName != null
        ? '${widget.address?.fullName}, ${widget.address?.city}, ${widget.address?.country}'
        : 'Elmansora, Elmeena';
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
              style: Fonts.nunitoSans18RegularMainBlack,
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
                      widget.address?.fullName ?? 'mostfa naf3',
                      style: Fonts.nunitoSans18BoldMainBlack,
                    ),
                    horizontalSpace(170),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isEditing = !_isEditing;
                        });
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
                        style: Fonts.nunitoSans14RegularSecondaryGrey,
                        textAlign: TextAlign.left,
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
                              color: ColorsManager.mainBlack,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.r),
                            borderSide: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 10.h,
                            horizontal: 10.w,
                          ),
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            _isEditing = false;
                          });
                        },
                      )
                    : Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _addressController.text,
                          style: Fonts.nunitoSans14RegularSecondaryGrey,
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
