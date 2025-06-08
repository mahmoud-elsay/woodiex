import 'package:json_annotation/json_annotation.dart';

part 'product_details_response_model.g.dart';

@JsonSerializable()
class ProductDetailsResponseModel {
  final bool success;
  final String messsage;
  final ProductDetailsData data;
  final dynamic errors;
  final int statusCode;

  ProductDetailsResponseModel({
    required this.success,
    required this.messsage,
    required this.data,
    required this.errors,
    required this.statusCode,
  });

  factory ProductDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseModelToJson(this);
}

@JsonSerializable()
class ProductDetailsData {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final double price;
  final int reviewsCount;
  final double reveiewAverageRating;
  final List<dynamic> reviews;

  ProductDetailsData({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.price,
    required this.reviewsCount,
    required this.reveiewAverageRating,
    required this.reviews,
  });

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsDataToJson(this);
}
