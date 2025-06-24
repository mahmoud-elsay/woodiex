// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_cart_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeleteCartItemResponseModel _$DeleteCartItemResponseModelFromJson(
        Map<String, dynamic> json) =>
    DeleteCartItemResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: json['data'] as bool,
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$DeleteCartItemResponseModelToJson(
        DeleteCartItemResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };
