import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/cart/logic/cart_states.dart';
import 'package:woodiex/featrues/cart/data/models/get_cart_response_model.dart';
import 'package:woodiex/featrues/cart/data/models/add_product_response_model.dart';
import 'package:woodiex/featrues/cart/data/models/delete_cart_item_response_model.dart';

part 'cart_notifier.g.dart';

// Separate provider for AddCart functionality
@riverpod
class AddCartNotifier extends _$AddCartNotifier {
  AddProductResponseModel? _cartResponse;
  static const String _cachedCartProductIdsKey = 'cachedCartProductIds';

  @override
  AddCartState build() => const AddCartInitial();

  Future<void> addToCart(int productId, int quantity) async {
    print(
        'Adding product to cart for productId: $productId, quantity: $quantity');
    state = AddCartLoading(_cartResponse ??
        AddProductResponseModel(
          success: false,
          messsage: '',
          data: false,
          errors: null,
          statusCode: 0,
        ));

    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved: $token');
    if (token.isEmpty) {
      print('Token is empty, setting error state');
      state = AddCartError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref
        .read(cartRepoProvider)
        .addToCart('Bearer $token', productId, quantity);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, product added to cart');
        _cartResponse = response;
        state = AddCartSuccess(_cartResponse!);
        // Refresh the cart after adding a product
        ref.invalidate(getCartNotifierProvider);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = AddCartError(error);
      },
    );
  }

  Future<void> clearCartState() async {
    print('Clearing cart state');
    _cartResponse = null;
    state = const AddCartInitial();
  }

  // Helper method to retrieve cached product IDs
  Future<List<int>> getCachedProductIds() async {
    final ids = await SharedPrefHelper.getString(_cachedCartProductIdsKey);
    return ids.isNotEmpty ? (ids.split(',').map(int.parse).toList()) : [];
  }
}

// Separate provider for GetCart functionality
@riverpod
class GetCartNotifier extends _$GetCartNotifier {
  GetCartResponseModel? _getCartResponse;
  static const String _cachedCartProductIdsKey = 'cachedCartProductIds';

  @override
  GetCartState build() => const GetCartInitial();

  Future<void> getCart() async {
    print('Fetching cart details');
    state = GetCartLoading(_getCartResponse ??
        GetCartResponseModel(
          success: false,
          messsage: '',
          data: CartData(id: 0, total: 0.0, items: []),
          errors: null,
          statusCode: 0,
        ));

    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved: $token');
    if (token.isEmpty) {
      print('Token is empty, setting error state');
      state = GetCartError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref.read(cartRepoProvider).getCart('Bearer $token');
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, cart retrieved');
        _getCartResponse = response;
        // Cache product IDs from items
        final productIds =
            _getCartResponse!.data.items.map((item) => item.productId).toList();
        SharedPrefHelper.setData(_cachedCartProductIdsKey, productIds);
        state = GetCartSuccess(_getCartResponse!);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = GetCartError(error);
      },
    );
  }

  Future<void> deleteCartItem(int productId) async {
    print('Deleting cart item with productId: $productId');

    // Immediate UI update - remove item from current state
    if (_getCartResponse != null) {
      final updatedItems = _getCartResponse!.data.items
          .where((item) => item.productId != productId)
          .toList();
      final newTotal =
          updatedItems.fold(0.0, (sum, item) => sum + item.subTotal);

      _getCartResponse = _getCartResponse!.copyWith(
        data: _getCartResponse!.data
            .copyWith(items: updatedItems, total: newTotal),
      );
      state = GetCartSuccess(_getCartResponse!);
    }

    // Make API call in background
    _deleteCartItemFromServer(productId);
  }

  Future<void> _deleteCartItemFromServer(int productId) async {
    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved: $token');
    if (token.isEmpty) {
      print('Token is empty, reverting changes');
      // Revert by refreshing cart
      await getCart();
      return;
    }

    final result = await ref
        .read(cartRepoProvider)
        .deleteCartItem('Bearer $token', productId);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, product removed from cart on server');
        // Update cached product IDs
        if (_getCartResponse != null) {
          final productIds = _getCartResponse!.data.items
              .map((item) => item.productId)
              .toList();
          SharedPrefHelper.setData(_cachedCartProductIdsKey, productIds);
        }
      },
      failure: (error) async {
        print('Failure, error: ${error.message}');
        // Revert changes by refreshing cart from server
        await getCart();
      },
    );
  }

  Future<void> clearGetCartState() async {
    print('Clearing get cart state');
    _getCartResponse = null;
    state = const GetCartInitial();
  }
}
