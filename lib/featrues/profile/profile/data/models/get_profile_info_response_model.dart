import 'package:json_annotation/json_annotation.dart';

part 'get_profile_info_response_model.g.dart';

@JsonSerializable()
class GetProfileInfoResponseModel {
  final bool success;
  final String message;
  final Data? data;
  final dynamic errors; // Can be null or a list/map depending on API
  final int statusCode;

  GetProfileInfoResponseModel({
    required this.success,
    required this.message,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory GetProfileInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetProfileInfoResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetProfileInfoResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final String fullName;
  final String userName;
  final String profileImage;
  final String email;

  Data({
    required this.fullName,
    required this.userName,
    required this.profileImage,
    required this.email,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);

  Map<String, dynamic> toJson() => _$DataToJson(this);
}
