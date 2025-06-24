import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';

class ShpinngAddressListViewItem extends StatefulWidget {
  final AddressData? address;
  final bool isSelected;
  final VoidCallback? onSelectionChanged;
  final VoidCallback? onEdit;

  const ShpinngAddressListViewItem({
    super.key,
    this.address,
    this.isSelected = false,
    this.onSelectionChanged,
    this.onEdit,
  });

  @override
  State<ShpinngAddressListViewItem> createState() =>
      _ShpinngAddressListViewItemState();
}

class _ShpinngAddressListViewItemState
    extends State<ShpinngAddressListViewItem> {
  bool _isEditing = false;
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateAddressText();
  }

  void _updateAddressText() {
    if (widget.address != null) {
      _addressController.text =
          '${widget.address!.city ?? ''}, ${widget.address!.country ?? ''}';
    } else {
      _addressController.text = 'Elmansora, Elmeena';
    }
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
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!();
                }
              },
              value: widget.isSelected,
            ),
            Text(
              'Use as the shipping address',
              style: Fonts.nunitoSans18RegularMainBlack,
            ),
          ],
        ),
        verticalSpace(5),
        Container(
          height: 140.h, // Increased height to accommodate phone number
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.address?.fullName ?? 'mostfa naf3',
                        style: Fonts.nunitoSans18BoldMainBlack,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (widget.onEdit != null) {
                          widget.onEdit!();
                        } else {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        }
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
                verticalSpace(5),
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
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _addressController.text,
                            style: Fonts.nunitoSans14RegularSecondaryGrey,
                          ),
                          if (widget.address?.zipCode != null) ...[
                            verticalSpace(5),
                            Text(
                              'Phone: ${widget.address!.zipCode}',
                              style: Fonts.nunitoSans14RegularSecondaryGrey,
                            ),
                          ],
                        ],
                      ),
              ],
            ),
          ),
        ),
        verticalSpace(15), // Add space between items
      ],
    );
  }
}
