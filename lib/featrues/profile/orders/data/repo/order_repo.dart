import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_response_model.dart';



class OrderRepo {
  final ApiService _apiService;

  OrderRepo(this._apiService);

  Future<ApiResult<PostOrderResponseModel>> postOrder(
    String token,
  ) async {
    try {
      final response = await _apiService.postOrder(2, token); // Static deliveryMethodId = 2
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}