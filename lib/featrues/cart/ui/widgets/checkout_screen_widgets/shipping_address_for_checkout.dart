import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';

class ShippingAddressForCheckout extends StatefulWidget {
  final AddressData? selectedAddress;

  const ShippingAddressForCheckout({super.key, this.selectedAddress});

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
    _updateAddressText();
  }

  @override
  void didUpdateWidget(ShippingAddressForCheckout oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedAddress != widget.selectedAddress) {
      _updateAddressText();
    }
  }

  void _updateAddressText() {
    if (widget.selectedAddress != null) {
      _addressController.text =
          '${widget.selectedAddress!.city ?? ''}, ${widget.selectedAddress!.country ?? ''}';
    } else {
      _addressController.text = 'No address selected';
    }
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
                // Navigate to shipping address screen to select/edit address
                context.pushNamed(Routes.shippingAddreesScreen);
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
                  widget.selectedAddress?.fullName ?? 'No name',
                  style: Fonts.nunitoSans18BoldMainBlack,
                ),
                verticalSpace(7),
                Divider(
                  color: Colors.grey.shade200,
                  height: 0.3.h,
                ),
                verticalSpace(10),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _addressController.text,
                    style: Fonts.nunitoSans14RegularSecondaryGrey,
                  ),
                ),
                if (widget.selectedAddress?.zipCode != null) ...[
                  verticalSpace(5),
                  Text(
                    'Phone: ${widget.selectedAddress!.zipCode}',
                    style: Fonts.nunitoSans14RegularSecondaryGrey,
                  ),
                ],
                if (widget.selectedAddress == null) ...[
                  verticalSpace(10),
                  GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.shippingAddreesScreen);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsManager.mainBlack,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Text(
                        'Select Address',
                        style: Fonts.nunitoSans14RegularSecondaryGrey.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
