// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterProductModel _$FilterProductModelFromJson(Map<String, dynamic> json) =>
    FilterProductModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$FilterProductModelToJson(FilterProductModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

ProductData _$ProductDataFromJson(Map<String, dynamic> json) => ProductData(
      id: (json['id'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
    );

Map<String, dynamic> _$ProductDataToJson(ProductData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'imageUrl': instance.imageUrl,
      'name': instance.name,
      'price': instance.price,
    };
