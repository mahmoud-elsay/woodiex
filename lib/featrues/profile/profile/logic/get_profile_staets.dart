import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/profile/profile/data/models/get_profile_info_response_model.dart';

sealed class GetProfileState {
  const GetProfileState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(GetProfileInfoResponseModel profileData) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      GetProfileInitial _ => initial(),
      GetProfileLoading _ => loading(),
      GetProfileSuccess(profileData: final profileData) => success(profileData),
      GetProfileError(error: final errorModel) => error(errorModel),
    };
  }
}

class GetProfileInitial extends GetProfileState {
  const GetProfileInitial();
}

class GetProfileLoading extends GetProfileState {
  const GetProfileLoading();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetProfileLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class GetProfileSuccess extends GetProfileState {
  final GetProfileInfoResponseModel profileData;

  const GetProfileSuccess(this.profileData);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetProfileSuccess &&
          runtimeType == other.runtimeType &&
          profileData == other.profileData;

  @override
  int get hashCode => profileData.hashCode;
}

class GetProfileError extends GetProfileState {
  final ApiErrorModel error;

  const GetProfileError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetProfileError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
