import 'package:woodiex/core/network/api_error_model.dart';

sealed class ProfileImageState {
  const ProfileImageState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(String imagePath) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      ProfileImageInitial _ => initial(),
      ProfileImageLoading _ => loading(),
      ProfileImageSuccess(imagePath: final imagePath) => success(imagePath),
      ProfileImageError(error: final errorModel) => error(errorModel),
    };
  }
}

class ProfileImageInitial extends ProfileImageState {
  const ProfileImageInitial();
}

class ProfileImageLoading extends ProfileImageState {
  const ProfileImageLoading();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileImageLoading && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ProfileImageSuccess extends ProfileImageState {
  final String imagePath;

  const ProfileImageSuccess(this.imagePath);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileImageSuccess &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath;

  @override
  int get hashCode => imagePath.hashCode;
}

class ProfileImageError extends ProfileImageState {
  final ApiErrorModel error;

  const ProfileImageError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileImageError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
