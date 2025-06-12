import 'package:woodiex/core/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/featrues/home/data/models/add_review_request_model.dart';
import 'package:woodiex/featrues/home/data/models/add_review_response_model.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_states.dart';



part 'reviews_notifier.g.dart';

@riverpod
class ReviewsNotifier extends _$ReviewsNotifier {
  AddReviewResponseModel? _reviewResponse;

  @override
  ReviewsState build() => const ReviewsInitial();

  Future<void> addReview(
      String token, AddReviewRequestModel requestModel) async {
    print('Adding review with token: $token');
    state = ReviewsLoading(_reviewResponse ??
        AddReviewResponseModel(
          success: false,
          messsage: '',
          data: null,
          errors: null,
          statusCode: 0,
        ));

    final result =
        await ref.read(reviewsRepoProvider).addReview(token, requestModel);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, review added');
        _reviewResponse = response;
        state = ReviewsSuccess(_reviewResponse!);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = ReviewsError(error);
      },
    );
  }

  Future<void> clearReviewState() async {
    print('Clearing review state');
    _reviewResponse = null;
    state = const ReviewsInitial();
  }
}
