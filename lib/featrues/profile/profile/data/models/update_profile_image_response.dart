import 'package:json_annotation/json_annotation.dart';

part 'update_profile_image_response.g.dart';

@JsonSerializable(explicitToJson: true)
class UpdateProfileImageResponse {
  final bool success;
  final String messsage;
  final dynamic data;
  final dynamic errors;
  final int statusCode;

  UpdateProfileImageResponse({
    required this.success,
    required this.messsage,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory UpdateProfileImageResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileImageResponseToJson(this);
}
