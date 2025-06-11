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
    state = const ProfileImageLoading();

    final profileRepo = ref.read(profileRepoProvider);
    final result = await profileRepo.updateProfileImage(token, formData);

    result.when(
      success: (response) async {
        // Added async here
        if (response.success) {
          final imagePath = response.data?.toString() ?? '';
          state = ProfileImageSuccess(imagePath);
          // Added await keyword here
          await SharedPrefHelper.setData('profile_image_path', imagePath);
        } else {
          state = ProfileImageError(ApiErrorModel(
              message: response.messsage, statusCode: response.statusCode));
        }
      },
      failure: (error) {
        state = ProfileImageError(error);
      },
    );
  }

  Future<String?> getCachedProfileImagePath() async {
    return await SharedPrefHelper.getString('profile_image_path');
  }

  Future<void> clearCachedProfileImagePath() async {
    await SharedPrefHelper.removeData('profile_image_path');
  }
}
