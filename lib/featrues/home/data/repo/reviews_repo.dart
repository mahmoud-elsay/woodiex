import 'package:woodiex/core/network/api_result.dart';
import 'package:woodiex/core/network/api_service.dart';
import 'package:woodiex/core/network/api_error_handler.dart';
import 'package:woodiex/featrues/home/data/models/add_review_request_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_response_model.dart';

class ReviewsRepo {
  final ApiService _apiService;

  ReviewsRepo(this._apiService);

  Future<ApiResult<AddReviewResponseModel>> addReview(
    String token,
    AddReviewRequestModel requestModel,
  ) async {
    try {
      final response = await _apiService.addReview(requestModel, token);
      return ApiResult.success(response);
    } catch (error) {
      return ApiResult.failure(ApiErrorHandler.handle(error));
    }
  }
}
