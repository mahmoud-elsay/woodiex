import 'package:flutter/material.dart';
import 'whishlist_list_view_item.dart';

class WishlistListView extends StatelessWidget {
  const WishlistListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // Adjust the number of items as needed
      itemBuilder: (context, index) {
        return const WhishlistListViewItem(); // Render each item
      },
    );
  }
}
