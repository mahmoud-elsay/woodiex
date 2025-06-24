import 'package:flutter/material.dart';
import 'package:woodiex/featrues/cart/data/models/get_cart_response_model.dart';
import 'package:woodiex/featrues/cart/ui/widgets/cart_screen_widgets/crat_list_view_item.dart';

class CartListView extends StatelessWidget {
  final List<CartItem> items;

  const CartListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CartListViewItem(item: items[index]);
      },
    );
  }
}
