// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewRequestModel _$AddReviewRequestModelFromJson(
        Map<String, dynamic> json) =>
    AddReviewRequestModel(
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
      productId: (json['productId'] as num).toInt(),
    );

Map<String, dynamic> _$AddReviewRequestModelToJson(
        AddReviewRequestModel instance) =>
    <String, dynamic>{
      'rating': instance.rating,
      'comment': instance.comment,
      'productId': instance.productId,
    };
