import 'package:json_annotation/json_annotation.dart';

part 'my_reviews_response_model.g.dart';

@JsonSerializable()
class MyReviewsResponseModel {
  final bool success;
  final String messsage;
  final List<MyReviewData>? data;
  final dynamic errors;
  final int statusCode;

  MyReviewsResponseModel({
    required this.success,
    required this.messsage,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory MyReviewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MyReviewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$MyReviewsResponseModelToJson(this);
}

@JsonSerializable()
class MyReviewData {
  final String name;
  final String productImageUrl;
  final double price;
  final int rate;
  final String comment;
  final String dateOfCreation;

  MyReviewData({
    required this.name,
    required this.productImageUrl,
    required this.price,
    required this.rate,
    required this.comment,
    required this.dateOfCreation,
  });

  factory MyReviewData.fromJson(Map<String, dynamic> json) =>
      _$MyReviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$MyReviewDataToJson(this);
}
