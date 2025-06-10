import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/cart/logic/cart_notifier.dart';
import 'package:woodiex/featrues/cart/ui/widgets/cart_screen_widgets/bottom_cart.dart';
import 'package:woodiex/featrues/cart/ui/widgets/cart_screen_widgets/cart_list_view.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () => ref.read(getCartNotifierProvider.notifier).getCart());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              BackableTopBar(screenTitle: 'My Cart'),
              verticalSpace(25),
              Expanded(
                child: Consumer(
                  builder: (context, ref, child) {
                    // If using separate provider approach
                    final getCartState = ref.watch(getCartNotifierProvider);

                    // If using single provider approach
                    // final notifier = ref.watch(cartNotifierProvider.notifier);
                    // final getCartState = notifier.getCartState;

                    return getCartState.when(
                      initial: () =>
                          const Center(child: CircularProgressIndicator()),
                      loading: (data) =>
                          const Center(child: CircularProgressIndicator()),
                      success: (data) => CartListView(items: data.data.items),
                      error: (error) =>
                          Center(child: Text('Error: ${error.message}')),
                    );
                  },
                ),
              ),
              verticalSpace(10),
              Consumer(
                builder: (context, ref, child) {
                  // If using separate provider approach
                  final getCartState = ref.watch(getCartNotifierProvider);

                  // If using single provider approach
                  // final notifier = ref.watch(cartNotifierProvider.notifier);
                  // final getCartState = notifier.getCartState;

                  final total = getCartState.when(
                    initial: () => 0.0,
                    loading: (data) => data?.data.total ?? 0.0,
                    success: (data) => data.data.total,
                    error: (_) => 0.0,
                  );

                  return BottomCart(total: total);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
