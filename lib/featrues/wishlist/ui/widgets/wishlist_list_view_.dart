import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/featrues/wishlist/logic/wishlist_notifier.dart';
import 'package:woodiex/featrues/wishlist/data/wishlist_item_model.dart';
import 'package:woodiex/featrues/wishlist/ui/widgets/whishlist_list_view_item.dart';

class WishlistListView extends ConsumerWidget {
  final List<WishlistItem> items;

  const WishlistListView({super.key, required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistNotifier = ref.read(wishlistNotifierProvider.notifier);

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return WishlistListViewItem(
          item: item,
          onRemove: () => wishlistNotifier.removeFromWishlist(item.id),
        );
      },
    );
  }
}
