import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/custom_snakbar.dart';
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
  final double deliveryCost = 10.0;
  double? _cartTotal;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shippingAddressNotifierProvider.notifier).getShippingAddress();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Get the arguments once and store them
    if (_cartTotal == null) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      _cartTotal = args?['total'] as double? ?? 0.0;
      print(
          'CheckoutScreen didChangeDependencies - Received cartTotal: $_cartTotal');
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderNotifierProvider);
    final shippingAddressState = ref.watch(shippingAddressNotifierProvider);

    // Use the stored cart total
    final cartTotal = _cartTotal ?? 0.0;
    final subTotal = cartTotal;
    final finalTotal = subTotal + deliveryCost;

    print(
        'CheckoutScreen build - cartTotal: $cartTotal, subTotal: $subTotal, finalTotal: $finalTotal');

    final selectedAddress = shippingAddressState.maybeWhen(
      getShippingAddressSuccess: (data) {
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
                ShippingAddressForCheckout(selectedAddress: selectedAddress),
                verticalSpace(15),
                InfoCard(
                  title: 'Payment',
                  iconPath: 'assets/svgs/visa_card.svg',
                  cardText: '**** **** **** 3947',
                  onEditTap: () {
                    context.pushNamed(Routes.paymentMethods);
                  },
                ),
                verticalSpace(15),
                InfoCard(
                  title: 'Delivery method',
                  iconPath: 'assets/svgs/dhl.svg',
                  cardText: 'Fast (2-3days)',
                  onEditTap: () {},
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
                      ? null
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
                              CustomSnackBar.showError(
                                context,
                                'Error: ${error.message}',
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
