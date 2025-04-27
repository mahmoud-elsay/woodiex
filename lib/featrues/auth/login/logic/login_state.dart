import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/auth/login/data/models/login_response_model.dart';


sealed class LoginState {
  const LoginState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(LoginResponseModel data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      LoginInitial _ => initial(),
      LoginLoading _ => loading(),
      LoginSuccess(data: final data) => success(data),
      LoginError(error: final errorModel) => error(errorModel),
    };
  }
}

class LoginInitial extends LoginState {
  const LoginInitial();
}

class LoginLoading extends LoginState {
  const LoginLoading();
}

class LoginSuccess extends LoginState {
  final LoginResponseModel data;

  const LoginSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class LoginError extends LoginState {
  final ApiErrorModel error;

  const LoginError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}