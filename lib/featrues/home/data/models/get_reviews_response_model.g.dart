// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_reviews_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReviewsResponseModel _$GetReviewsResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetReviewsResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: GetReviewsData.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$GetReviewsResponseModelToJson(
        GetReviewsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

GetReviewsData _$GetReviewsDataFromJson(Map<String, dynamic> json) =>
    GetReviewsData(
      productImageUrl: json['productImageUrl'] as String,
      averageRate: (json['averageRate'] as num).toDouble(),
      productName: json['productName'] as String,
      reviewsCount: (json['reviewsCount'] as num).toInt(),
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => ReviewItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetReviewsDataToJson(GetReviewsData instance) =>
    <String, dynamic>{
      'productImageUrl': instance.productImageUrl,
      'averageRate': instance.averageRate,
      'productName': instance.productName,
      'reviewsCount': instance.reviewsCount,
      'reviews': instance.reviews,
    };

ReviewItem _$ReviewItemFromJson(Map<String, dynamic> json) => ReviewItem(
      id: (json['id'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      userName: json['userName'] as String,
      userImageUrl: json['userImageUrl'] as String,
    );

Map<String, dynamic> _$ReviewItemToJson(ReviewItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt.toIso8601String(),
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
    };
