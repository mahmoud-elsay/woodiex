import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';
import 'package:woodiex/featrues/home/data/models/filter_product_model.dart';

class GetProductRepo {
  final ApiService _apiService;

  GetProductRepo(this._apiService);

  Future<ApiResult<GetProductResponseModel>> getProducts(
    String token,
    int pageIndex,
  ) async {
    try {
      final response = await _apiService.getProducts(token, pageIndex);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<FilterProductModel>> getFilteredProducts(
    String token,
    String categories,
  ) async {
    try {
      final response = await _apiService.getFilterProducts(token, categories);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
