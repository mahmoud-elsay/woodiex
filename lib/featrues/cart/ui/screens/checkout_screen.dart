import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/orders/logic/order_notifier.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/info_card.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/order_details.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/shipping_address_for_checkout.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  double? initialTotal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('total')) {
      initialTotal = args['total'] as double;
    }
  }

  @override
  void initState() {
    super.initState();
    // No initial API call here; triggered on button press instead
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderNotifierProvider);

    // Use initialTotal as the base value until success state updates it
    final displayTotal = orderState.when(
      initial: () => initialTotal ?? 0.0,
      loading: (data) => initialTotal ?? (data.data?.total ?? 0.0),
      success: (data) => data.data?.total ?? initialTotal ?? 0.0,
      error: (error) => initialTotal ?? 0.0,
    );
    final displaySubTotal = orderState.when(
      initial: () => initialTotal != null ? initialTotal! - 10.0 : 90.0,
      loading: (data) => initialTotal != null
          ? initialTotal! - 10.0
          : (data.data?.subTotal ?? 90.0),
      success: (data) =>
          data.data?.subTotal ??
          (initialTotal != null ? initialTotal! - 10.0 : 90.0),
      error: (error) => initialTotal != null ? initialTotal! - 10.0 : 90.0,
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BackableTopBar(screenTitle: 'Checkout'),
                verticalSpace(15),
                const ShippingAddressForCheckout(),
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
                orderState.when(
                  initial: () => OrderDetails(
                      total: displayTotal,
                      subTotal: displaySubTotal,
                      deliveryCost: 10.0),
                  loading: (data) => OrderDetails(
                      total: displayTotal,
                      subTotal: displaySubTotal,
                      deliveryCost: 10.0),
                  success: (data) => OrderDetails(
                    total: displayTotal,
                    subTotal: displaySubTotal,
                    deliveryCost: 10.0,
                  ),
                  error: (error) => OrderDetails(
                    total: displayTotal,
                    subTotal: displaySubTotal,
                    deliveryCost: 10.0,
                  ),
                ),
                verticalSpace(50),
                AppTextButton(
                  buttonText: 'SUBMIT ORDER',
                  textStyle: Fonts.nunitoSans18SemiBoldWhite,
                  onPressed: () async {
                    final notifier = ref.read(orderNotifierProvider.notifier);
                    await notifier.postOrder();
                    final updatedState = ref.read(orderNotifierProvider);
                    updatedState.when(
                      initial: () {},
                      loading: (data) {},
                      success: (data) {
                        context.pushNamed(Routes.checkoutSuccess);
                      },
                      error: (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${error.message}')),
                        );
                      },
                    );
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
