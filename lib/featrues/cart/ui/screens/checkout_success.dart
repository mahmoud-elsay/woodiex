import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckoutSuccess extends StatelessWidget {
  const CheckoutSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              verticalSpace(150),
              Text(
                'SUCCESS!',
                style: Fonts.merriweather36BoldMainBlack,
              ),
              verticalSpace(30),
              SvgPicture.asset('assets/svgs/order_done.svg'),
              verticalSpace(5),
              SvgPicture.asset('assets/svgs/done.svg'),
              verticalSpace(25),
              Text(
                '''Your order will be delivered soon.
            Thank you for choosing our app!''',
                style: Fonts.nunitoSans18RegularSecondaryGrey,
                textAlign: TextAlign.center,
              ),
              verticalSpace(30),
              AppTextButton(
                  buttonText: 'Track your orders',
                  textStyle: Fonts.nunitoSans18SemiBoldWhite,
                  onPressed: () {
                    context.pushReplacementNamed(Routes.myOrders);
                  }),
              verticalSpace(10),
              AppTextButton(
                  buttonText: 'BACK TO HOME',
                  textStyle: Fonts.nunitoSans18SemiBoldMainBlack,
                  backgroundColor: ColorsManager.white,
                  onPressed: () {
                    context.pushReplacementNamed(Routes.appLayout);
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
