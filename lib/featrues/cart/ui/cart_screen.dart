import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/cart/ui/widgets/bottom_cart.dart';
import 'package:woodiex/featrues/cart/ui/widgets/cart_list_view.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
          Expanded(child: CartListView()),
          verticalSpace(10),
          BottomCart()
        ],
      ),
    )));
  }
}
