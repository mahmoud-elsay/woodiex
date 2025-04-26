import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_response_model.dart';


class SignUpRepo {
  final ApiService _apiService;

  SignUpRepo(this._apiService);

  Future<ApiResult<SignUpResponseModel>> signUp(
      SignUpRequestModel signUpRequestModel) async {
    try {
      final response = await _apiService.signUp(signUpRequestModel);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}