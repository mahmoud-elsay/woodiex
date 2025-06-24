import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  final bool success;
  final String messsage;
  final LoginData? data;
  final dynamic errors;
  final int statusCode;

  LoginResponseModel({
    required this.success,
    required this.messsage,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}

@JsonSerializable()
class LoginData {
  final String fullName;
  final String email;
  final String token;

  LoginData({
    required this.fullName,
    required this.email,
    required this.token,
  });

  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
