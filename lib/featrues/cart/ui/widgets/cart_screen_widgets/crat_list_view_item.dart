import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/custom_snakbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/cart/logic/cart_notifier.dart';
import 'package:woodiex/featrues/cart/data/models/get_cart_response_model.dart';

class CartListViewItem extends ConsumerStatefulWidget {
  final CartItem item;

  const CartListViewItem({super.key, required this.item});

  @override
  ConsumerState<CartListViewItem> createState() => _CartListViewItemState();
}

class _CartListViewItemState extends ConsumerState<CartListViewItem> {
  late int quantity = widget.item.quantity;

  void _increaseQuantity() {
    setState(() {
      quantity++;
      // Optionally, update the cart via notifier (not implemented here)
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

  void _removeItem() async {
    final notifier = ref.read(getCartNotifierProvider.notifier);
    await notifier.deleteCartItem(widget.item.productId);
    // Show feedback (e.g., snackbar) - optional, based on UI preference
    CustomSnackBar.showSuccess(
      context,
      'Item removed from cart',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  widget.item.productImageUrl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            horizontalSpace(30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.item.productName,
                  style: Fonts.nunitoSans14SemiBoldSecondaryGrey,
                ),
                verticalSpace(10),
                Text(
                  '\$${widget.item.price}',
                  style: Fonts.nunitoSans16BoldMainBlack,
                ),
                verticalSpace(20),
                Row(
                  children: [
                    GestureDetector(
                      onTap: _increaseQuantity,
                      child: SvgPicture.asset('assets/svgs/add.svg'),
                    ),
                    horizontalSpace(5),
                    Text(
                      quantity.toString(),
                      style: Fonts.nunitoSans18SemiBoldMainBlack,
                    ),
                    horizontalSpace(5),
                    GestureDetector(
                      onTap: _decreaseQuantity,
                      child: SvgPicture.asset('assets/svgs/decrease.svg'),
                    ),
                  ],
                )
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: _removeItem,
              child: SvgPicture.asset('assets/svgs/remove.svg'),
            ),
          ],
        ),
        verticalSpace(10),
        Divider(
          height: 1.h,
          color: Colors.grey.shade300,
        ),
        verticalSpace(20),
      ],
    );
  }
}
