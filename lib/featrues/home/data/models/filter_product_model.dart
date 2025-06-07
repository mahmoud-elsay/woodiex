import 'package:json_annotation/json_annotation.dart';

part 'filter_product_model.g.dart';

@JsonSerializable()
class FilterProductModel {
  final bool success;
  final String messsage; // Updated to match the JSON typo
  final List<ProductData> data;
  final dynamic errors;
  final int statusCode;

  FilterProductModel({
    required this.success,
    required this.messsage,
    required this.data,
    required this.errors,
    required this.statusCode,
  });

  factory FilterProductModel.fromJson(Map<String, dynamic> json) =>
      _$FilterProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$FilterProductModelToJson(this);
}

@JsonSerializable()
class ProductData {
  final int id;
  final String imageUrl;
  final String name;
  final double price;

  ProductData({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.price,
  });

  factory ProductData.fromJson(Map<String, dynamic> json) =>
      _$ProductDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDataToJson(this);
}
