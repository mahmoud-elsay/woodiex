// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reviews_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyReviewsResponseModel _$MyReviewsResponseModelFromJson(
        Map<String, dynamic> json) =>
    MyReviewsResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => MyReviewData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$MyReviewsResponseModelToJson(
        MyReviewsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

MyReviewData _$MyReviewDataFromJson(Map<String, dynamic> json) => MyReviewData(
      name: json['name'] as String,
      productImageUrl: json['productImageUrl'] as String,
      price: (json['price'] as num).toDouble(),
      rate: (json['rate'] as num).toInt(),
      comment: json['comment'] as String,
      dateOfCreation: json['dateOfCreation'] as String,
    );

Map<String, dynamic> _$MyReviewDataToJson(MyReviewData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'productImageUrl': instance.productImageUrl,
      'price': instance.price,
      'rate': instance.rate,
      'comment': instance.comment,
      'dateOfCreation': instance.dateOfCreation,
    };
