import 'orders_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/orders/data/models/get_order_response_model.dart';

class OrdersListView extends StatelessWidget {
  final List<Order> orders;
  final String selectedFilter;

  const OrdersListView({
    super.key,
    required this.orders,
    required this.selectedFilter,
  });

  @override
  Widget build(BuildContext context) {
    // Filter orders based on selected filter
    final filteredOrders = _filterOrders();

    if (filteredOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.filter_list_off,
              size: 48.r,
              color: Colors.grey,
            ),
            verticalSpace(16),
            Text(
              'No ${selectedFilter.toLowerCase()} orders found',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: filteredOrders.length,
      itemBuilder: (context, index) {
        return OrdersListViewItem(
          order: filteredOrders[index],
        );
      },
      separatorBuilder: (context, index) {
        return verticalSpace(25);
      },
    );
  }

  List<Order> _filterOrders() {
    if (selectedFilter == 'All') {
      return orders;
    }

    return orders.where((order) {
      final status = order.status.toLowerCase();
      final filter = selectedFilter.toLowerCase();

      return status == filter;
    }).toList();
  }
}
