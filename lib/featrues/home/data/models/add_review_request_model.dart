import 'package:json_annotation/json_annotation.dart';

part 'add_review_request_model.g.dart';

@JsonSerializable()
class AddReviewRequestModel {
  final int rating;
  final String comment;
  final int productId;

  AddReviewRequestModel({
    required this.rating,
    required this.comment,
    required this.productId,
  });

  factory AddReviewRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddReviewRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddReviewRequestModelToJson(this);
}
