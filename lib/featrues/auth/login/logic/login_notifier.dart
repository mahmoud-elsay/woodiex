import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/auth/login/logic/login_state.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_request_model.dart';

part 'login_notifier.g.dart';

@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => const LoginInitial();

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const LoginLoading();

    final requestModel = LoginRequestModel(
      email: email,
      password: password,
    );

    try {
      final response = await ref.read(loginRepoProvider).login(requestModel);
      response.when(
        success: (loginResponse) async {
          await SharedPrefHelper.saveUserToken(loginResponse.data!.token);
          state = LoginSuccess(loginResponse);
        },
        failure: (error) => state = LoginError(error),
      );
    } catch (e) {
      state = LoginError(ApiErrorModel(
        message: 'Unexpected error: $e',
        statusCode: 0,
      ));
    }
  }
}
