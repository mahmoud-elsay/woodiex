import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';

class ProductDetailsRepo {
  final ApiService _apiService;

  ProductDetailsRepo(this._apiService);

  Future<ApiResult<ProductDetailsResponseModel>> getProductDetails(
    String token,
    int id,
  ) async {
    try {
      final response = await _apiService.getProductDetails(token, id);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
