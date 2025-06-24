import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/theming/font_weight.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/orders/data/models/get_order_response_model.dart';

class OrdersListViewItem extends StatelessWidget {
  final Order order;

  const OrdersListViewItem({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.h,
      margin: EdgeInsets.all(10),
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
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  'Order No${order.id}',
                  style: Fonts.nunitoSans18SemiBoldSecondaryGrey
                      .copyWith(fontSize: 16),
                ),
                Spacer(),
                Text(
                  _formatDate(order.orderDate),
                  style: Fonts.nunitoSans14RegularSecondaryGrey
                      .copyWith(fontSize: 14),
                ),
              ],
            ),
            Divider(
              color: Colors.grey.shade200,
              height: 0.3.h,
            ),
            verticalSpace(25),
            Row(
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Quantity: ',
                        style: Fonts.nunitoSans14RegularSecondaryGrey.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeightHelper.semiBold,
                        ),
                      ),
                      TextSpan(
                        text: '${_getTotalQuantity()}',
                        style: Fonts.nunitoSans18BoldMainBlack
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Total Amount: ',
                        style: Fonts.nunitoSans14RegularSecondaryGrey.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeightHelper.semiBold,
                        ),
                      ),
                      TextSpan(
                        text: '\$${order.total.toStringAsFixed(2)}',
                        style: Fonts.nunitoSans18BoldMainBlack
                            .copyWith(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            verticalSpace(50),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to order details screen
                    _showOrderDetails(context);
                  },
                  child: Container(
                    width: 100.h,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: ColorsManager.mainBlack,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomRight: Radius.circular(8),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Detail',
                        style: Fonts.nunitoSans18SemiBoldWhite
                            .copyWith(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  _capitalizeStatus(order.status),
                  style: Fonts.nunitoSans18SemiBoldMainBlack.copyWith(
                    fontSize: 16,
                    color: _getStatusColor(order.status),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
    } catch (e) {
      return dateString; // Return original if parsing fails
    }
  }

  int _getTotalQuantity() {
    return order.items.fold(0, (sum, item) => sum + item.quantity);
  }

  String _capitalizeStatus(String status) {
    return status.substring(0, 1).toUpperCase() +
        status.substring(1).toLowerCase();
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return ColorsManager.green;
      case 'pending':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'processing':
        return Colors.blue;
      default:
        return ColorsManager.secondaryGrey;
    }
  }

  void _showOrderDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Column(
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  'Order Details',
                  style: Fonts.nunitoSans18BoldMainBlack,
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: EdgeInsets.all(20.w),
                  children: [
                    _buildDetailRow('Order ID', order.id.toString()),
                    _buildDetailRow('Status', _capitalizeStatus(order.status)),
                    _buildDetailRow('Date', _formatDate(order.orderDate)),
                    _buildDetailRow(
                        'Delivery Method', order.deliveryMethodName),
                    _buildDetailRow(
                        'Subtotal', '\$${order.subTotal.toStringAsFixed(2)}'),
                    _buildDetailRow(
                        'Total', '\$${order.total.toStringAsFixed(2)}'),
                    verticalSpace(20),
                    Text(
                      'Shipping Address',
                      style: Fonts.nunitoSans18SemiBoldMainBlack,
                    ),
                    verticalSpace(10),
                    Text(
                      '${order.shippingAddress.fullName}\n'
                      '${order.shippingAddress.district}, ${order.shippingAddress.city}\n'
                      '${order.shippingAddress.country} - ${order.shippingAddress.zipCode}',
                      style: Fonts.nunitoSans14RegularSecondaryGrey,
                    ),
                    verticalSpace(20),
                    Text(
                      'Items (${order.items.length})',
                      style: Fonts.nunitoSans18SemiBoldMainBlack,
                    ),
                    verticalSpace(10),
                    ...order.items
                        .map((item) => Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.r),
                                    child: Image.network(
                                      item.pictureUrl,
                                      width: 50.w,
                                      height: 50.h,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Container(
                                        width: 50.w,
                                        height: 50.h,
                                        color: Colors.grey[200],
                                        child: Icon(Icons.image_not_supported),
                                      ),
                                    ),
                                  ),
                                  horizontalSpace(12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.productName,
                                          style: Fonts
                                              .nunitoSans14RegularMainBlack,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          'Qty: ${item.quantity} × \$${item.price.toStringAsFixed(2)}',
                                          style: Fonts
                                              .nunitoSans12RegularSecondaryGrey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Fonts.nunitoSans14RegularSecondaryGrey,
          ),
          Text(
            value,
            style: Fonts.nunitoSans14RegularMainBlack.copyWith(
              fontWeight: FontWeightHelper.semiBold,
            ),
          ),
        ],
      ),
    );
  }
}
