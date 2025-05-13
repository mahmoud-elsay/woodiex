import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/add_shipping_address_request_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/add_shipping_address_response_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';

class ShippingAddressRepo {
  final ApiService _apiService;

  ShippingAddressRepo(this._apiService);

  Future<ApiResult<AddShippingAddressResponseModel>> addShippingAddress(
    AddShippingAddressRequestModel requestModel,
    String token,
  ) async {
    try {
      final response =
          await _apiService.addShippingAddress(requestModel, token);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }

  Future<ApiResult<GetShippingAddressResponseModel>> getShippingAddress(
    String token,
  ) async {
    try {
      final response = await _apiService.getShippingAddress(token);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
