import 'package:dio/dio.dart';
import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/profile/profile/data/models/update_profile_image_response.dart';

class ProfileRepo {
  final ApiService _apiService;

  ProfileRepo(this._apiService);

  Future<ApiResult<UpdateProfileImageResponse>> updateProfileImage(
    String token,
    FormData formData,
  ) async {
    try {
      final response = await _apiService.updateProfileImage(token, formData);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
