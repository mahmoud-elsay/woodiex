import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/reviews/logic/my_reviews_state.dart';
import 'package:woodiex/featrues/profile/reviews/data/models/my_reviews_response_model.dart';

part 'my_reviews_notifier.g.dart';

@riverpod
class MyReviewsNotifier extends _$MyReviewsNotifier {
  MyReviewsResponseModel? _myReviewsResponse;

  @override
  MyReviewsState build() => const MyReviewsInitial();

  Future<void> getMyReviews() async {
    print('Getting my reviews');
    state = MyReviewsLoading(data: _myReviewsResponse);

    final token = await SharedPrefHelper.getUserToken();
    print('Retrieved token: $token'); // Debug full token
    if (token.isEmpty) {
      print('Token is empty, setting error state');
      state = MyReviewsError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final authToken = 'Bearer $token'; // Add Bearer prefix
    print('Formatted auth token: $authToken'); // Debug formatted token

    final result =
        await ref.read(myReviewsRepoProvider).getMyReviews(authToken);
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, my reviews fetched: ${response.data?.length} reviews');
        _myReviewsResponse = response;
        state = MyReviewsSuccess(data: _myReviewsResponse);
      },
      failure: (error) {
        print(
            'Failure, error: ${error.message}, statusCode: ${error.statusCode}');
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
