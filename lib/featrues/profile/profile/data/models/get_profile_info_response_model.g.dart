// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileInfoResponseModel _$GetProfileInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetProfileInfoResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : Data.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$GetProfileInfoResponseModelToJson(
        GetProfileInfoResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

Data _$DataFromJson(Map<String, dynamic> json) => Data(
      fullName: json['fullName'] as String,
      userName: json['userName'] as String,
      profileImage: json['profileImage'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$DataToJson(Data instance) => <String, dynamic>{
      'fullName': instance.fullName,
      'userName': instance.userName,
      'profileImage': instance.profileImage,
      'email': instance.email,
    };
