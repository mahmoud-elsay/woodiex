import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/shipinng_address/ui/widgets/shipping_address_widgets/shpinng_address_list_view.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            Row(
              children: [
                BackableTopBar(
                  screenTitle: 'Shipping Address',
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    context.pushNamed(Routes.addShippingAddressScreen);
                  },
                  child: Icon(
                    Icons.add_circle_outline_rounded,
                    color: ColorsManager.mainBlack,
                    size: 30.h,
                  ),
                ),
              ],
            ),
            verticalSpace(10),
            Expanded(child: ShippingAddressListView())
          ],
        ),
      )),
    );
  }
}
