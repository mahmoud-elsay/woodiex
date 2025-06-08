import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/cart/logic/cart_states.dart';
import 'package:woodiex/featrues/cart/data/models/add_product_response_model.dart';

part 'cart_notifier.g.dart';

@riverpod
class CartNotifier extends _$CartNotifier {
  AddProductResponseModel? _cartResponse;

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
}
