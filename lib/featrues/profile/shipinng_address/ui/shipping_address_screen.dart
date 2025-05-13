import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/widgets/loading_circle_indicator.dart';
import 'package:woodiex/featrues/profile/shipinng_address/logic/shipping_address_notifier.dart';
import 'package:woodiex/featrues/profile/shipinng_address/ui/widgets/shipping_address_widgets/shpinng_address_list_view.dart';

class ShippingAddressScreen extends ConsumerStatefulWidget {
  const ShippingAddressScreen({super.key});

  @override
  _ShippingAddressScreenState createState() => _ShippingAddressScreenState();
}

class _ShippingAddressScreenState extends ConsumerState<ShippingAddressScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch shipping addresses when the screen initializes
    ref.read(shippingAddressNotifierProvider.notifier).getShippingAddress();
  }

  @override
  Widget build(BuildContext context) {
    final shippingAddressState = ref.watch(shippingAddressNotifierProvider);

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
                  const Spacer(),
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
              Expanded(
                child: shippingAddressState.when(
                  initial: () =>
                      const Center(child: Text('Loading addresses...')),
                  loading: () => const Center(child: LoadingCircleIndicator()),
                  addShippingAddressSuccess: (data) =>
                      const ShippingAddressListView(),
                  getShippingAddressSuccess: (data) =>
                      ShippingAddressListView(addresses: data.data),
                  error: (error) =>
                      Center(child: Text('Error: ${error.message}')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
