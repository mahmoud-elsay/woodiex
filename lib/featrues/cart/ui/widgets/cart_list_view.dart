import 'package:flutter/material.dart';
import 'package:woodiex/featrues/cart/ui/widgets/crat_list_view_item.dart';

class CartListView extends StatelessWidget {
  const CartListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3, // Adjust the number of items as needed
      itemBuilder: (context, index) {
        return const CartListViewItem(); // Render each item
      },
    );
  }
}
