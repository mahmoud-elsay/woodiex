import 'package:json_annotation/json_annotation.dart';

part 'add_review_response_model.g.dart';

@JsonSerializable()
class AddReviewResponseModel {
  final bool success;
  final String messsage;
  final AddReviewData? data;
  final dynamic errors;
  final int statusCode;

  AddReviewResponseModel({
    required this.success,
    required this.messsage,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory AddReviewResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddReviewResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddReviewResponseModelToJson(this);
}

@JsonSerializable()
class AddReviewData {
  final int id;
  final int rating;
  final String comment;
  final String createdAt;
  final String userName;
  final String userImageUrl;

  AddReviewData({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.userName,
    required this.userImageUrl,
  });

  factory AddReviewData.fromJson(Map<String, dynamic> json) =>
      _$AddReviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddReviewDataToJson(this);
}
