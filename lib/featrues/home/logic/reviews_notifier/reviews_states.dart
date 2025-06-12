import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_response_model.dart';
import 'package:woodiex/featrues/home/data/models/get_reviews_response_model.dart';

sealed class ReviewsState {
  const ReviewsState();

  T when<T>({
    required T Function() initial,
    required T Function(AddReviewResponseModel? addData,
            GetReviewsResponseModel? getReviewsData)
        loading,
    required T Function(AddReviewResponseModel? addData,
            GetReviewsResponseModel? getReviewsData)
        success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      ReviewsInitial _ => initial(),
      ReviewsLoading(
        addData: final addData,
        getReviewsData: final getReviewsData
      ) =>
        loading(addData, getReviewsData),
      ReviewsSuccess(
        addData: final addData,
        getReviewsData: final getReviewsData
      ) =>
        success(addData, getReviewsData),
      ReviewsError(error: final errorModel) => error(errorModel),
    };
  }
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

class ReviewsLoading extends ReviewsState {
  final AddReviewResponseModel? addData;
  final GetReviewsResponseModel? getReviewsData;

  const ReviewsLoading({this.addData, this.getReviewsData});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsLoading &&
          runtimeType == other.runtimeType &&
          addData == other.addData &&
          getReviewsData == other.getReviewsData;

  @override
  int get hashCode => addData.hashCode ^ getReviewsData.hashCode;
}

class ReviewsSuccess extends ReviewsState {
  final AddReviewResponseModel? addData;
  final GetReviewsResponseModel? getReviewsData;

  const ReviewsSuccess({this.addData, this.getReviewsData});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsSuccess &&
          runtimeType == other.runtimeType &&
          addData == other.addData &&
          getReviewsData == other.getReviewsData;

  @override
  int get hashCode => addData.hashCode ^ getReviewsData.hashCode;
}

class ReviewsError extends ReviewsState {
  final ApiErrorModel error;

  const ReviewsError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
