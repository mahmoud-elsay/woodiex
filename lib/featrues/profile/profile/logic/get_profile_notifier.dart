import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/profile/logic/get_profile_staets.dart';

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
      final result = await profileRepo.getProfileInfo(token);
      print('GetProfileNotifier: API result: $result');

      result.when(
        success: (response) async {
          print('GetProfileNotifier: Success response: $response');
          if (response.success) {
            state = GetProfileSuccess(response);
            print('GetProfileNotifier: State set to Success with profile data');

            // Cache profile data if needed
            if (response.data != null) {
              await _cacheProfileData(response.data!);
            }
          } else {
            state = GetProfileError(ApiErrorModel(
                message: response.message ?? 'Unknown error',
                statusCode: response.statusCode ?? 0));
            print(
                'GetProfileNotifier: State set to Error: ${response.message}');
          }
        },
        failure: (error) {
          state = GetProfileError(error);
          print('GetProfileNotifier: State set to Error: ${error.message}');
        },
      );
    } catch (e) {
      print('GetProfileNotifier: Unexpected error: $e');
      state =
          GetProfileError(ApiErrorModel(message: e.toString(), statusCode: 0));
    }
  }

  Future<void> _cacheProfileData(Data profileData) async {
    await SharedPrefHelper.setData('cached_full_name', profileData.fullName);
    await SharedPrefHelper.setData('cached_user_name', profileData.userName);
    await SharedPrefHelper.setData(
        'cached_profile_image', profileData.profileImage);
    await SharedPrefHelper.setData('cached_email', profileData.email);
  }

  Future<Data?> getCachedProfileData() async {
    try {
      final fullName = await SharedPrefHelper.getString('cached_full_name');
      final userName = await SharedPrefHelper.getString('cached_user_name');
      final profileImage =
          await SharedPrefHelper.getString('cached_profile_image');
      final email = await SharedPrefHelper.getString('cached_email');

      if (fullName != null &&
          userName != null &&
          profileImage != null &&
          email != null) {
        return Data(
          fullName: fullName,
          userName: userName,
          profileImage: profileImage,
          email: email,
        );
      }
      return null;
    } catch (e) {
      print('Error getting cached profile data: $e');
      return null;
    }
  }

  Future<void> clearCachedProfileData() async {
    await SharedPrefHelper.removeData('cached_full_name');
    await SharedPrefHelper.removeData('cached_user_name');
    await SharedPrefHelper.removeData('cached_profile_image');
    await SharedPrefHelper.removeData('cached_email');
  }

  Future<void> refreshProfile() async {
    final token = await SharedPrefHelper.getString('auth_token');
    if (token != null) {
      await getProfileInfo(token);
    } else {
      state = GetProfileError(ApiErrorModel(
        message: 'No authentication token found',
        statusCode: 401,
      ));
    }
  }
}
