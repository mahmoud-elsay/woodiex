import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/orders/ui/widgets/order_filter.dart';
import 'package:woodiex/featrues/profile/orders/ui/widgets/orders_list_view.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        children: [
          BackableTopBar(screenTitle: 'My Orders'),
          verticalSpace(15),
          OrderFilter(),
          verticalSpace(15),
          Expanded(child: OrdersListView())
        ],
      ),
    )));
  }
}
