import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_model.g.dart';

@JsonSerializable()
class SignUpRequestModel {
  final String fullName;
  final String userName;
  final String email;
  final String password;
  final String confirmPassword;

  SignUpRequestModel({
    required this.fullName,
    required this.userName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  factory SignUpRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpRequestModelToJson(this);
}
