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
import 'package:woodiex/featrues/cart/ui/widgets/checkout_screen_widgets/shipping_address_for_checkout.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  _CheckoutScreenState createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  double? passedTotal; // To store the total passed from CartScreen

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Retrieve the total from navigation arguments when the screen is initialized
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (arguments != null && arguments['total'] != null) {
      setState(() {
        passedTotal = arguments['total'] as double;
      });
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
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
                  cardText:
                      'Fast (2-3days)', // Could be dynamic based on deliveryMethodName
                  onEditTap: () {},
                ),
                verticalSpace(30),
                // Use order data for OrderDetails if available, fallback to passedTotal
                orderState.when(
                  initial: () => OrderDetails(
                    total: passedTotal ?? 0.0,
                    subTotal:
                        passedTotal != null ? (passedTotal! - 10.0) : 90.0,
                    deliveryCost: 10.0,
                  ),
                  loading: (data) => OrderDetails(
                    total: passedTotal ?? data.data?.total ?? 0.0,
                    subTotal: passedTotal != null
                        ? (passedTotal! - 10.0)
                        : (data.data?.subTotal ?? 90.0),
                    deliveryCost: 10.0,
                  ),
                  success: (data) => OrderDetails(
                    total: data.data?.total ?? passedTotal ?? 0.0,
                    subTotal: data.data?.subTotal ??
                        (passedTotal != null ? (passedTotal! - 10.0) : 90.0),
                    deliveryCost: 10.0,
                  ),
                  error: (error) => Center(
                    child: Text('Error: ${error.message}'),
                  ),
                ),
                verticalSpace(50),
                AppTextButton(
                  buttonText: 'SUBMIT ORDER',
                  textStyle: Fonts.nunitoSans18SemiBoldWhite,
                  onPressed: () async {
                    // Trigger order submission
                    final notifier = ref.read(orderNotifierProvider.notifier);
                    await notifier.postOrder();
                    // Check the state after submission
                    final updatedState = ref.read(orderNotifierProvider);
                    updatedState.when(
                      initial: () {},
                      loading: (data) {},
                      success: (data) {
                        // Redirect to success screen on success
                        context.pushNamed(Routes.checkoutSuccess);
                      },
                      error: (error) {
                        // Optionally show a snackbar or dialog for error
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

// Updated OrderDetails to accept dynamic data
class OrderDetails extends StatelessWidget {
  final double? total;
  final double? subTotal;
  final double? deliveryCost;

  const OrderDetails({
    super.key,
    this.total,
    this.subTotal,
    this.deliveryCost,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveTotal = total ?? 100.0; // Default value if not provided
    final effectiveSubTotal = subTotal ?? 90.0; // Default value
    final effectiveDeliveryCost = deliveryCost ?? 10.0; // Default value

    return Container(
      height: 135.h,
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Subtotal :',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                const Spacer(),
                Text(
                  '\$${effectiveSubTotal.toStringAsFixed(2)}',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Text(
                  'Delivery: ',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                Spacer(),
                Text(
                  '\$${effectiveDeliveryCost.toStringAsFixed(2)}',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                ),
              ],
            ),
            verticalSpace(10),
            Row(
              children: [
                Text(
                  'Total :',
                  style: Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                Spacer(),
                Text(
                  '\$${effectiveTotal.toStringAsFixed(2)}',
                  style: Fonts.nunitoSans18SemiBoldMainBlack,
                ),
              ],
            ),
            verticalSpace(10),
          ],
        ),
      ),
    );
  }
}
