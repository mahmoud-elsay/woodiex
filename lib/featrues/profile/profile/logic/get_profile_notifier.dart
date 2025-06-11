import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/profile/logic/get_profile_staets.dart';
import 'package:woodiex/featrues/profile/profile/data/models/get_profile_info_response_model.dart';

part 'get_profile_notifier.g.dart';

@riverpod
class GetProfileNotifier extends _$GetProfileNotifier {
  @override
  GetProfileState build() => const GetProfileInitial();

  Future<void> getProfileInfo(String token) async {
    print('GetProfileNotifier: Starting getProfileInfo with token: $token');
    state = const GetProfileLoading();
    print('GetProfileNotifier: State set to Loading');

    final profileRepo = ref.read(profileRepoProvider);
    try {
      print('GetProfileNotifier: About to call profileRepo.getProfileInfo');
      final result = await profileRepo.getProfileInfo(token);
      print('GetProfileNotifier: API result: $result');

      result.when(
        success: (response) async {
          print('GetProfileNotifier: Success response: $response');
          print('GetProfileNotifier: Response success: ${response.success}');
          print('GetProfileNotifier: Response message: ${response.message}');
          print('GetProfileNotifier: Response data: ${response.data}');

          if (response.success == true) {
            state = GetProfileSuccess(response);
            print('GetProfileNotifier: State set to Success with profile data');

            // Cache profile data if needed
            if (response.data != null) {
              await _cacheProfileData(response.data!);
              print('GetProfileNotifier: Profile data cached successfully');
            }
          } else {
            final errorMessage = response.message ?? 'Profile fetch failed';
            print(
                'GetProfileNotifier: API returned success=false with message: $errorMessage');
            state = GetProfileError(ApiErrorModel(
                message: errorMessage, statusCode: response.statusCode ?? 0));
            print('GetProfileNotifier: State set to Error: $errorMessage');
          }
        },
        failure: (error) {
          print('GetProfileNotifier: API failure occurred');
          print('GetProfileNotifier: Error message: ${error.message}');
          print('GetProfileNotifier: Error status code: ${error.statusCode}');
          print('GetProfileNotifier: Full error object: $error');

          state = GetProfileError(error);
          print('GetProfileNotifier: State set to Error: ${error.message}');
        },
      );
    } catch (e, stackTrace) {
      print('GetProfileNotifier: Unexpected error: $e');
      print('GetProfileNotifier: Stack trace: $stackTrace');
      state = GetProfileError(ApiErrorModel(
          message: 'Unexpected error: ${e.toString()}', statusCode: 0));
    }
  }

  Future<void> _cacheProfileData(Data profileData) async {
    try {
      print('GetProfileNotifier: Caching profile data...');
      await SharedPrefHelper.setData(
          'cached_full_name', profileData.fullName ?? '');
      await SharedPrefHelper.setData(
          'cached_user_name', profileData.userName ?? '');
      await SharedPrefHelper.setData(
          'cached_profile_image', profileData.profileImage ?? '');
      await SharedPrefHelper.setData('cached_email', profileData.email ?? '');
      print('GetProfileNotifier: Profile data cached successfully');
    } catch (e) {
      print('GetProfileNotifier: Error caching profile data: $e');
    }
  }

  Future<Data?> getCachedProfileData() async {
    try {
      print('GetProfileNotifier: Retrieving cached profile data...');
      final fullName = await SharedPrefHelper.getString('cached_full_name');
      final userName = await SharedPrefHelper.getString('cached_user_name');
      final profileImage =
          await SharedPrefHelper.getString('cached_profile_image');
      final email = await SharedPrefHelper.getString('cached_email');

      print(
          'GetProfileNotifier: Cached data - fullName: $fullName, userName: $userName, email: $email');

      if (fullName.isNotEmpty && userName.isNotEmpty && email.isNotEmpty) {
        final cachedData = Data(
          fullName: fullName,
          userName: userName,
          profileImage: profileImage,
          email: email,
        );
        print('GetProfileNotifier: Returning cached profile data');
        return cachedData;
      }

      print('GetProfileNotifier: No valid cached data found');
      return null;
    } catch (e) {
      print('GetProfileNotifier: Error getting cached profile data: $e');
      return null;
    }
  }

  Future<void> clearCachedProfileData() async {
    try {
      print('GetProfileNotifier: Clearing cached profile data...');
      await SharedPrefHelper.removeData('cached_full_name');
      await SharedPrefHelper.removeData('cached_user_name');
      await SharedPrefHelper.removeData('cached_profile_image');
      await SharedPrefHelper.removeData('cached_email');
      print('GetProfileNotifier: Cached profile data cleared');
    } catch (e) {
      print('GetProfileNotifier: Error clearing cached profile data: $e');
    }
  }

  Future<void> refreshProfile() async {
    try {
      print('GetProfileNotifier: Starting profile refresh...');
      final token = await SharedPrefHelper.getUserToken();
      print(
          'GetProfileNotifier: Retrieved token: ${token.isNotEmpty ? "Token exists" : "No token"}');

      if (token.isNotEmpty) {
        // Check if token already has Bearer prefix
        final formattedToken =
            token.startsWith('Bearer ') ? token : 'Bearer $token';
        print('GetProfileNotifier: Using formatted token for refresh');
        await getProfileInfo(formattedToken);
      } else {
        print('GetProfileNotifier: No authentication token found for refresh');
        state = GetProfileError(ApiErrorModel(
          message: 'No authentication token found',
          statusCode: 401,
        ));
      }
    } catch (e) {
      print('GetProfileNotifier: Error during profile refresh: $e');
      state = GetProfileError(ApiErrorModel(
        message: 'Failed to refresh profile: ${e.toString()}',
        statusCode: 0,
      ));
    }
  }

  // Helper method to check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await SharedPrefHelper.getUserToken();
    return token.isNotEmpty;
  }

  // Helper method to get current profile data from state
  Data? getCurrentProfileData() {
    final currentState = state;
    if (currentState is GetProfileSuccess) {
      return currentState.profileData.data;
    }
    return null;
  }
}
