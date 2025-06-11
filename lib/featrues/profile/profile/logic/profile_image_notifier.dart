import 'package:dio/dio.dart';
import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/profile/logic/profile_image_states.dart';

part 'profile_image_notifier.g.dart';

@riverpod
class ProfileImageNotifier extends _$ProfileImageNotifier {
  @override
  ProfileImageState build() => const ProfileImageInitial();

  Future<void> updateProfileImage(String token, FormData formData) async {
    print('Notifier: Starting updateProfileImage with token: $token');
    state = const ProfileImageLoading();
    print('Notifier: State set to Loading');

    final profileRepo = ref.read(profileRepoProvider);
    try {
      final result = await profileRepo.updateProfileImage(token, formData);
      print('Notifier: API result: $result');

      result.when(
        success: (response) async {
          print('Notifier: Success response: $response');
          if (response.success) {
            final imagePath = response.data?.toString() ?? '';
            state = ProfileImageSuccess(imagePath);
            print('Notifier: State set to Success with imagePath: $imagePath');
            await SharedPrefHelper.setData('profile_image_path', imagePath);
          } else {
            state = ProfileImageError(ApiErrorModel(
                message: response.messsage ?? 'Unknown error',
                statusCode: response.statusCode ?? 0));
            print('Notifier: State set to Error: ${response.messsage}');
          }
        },
        failure: (error) {
          state = ProfileImageError(error);
          print('Notifier: State set to Error: ${error.message}');
        },
      );
    } catch (e) {
      print('Notifier: Unexpected error: $e');
      state = ProfileImageError(
          ApiErrorModel(message: e.toString(), statusCode: 0));
    }
  }

  Future<String?> getCachedProfileImagePath() async {
    return await SharedPrefHelper.getString('profile_image_path');
  }

  Future<void> clearCachedProfileImagePath() async {
    await SharedPrefHelper.removeData('profile_image_path');
  }
}
