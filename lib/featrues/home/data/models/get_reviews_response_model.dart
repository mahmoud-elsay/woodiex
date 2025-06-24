import 'package:json_annotation/json_annotation.dart';

part 'get_reviews_response_model.g.dart';

@JsonSerializable()
class GetReviewsResponseModel {
  final bool success;
  final String messsage; // Note: keeping the typo as in your API
  final GetReviewsData data;
  final dynamic errors;
  final int statusCode;

  GetReviewsResponseModel({
    required this.success,
    required this.messsage,
    required this.data,
    this.errors,
    required this.statusCode,
  });

  factory GetReviewsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetReviewsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetReviewsResponseModelToJson(this);
}

@JsonSerializable()
class GetReviewsData {
  final String productImageUrl;
  final double averageRate;
  final String productName;
  final int reviewsCount;
  final List<ReviewItem> reviews;

  GetReviewsData({
    required this.productImageUrl,
    required this.averageRate,
    required this.productName,
    required this.reviewsCount,
    required this.reviews,
  });

  factory GetReviewsData.fromJson(Map<String, dynamic> json) =>
      _$GetReviewsDataFromJson(json);

  Map<String, dynamic> toJson() => _$GetReviewsDataToJson(this);

  GetReviewsData copyWith({
    String? productImageUrl,
    double? averageRate,
    String? productName,
    int? reviewsCount,
    List<ReviewItem>? reviews,
  }) {
    return GetReviewsData(
      productImageUrl: productImageUrl ?? this.productImageUrl,
      averageRate: averageRate ?? this.averageRate,
      productName: productName ?? this.productName,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      reviews: reviews ?? this.reviews,
    );
  }
}

@JsonSerializable()
class ReviewItem {
  final int id;
  final int rating;
  final String comment;
  final DateTime createdAt;
  final String userName;
  final String userImageUrl;

  ReviewItem({
    required this.id,
    required this.rating,
    required this.comment,
    required this.createdAt,
    required this.userName,
    required this.userImageUrl,
  });

  factory ReviewItem.fromJson(Map<String, dynamic> json) =>
      _$ReviewItemFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewItemToJson(this);

  ReviewItem copyWith({
    int? id,
    int? rating,
    String? comment,
    DateTime? createdAt,
    String? userName,
    String? userImageUrl,
  }) {
    return ReviewItem(
      id: id ?? this.id,
      rating: rating ?? this.rating,
      comment: comment ?? this.comment,
      createdAt: createdAt ?? this.createdAt,
      userName: userName ?? this.userName,
      userImageUrl: userImageUrl ?? this.userImageUrl,
    );
  }
}
