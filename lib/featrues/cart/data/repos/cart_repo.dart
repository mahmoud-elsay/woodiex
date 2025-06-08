import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/cart/data/models/get_cart_response_model.dart';
import 'package:woodiex/featrues/cart/data/models/add_product_response_model.dart';

class CartRepo {
  final ApiService _apiService;

  CartRepo(this._apiService);

  Future<ApiResult<AddProductResponseModel>> addToCart(
    String token,
    int productId,
    int quantity,
  ) async {
    try {
      final response = await _apiService.addToCart(productId, quantity, token);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetCartResponseModel>> getCart(String token) async {
    try {
      final response = await _apiService.getCart(token);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
