import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/cart/logic/cart_states.dart';
import 'package:woodiex/featrues/cart/logic/cart_notifier.dart';
import 'package:woodiex/featrues/cart/ui/widgets/cart_screen_widgets/bottom_cart.dart';
import 'package:woodiex/featrues/cart/ui/widgets/cart_screen_widgets/cart_list_view.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  double _lastKnownTotal = 0.0;

  @override
  void initState() {
    super.initState();
    print('CartScreen initState called');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        print('CartScreen: Calling getCart from initState');
        await ref.read(getCartNotifierProvider.notifier).getCart();
        print('CartScreen: getCart completed in initState');
      } catch (e) {
        print('Error fetching cart in initState: $e');
      }
    });
  }

  void _navigateToCheckout(double total) {
    print('=== NAVIGATION DEBUG ===');
    print('CartScreen - _navigateToCheckout called with total: $total');
    print('CartScreen - _lastKnownTotal: $_lastKnownTotal');
    // Verify cart state before navigation
    final cartState = ref.read(getCartNotifierProvider);
    cartState.when(
      initial: () => print('CartScreen - Cart state before nav: Initial'),
      loading: (data) => print(
          'CartScreen - Cart state before nav: Loading, total: ${data?.data.total}'),
      success: (data) {
        print(
            'CartScreen - Cart state before nav: Success, total: ${data.data.total}');
        print('CartScreen - Items count: ${data.data.items.length}');
        for (var item in data.data.items) {
          print(
              'CartScreen - Item: productId=${item.productId}, quantity=${item.quantity}, price=${item.price}, subTotal=${item.subTotal}');
        }
      },
      error: (error) =>
          print('CartScreen - Cart state before nav: Error - ${error.message}'),
    );
    if (total <= 0) {
      print('CartScreen - Total is zero, preventing navigation');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text(
                'Cannot proceed to checkout: Cart is empty or total is zero')),
      );
      return;
    }
    print('CartScreen - Navigating to checkout...');

    // Create arguments map
    final arguments = {'total': total};
    print('CartScreen - Arguments being passed: $arguments');

    // Navigate
    try {
      context.pushNamed(
        Routes.checkoutScreen,
        arguments: arguments,
      );
      print('CartScreen - Navigation call successful');
    } catch (e) {
      print('CartScreen - Navigation error: $e');
    }

    print('CartScreen - Navigation call completed');
    print('========================');
  }

  @override
  Widget build(BuildContext context) {
    print('CartScreen build called');

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
                    final getCartState = ref.watch(getCartNotifierProvider);
                    print(
                        'CartScreen - Cart state: ${getCartState.runtimeType}');

                    return getCartState.when(
                      initial: () {
                        print('CartScreen - State: Initial');
                        return const Center(child: CircularProgressIndicator());
                      },
                      loading: (data) {
                        print(
                            'CartScreen - State: Loading, data available: ${data != null}');
                        if (data != null) {
                          print(
                              'CartScreen - Loading data total: ${data.data.total}');
                        }
                        return data != null
                            ? CartListView(items: data.data.items)
                            : const Center(child: CircularProgressIndicator());
                      },
                      success: (data) {
                        print('CartScreen - State: Success');
                        print(
                            'CartScreen - Success data total: ${data.data.total}');
                        print(
                            'CartScreen - Success data items count: ${data.data.items.length}');

                        // Debug each item
                        for (int i = 0; i < data.data.items.length; i++) {
                          final item = data.data.items[i];
                          print(
                              'CartScreen - Item $i: productId=${item.productId}, quantity=${item.quantity}, price=${item.price}, subTotal=${item.subTotal}');
                        }

                        _lastKnownTotal = data.data.total;
                        print(
                            'CartScreen - Updated _lastKnownTotal to: $_lastKnownTotal');
                        return CartListView(items: data.data.items);
                      },
                      error: (error) {
                        print('CartScreen - State: Error - ${error.message}');
                        return Center(child: Text('Error: ${error.message}'));
                      },
                    );
                  },
                ),
              ),
              verticalSpace(10),
              Consumer(
                builder: (context, ref, child) {
                  final getCartState = ref.watch(getCartNotifierProvider);
                  print('CartScreen - BottomCart Consumer rebuild');

                  final currentTotal = getCartState.when(
                    initial: () {
                      print(
                          'CartScreen - BottomCart: Using initial total: $_lastKnownTotal');
                      return _lastKnownTotal;
                    },
                    loading: (data) {
                      final total = data?.data.total ?? _lastKnownTotal;
                      print(
                          'CartScreen - BottomCart: Using loading total: $total');
                      return total;
                    },
                    success: (data) {
                      final total = data.data.total;
                      _lastKnownTotal = total;
                      print(
                          'CartScreen - BottomCart: Using success total: $total');
                      print(
                          'CartScreen - BottomCart: Updated _lastKnownTotal to: $_lastKnownTotal');
                      return total;
                    },
                    error: (_) {
                      print(
                          'CartScreen - BottomCart: Using error fallback total: $_lastKnownTotal');
                      return _lastKnownTotal;
                    },
                  );

                  print('CartScreen - BottomCart final total: $currentTotal');

                  return BottomCart(
                    total: currentTotal,
                    onCheckout: () {
                      print('CartScreen - BottomCart onCheckout pressed');
                      _navigateToCheckout(currentTotal);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
