import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/wishlist/data/wishlist_item_model.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';

part 'wishlist_notifier.g.dart';

@Riverpod(keepAlive: true) // Keep alive to persist state across navigation
class WishlistNotifier extends _$WishlistNotifier {
  static const String _wishlistKey = 'wishlist_items';

  @override
  List<WishlistItem> build() {
    // Synchronous initial state
    _initWishlist();
    return []; // Initial empty list until async data is loaded
  }

  Future<void> _initWishlist() async {
    final savedWishlist = await _loadPersistedWishlist();
    if (savedWishlist != null) {
      state = savedWishlist;
    }
  }

  Future<List<WishlistItem>?> _loadPersistedWishlist() async {
    final savedData = await SharedPrefHelper.getString(_wishlistKey);
    if (savedData.isNotEmpty) {
      // Simplified deserialization (enhance as needed based on actual storage format)
      final ids = savedData.split(',').map(int.parse).toList();
      return ids
          .map((id) => WishlistItem(id: id, name: '', price: 0.0, imageUrl: ''))
          .toList();
    }
    return null;
  }

  Future<void> _saveWishlist() async {
    final ids = state.map((item) => item.id.toString()).join(',');
    await SharedPrefHelper.setData(_wishlistKey, ids);
  }

  void addToWishlist(ProductData product) {
    final item = WishlistItem.fromProductData(product);
    if (!state.contains(item)) {
      state = [...state, item];
      _saveWishlist();
    }
  }

  void removeFromWishlist(int productId) {
    state = state.where((item) => item.id != productId).toList();
    _saveWishlist();
  }

  bool isInWishlist(int productId) {
    return state.any((item) => item.id == productId);
  }
}
