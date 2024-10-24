import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'orders_list_view_item.dart'; // Import your OrdersListViewItem

class OrdersListView extends StatelessWidget {
  const OrdersListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 10, // Set the number of items here
      itemBuilder: (context, index) {
        // Build each item (OrdersListViewItem)
        return const OrdersListViewItem();
      },
      separatorBuilder: (context, index) {
        // Define the separator between items
        return verticalSpace(25);
      },
    );
  }
}
