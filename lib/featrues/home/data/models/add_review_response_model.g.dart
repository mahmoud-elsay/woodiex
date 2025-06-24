// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_review_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddReviewResponseModel _$AddReviewResponseModelFromJson(
        Map<String, dynamic> json) =>
    AddReviewResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: json['data'] == null
          ? null
          : AddReviewData.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$AddReviewResponseModelToJson(
        AddReviewResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

AddReviewData _$AddReviewDataFromJson(Map<String, dynamic> json) =>
    AddReviewData(
      id: (json['id'] as num).toInt(),
      rating: (json['rating'] as num).toInt(),
      comment: json['comment'] as String,
      createdAt: json['createdAt'] as String,
      userName: json['userName'] as String,
      userImageUrl: json['userImageUrl'] as String,
    );

Map<String, dynamic> _$AddReviewDataToJson(AddReviewData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'rating': instance.rating,
      'comment': instance.comment,
      'createdAt': instance.createdAt,
      'userName': instance.userName,
      'userImageUrl': instance.userImageUrl,
    };
