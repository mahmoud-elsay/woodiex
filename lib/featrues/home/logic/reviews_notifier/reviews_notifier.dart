import 'package:woodiex/core/di/di.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/featrues/home/data/repo/reviews_repo.dart';
import 'package:woodiex/featrues/home/data/models/add_review_request_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_response_model.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_states.dart'; // Adjust the import path as needed

final reviewsNotifierProvider =
    StateNotifierProvider<ReviewsNotifier, ReviewsState>((ref) {
  final apiService = ref.watch(apiServiceProvider);
  final repo = ReviewsRepo(apiService);
  return ReviewsNotifier(repo);
});

class ReviewsNotifier extends StateNotifier<ReviewsState> {
  final ReviewsRepo _repo;

  ReviewsNotifier(this._repo) : super(const ReviewsInitial());

  Future<void> addReview(
      String token, AddReviewRequestModel requestModel) async {
    state = ReviewsLoading(AddReviewResponseModel(
      success: false,
      messsage: '',
      data: null,
      errors: null,
      statusCode: 0,
    )); // Initial loading state with default data

    final result = await _repo.addReview(token, requestModel);

    result.when(
      success: (response) {
        state = ReviewsSuccess(response);
      },
      failure: (error) {
        state = ReviewsError(error);
      },
    );
  }
}
