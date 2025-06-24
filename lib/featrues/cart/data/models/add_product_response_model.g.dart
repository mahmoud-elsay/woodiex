// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddProductResponseModel _$AddProductResponseModelFromJson(
        Map<String, dynamic> json) =>
    AddProductResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: json['data'] as bool,
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$AddProductResponseModelToJson(
        AddProductResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };
