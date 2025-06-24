import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/profile/reviews/data/models/my_reviews_response_model.dart';

class MyReviewsRepo {
  final ApiService _apiService;

  MyReviewsRepo(this._apiService);

  Future<ApiResult<MyReviewsResponseModel>> getMyReviews(
    String token,
  ) async {
    try {
      final response = await _apiService.getMyReviews(token);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
