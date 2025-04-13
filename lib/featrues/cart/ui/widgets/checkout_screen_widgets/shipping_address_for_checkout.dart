import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShippingAddressForCheckout extends StatefulWidget {
  const ShippingAddressForCheckout({super.key});

  @override
  State<ShippingAddressForCheckout> createState() =>
      _ShippingAddressForCheckoutState();
}

class _ShippingAddressForCheckoutState
    extends State<ShippingAddressForCheckout> {
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
            Text(
              'Shipping Address',
              style: Fonts.nunitoSans18SemiBoldSecondaryGrey,
            ),
            Spacer(),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'mostfa naf3',
                  style: Fonts.nunitoSans18BoldMainBlack,
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
