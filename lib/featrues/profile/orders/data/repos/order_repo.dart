import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_request_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_response_model.dart';

class OrderRepo {
  final ApiService _apiService;

  OrderRepo(this._apiService);

  Future<ApiResult<PostOrderResponseModel>> postOrder(
    String token,
    PostOrderRequestModel requestModel,
  ) async {
    try {
      final response = await _apiService.postOrder(requestModel, token);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
