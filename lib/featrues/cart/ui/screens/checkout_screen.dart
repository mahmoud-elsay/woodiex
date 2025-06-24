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
import 'package:woodiex/featrues/cart/logic/cart_notifier.dart';
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
  double _cartTotal = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(shippingAddressNotifierProvider.notifier).getShippingAddress();
      // Retrieve arguments
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      print('CheckoutScreen initState - Raw arguments: $args');
      if (args != null && args.containsKey('total')) {
        _cartTotal = (args['total'] as num?)?.toDouble() ?? 0.0;
        print(
            'CheckoutScreen initState - Retrieved cartTotal from arguments: $_cartTotal');
      } else {
        print(
            'CheckoutScreen initState - No valid arguments or total provided, checking getCartNotifierProvider');
        // Fallback to getCartNotifierProvider
        final cartState = ref.read(getCartNotifierProvider);
        cartState.when(
          success: (data) {
            _cartTotal = data.data.total;
            print(
                'CheckoutScreen initState - Retrieved cartTotal from getCartNotifierProvider: $_cartTotal');
          },
          loading: (data) {
            _cartTotal = data?.data.total ?? 0.0;
            print(
                'CheckoutScreen initState - Retrieved cartTotal from loading state: $_cartTotal');
          },
          initial: () => print(
              'CheckoutScreen initState - Cart state is initial, using default: $_cartTotal'),
          error: (error) => print(
              'CheckoutScreen initState - Cart state error: ${error.message}, using default: $_cartTotal'),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final orderState = ref.watch(orderNotifierProvider);
    final shippingAddressState = ref.watch(shippingAddressNotifierProvider);

    final subTotal = _cartTotal;
    final finalTotal = subTotal + deliveryCost;

    print(
        'CheckoutScreen build - cartTotal: $_cartTotal, subTotal: $subTotal, finalTotal: $finalTotal');

    if (_cartTotal <= 0) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Text(
              'Error: Cart is empty or total is zero',
              style: Fonts.nunitoSans18RegularSecondaryGrey,
            ),
          ),
        ),
      );
    }

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
                  buttonText: orderState.when(
                    initial: () => 'SUBMIT ORDER',
                    loading: (data) => 'PROCESSING...',
                    postSuccess: (data) =>
                        'PROCESSING...', // Disable after success
                    getSuccess: (data) => 'SUBMIT ORDER',
                    error: (error) => 'SUBMIT ORDER',
                  ),
                  textStyle: Fonts.nunitoSans18SemiBoldWhite,
                  onPressed: orderState.when(
                    initial: () => () async {
                      final notifier = ref.read(orderNotifierProvider.notifier);
                      await notifier.postOrder();
                      final updatedState = ref.read(orderNotifierProvider);
                      updatedState.when(
                        initial: () {},
                        loading: (data) {},
                        postSuccess: (data) {
                          context.pushNamed(Routes.checkoutSuccess);
                        },
                        getSuccess: (data) {},
                        error: (error) {
                          CustomSnackBar.showError(
                            context,
                            'Error: ${error.message}',
                          );
                        },
                      );
                    },
                    loading: (data) => null,
                    postSuccess: (data) => null, // Disable after success
                    getSuccess: (data) => () async {
                      final notifier = ref.read(orderNotifierProvider.notifier);
                      await notifier.postOrder();
                      final updatedState = ref.read(orderNotifierProvider);
                      updatedState.when(
                        initial: () {},
                        loading: (data) {},
                        postSuccess: (data) {
                          context.pushNamed(Routes.checkoutSuccess);
                        },
                        getSuccess: (data) {},
                        error: (error) {
                          CustomSnackBar.showError(
                            context,
                            'Error: ${error.message}',
                          );
                        },
                      );
                    },
                    error: (error) => () async {
                      final notifier = ref.read(orderNotifierProvider.notifier);
                      await notifier.postOrder();
                      final updatedState = ref.read(orderNotifierProvider);
                      updatedState.when(
                        initial: () {},
                        loading: (data) {},
                        postSuccess: (data) {
                          context.pushNamed(Routes.checkoutSuccess);
                        },
                        getSuccess: (data) {},
                        error: (error) {
                          CustomSnackBar.showError(
                            context,
                            'Error: ${error.message}',
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
