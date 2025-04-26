import 'package:woodiex/core/di/di.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
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

    final response = await ref.read(signUpRepoProvider).signUp(requestModel);

    response.when(
      success: (signUpResponse) {
        state = SignUpSuccess(signUpResponse);
      },
      failure: (error) {
        state = SignUpError(error);
      },
    );
  }
}
