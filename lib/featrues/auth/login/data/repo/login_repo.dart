import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_request_model.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_response_model.dart';

class LoginRepo {
  final ApiService _apiService;
  LoginRepo(this._apiService);
  Future<ApiResult<LoginResponseModel>> login(
      LoginRequestModel loginRequestModel) async {
    try {
      final response = await _apiService.login(loginRequestModel);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
