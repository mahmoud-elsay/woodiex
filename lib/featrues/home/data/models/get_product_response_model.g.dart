// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_product_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProductResponseModel _$GetProductResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetProductResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => ProductData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$GetProductResponseModelToJson(
        GetProductResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
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
