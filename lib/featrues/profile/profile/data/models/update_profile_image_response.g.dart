// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileImageResponse _$UpdateProfileImageResponseFromJson(
        Map<String, dynamic> json) =>
    UpdateProfileImageResponse(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: json['data'],
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$UpdateProfileImageResponseToJson(
        UpdateProfileImageResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };
