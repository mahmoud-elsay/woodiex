import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/auth/sign_up/data/models/sign_up_response_model.dart';

sealed class SignUpState {
  const SignUpState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(SignUpResponseModel data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      SignUpInitial _ => initial(),
      SignUpLoading _ => loading(),
      SignUpSuccess(data: final data) => success(data),
      SignUpError(error: final errorModel) => error(errorModel),
    };
  }
}

class SignUpInitial extends SignUpState {
  const SignUpInitial();
}

class SignUpLoading extends SignUpState {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpState {
  final SignUpResponseModel data;

  const SignUpSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class SignUpError extends SignUpState {
  final ApiErrorModel error;

  const SignUpError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignUpError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
