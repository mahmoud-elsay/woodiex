// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsResponseModel _$ProductDetailsResponseModelFromJson(
        Map<String, dynamic> json) =>
    ProductDetailsResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: ProductDetailsData.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$ProductDetailsResponseModelToJson(
        ProductDetailsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

ProductDetailsData _$ProductDetailsDataFromJson(Map<String, dynamic> json) =>
    ProductDetailsData(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      reviewsCount: (json['reviewsCount'] as num).toInt(),
      reveiewAverageRating: (json['reveiewAverageRating'] as num).toDouble(),
      reviews: json['reviews'] as List<dynamic>,
    );

Map<String, dynamic> _$ProductDetailsDataToJson(ProductDetailsData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'price': instance.price,
      'reviewsCount': instance.reviewsCount,
      'reveiewAverageRating': instance.reveiewAverageRating,
      'reviews': instance.reviews,
    };
