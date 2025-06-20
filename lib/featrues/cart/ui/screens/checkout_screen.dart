import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/orders/logic/order_states.dart';
import 'package:woodiex/featrues/profile/orders/logic/order_notifier.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/info_card.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/order_details.dart';
import 'package:woodiex/featrues/profile/shipinng_address/logic/shipping_address_notifier.dart';
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/shipping_address_for_checkout.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  double? cartTotal;
  final double deliveryCost = 10.0; // Fixed delivery cost

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args.containsKey('total')) {
      cartTotal = args['total'] as double;
    }
  }

  @override
  void initState() {
    super.initState();
    // Fetch shipping addresses when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shippingAddressNotifierProvider.notifier).getShippingAddress();
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderNotifierProvider);
    final shippingAddressState = ref.watch(shippingAddressNotifierProvider);

    // Calculate totals
    final subTotal = cartTotal ?? 0.0;
    final finalTotal = subTotal + deliveryCost;

    // Get selected shipping address
    final selectedAddress = shippingAddressState.maybeWhen(
      getShippingAddressSuccess: (data) {
        // Return the first address or a default one
        // You might want to add logic to select the "default" address
        return data.data?.isNotEmpty == true ? data.data!.first : null;
      },
      orElse: () => null,
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
                // Pass the selected address to the shipping address widget
                ShippingAddressForCheckout(selectedAddress: selectedAddress),
                verticalSpace(15),
                InfoCard(
                  title: 'Payment',
                  iconPath: 'assets/svgs/visa_card.svg',
                  cardText: '**** **** **** 3947',
                  onEditTap: () {
                    // Navigate to payment methods screen
                    context.pushNamed(Routes.paymentMethods);
                  },
                ),
                verticalSpace(15),
                InfoCard(
                  title: 'Delivery method',
                  iconPath: 'assets/svgs/dhl.svg',
                  cardText: 'Fast (2-3days)',
                  onEditTap: () {
                    // You can add delivery method selection logic here
                  },
                ),
                verticalSpace(30),
                OrderDetails(
                  total: finalTotal,
                  subTotal: subTotal,
                  deliveryCost: deliveryCost,
                ),
                verticalSpace(50),
                AppTextButton(
                  buttonText: orderState is OrderLoading
                      ? 'PROCESSING...'
                      : 'SUBMIT ORDER',
                  textStyle: Fonts.nunitoSans18SemiBoldWhite,
                  onPressed: orderState is OrderLoading
                      ? null // Disable button during loading
                      : () async {
                          final notifier =
                              ref.read(orderNotifierProvider.notifier);
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
                                SnackBar(
                                  content: Text('Error: ${error.message}'),
                                  backgroundColor: Colors.red,
                                ),
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
