import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/info_card.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/order_details.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/shipping_address_for_checkout.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              BackableTopBar(screenTitle: 'checkout'),
              verticalSpace(15),
              ShippingAddressForCheckout(),
              verticalSpace(15),
              InfoCard(
                title: 'Payment',
                iconPath: 'assets/svgs/visa_card.svg',
                cardText: '**** **** **** 3947',
                onEditTap: () {},
              ),
              verticalSpace(15),
              InfoCard(
                title: 'Delivery method',
                iconPath: 'assets/svgs/dhl.svg',
                cardText: 'Fast (2-3days)',
                onEditTap: () {},
              ),
              verticalSpace(30),
              OrderDetails(),
              verticalSpace(50),
              AppTextButton(
                  buttonText: 'SUBMIT ORDER',
                  textStyle:
                      Fonts.whiteNunitoSansSemiBold18.copyWith(fontSize: 20.sp),
                  onPressed: () {})
            ],
          ),
        ),
      )),
    );
  }
}
