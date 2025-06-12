import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/featrues/profile/reviews/logic/my_reviews_state.dart';
import 'package:woodiex/featrues/profile/reviews/data/models/my_reviews_response_model.dart';


part 'my_reviews_notifier.g.dart';

@riverpod
class MyReviewsNotifier extends _$MyReviewsNotifier {
  MyReviewsResponseModel? _myReviewsResponse;

  @override
  MyReviewsState build() => const MyReviewsInitial();

  Future<void> getMyReviews(String token) async {
    print('Getting my reviews with token: $token');
    state = MyReviewsLoading(data: _myReviewsResponse);

    final result = await ref.read(myReviewsRepoProvider).getMyReviews(token);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, my reviews fetched');
        _myReviewsResponse = response;
        state = MyReviewsSuccess(data: _myReviewsResponse);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = MyReviewsError(error);
      },
    );
  }

  Future<void> clearMyReviewsState() async {
    print('Clearing my reviews state');
    _myReviewsResponse = null;
    state = const MyReviewsInitial();
  }

  Future<void> clearMyReviewsData() async {
    print('Clearing my reviews data');
    _myReviewsResponse = null;
    state = MyReviewsSuccess(data: null);
  }

  // Getter for easier access to data
  MyReviewsResponseModel? get myReviewsData => _myReviewsResponse;
}