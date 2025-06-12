import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/profile/reviews/data/models/my_reviews_response_model.dart';

sealed class MyReviewsState {
  const MyReviewsState();

  T when<T>({
    required T Function() initial,
    required T Function(MyReviewsResponseModel? data) loading,
    required T Function(MyReviewsResponseModel? data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      MyReviewsInitial _ => initial(),
      MyReviewsLoading(data: final data) => loading(data),
      MyReviewsSuccess(data: final data) => success(data),
      MyReviewsError(error: final errorModel) => error(errorModel),
    };
  }
}

class MyReviewsInitial extends MyReviewsState {
  const MyReviewsInitial();
}

class MyReviewsLoading extends MyReviewsState {
  final MyReviewsResponseModel? data;

  const MyReviewsLoading({this.data});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyReviewsLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class MyReviewsSuccess extends MyReviewsState {
  final MyReviewsResponseModel? data;

  const MyReviewsSuccess({this.data});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyReviewsSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class MyReviewsError extends MyReviewsState {
  final ApiErrorModel error;

  const MyReviewsError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MyReviewsError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
