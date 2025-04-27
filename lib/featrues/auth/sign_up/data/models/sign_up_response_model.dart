import 'package:json_annotation/json_annotation.dart';

part 'sign_up_response_model.g.dart';

@JsonSerializable()
class SignUpResponseModel {
  final bool success;
  @JsonKey(name: 'messsage') // Match API's field name
  final String message;
  final Data data;
  final dynamic errors;
  final int statusCode;

  SignUpResponseModel({
    required this.success,
    required this.message,
    required this.data,
    this.errors,
    required this.statusCode,
  });

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseModelToJson(this);
}

@JsonSerializable()
class Data {
  final String fullName;
  final String email;
  final String token;

  Data({
    required this.fullName,
    required this.email,
    required this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => _$DataFromJson(json);
  Map<String, dynamic> toJson() => _$DataToJson(this);
}
