import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_response_model.dart';

sealed class ReviewsState {
  const ReviewsState();

  T when<T>({
    required T Function() initial,
    required T Function(AddReviewResponseModel data) loading,
    required T Function(AddReviewResponseModel data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      ReviewsInitial _ => initial(),
      ReviewsLoading(data: final data) => loading(data),
      ReviewsSuccess(data: final data) => success(data),
      ReviewsError(error: final errorModel) => error(errorModel),
    };
  }
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

class ReviewsLoading extends ReviewsState {
  final AddReviewResponseModel data;

  const ReviewsLoading(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class ReviewsSuccess extends ReviewsState {
  final AddReviewResponseModel data;

  const ReviewsSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ReviewsSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
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
