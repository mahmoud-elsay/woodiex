import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/auth/sign_up/logic/sign_up_state.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_request_model.dart';

part 'sign_up_notifier.g.dart';

@riverpod
class SignUpNotifier extends _$SignUpNotifier {
  @override
  SignUpState build() {
    return const SignUpInitial();
  }

  Future<void> signUp({
    required String fullName,
    required String userName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    state = const SignUpLoading();

    final requestModel = SignUpRequestModel(
      fullName: fullName,
      userName: userName,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );

    print('SignUpRequestModel: ${requestModel.toJson()}');

    try {
      final response = await ref.read(signUpRepoProvider).signUp(requestModel);
      response.when(
        success: (signUpResponse) async {
          await SharedPrefHelper.saveUserToken(signUpResponse.data.token);
          print('SignUp successful: ${signUpResponse.toJson()}');
          state = SignUpSuccess(signUpResponse);
        },
        failure: (error) {
          print('SignUp failed: ${error.message}');
          state = SignUpError(error);
        },
      );
    } catch (e, stackTrace) {
      print('Exception in SignUpNotifier: $e');
      print('StackTrace: $stackTrace');
      state = SignUpError(ApiErrorModel(
        message: 'Unexpected error: $e',
        statusCode: 0,
      ));
    }
  }
}
