import 'package:woodiex/core/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/featrues/home/data/models/add_review_request_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_response_model.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_states.dart';
import 'package:woodiex/featrues/home/data/models/get_reviews_response_model.dart';

part 'reviews_notifier.g.dart';

@riverpod
class ReviewsNotifier extends _$ReviewsNotifier {
  AddReviewResponseModel? _addReviewResponse;
  GetReviewsResponseModel? _getReviewsResponse;

  @override
  ReviewsState build() => const ReviewsInitial();

  Future<void> addReview(
      String token, AddReviewRequestModel requestModel) async {
    print('Adding review with token: $token');
    state = ReviewsLoading(
      addData: _addReviewResponse,
      getReviewsData: _getReviewsResponse,
    );

    final result =
        await ref.read(reviewsRepoProvider).addReview(token, requestModel);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, review added');
        _addReviewResponse = response;
        state = ReviewsSuccess(
          addData: _addReviewResponse,
          getReviewsData: _getReviewsResponse,
        );
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = ReviewsError(error);
      },
    );
  }

  Future<void> getReviews(String token, int productId) async {
    print('Getting reviews for product: $productId with token: $token');
    state = ReviewsLoading(
      addData: _addReviewResponse,
      getReviewsData: _getReviewsResponse,
    );

    final result =
        await ref.read(reviewsRepoProvider).getReviews(token, productId);
    print('Get reviews API response: $result');

    result.when(
      success: (response) {
        print('Success, reviews fetched');
        _getReviewsResponse = response;
        state = ReviewsSuccess(
          addData: _addReviewResponse,
          getReviewsData: _getReviewsResponse,
        );
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = ReviewsError(error);
      },
    );
  }

  Future<void> clearReviewState() async {
    print('Clearing review state');
    _addReviewResponse = null;
    _getReviewsResponse = null;
    state = const ReviewsInitial();
  }

  Future<void> clearAddReviewData() async {
    print('Clearing add review data');
    _addReviewResponse = null;
    state = ReviewsSuccess(
      addData: null,
      getReviewsData: _getReviewsResponse,
    );
  }

  Future<void> clearGetReviewsData() async {
    print('Clearing get reviews data');
    _getReviewsResponse = null;
    state = ReviewsSuccess(
      addData: _addReviewResponse,
      getReviewsData: null,
    );
  }

  // Getters for easier access to data
  AddReviewResponseModel? get addReviewData => _addReviewResponse;
  GetReviewsResponseModel? get getReviewsData => _getReviewsResponse;
}
