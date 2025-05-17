import 'package:json_annotation/json_annotation.dart';

part 'get_product_response_model.g.dart';

@JsonSerializable()
class GetProductResponseModel {
  final bool success;
  final String messsage;
  final List<ProductData> data;
  final dynamic errors;
  final int statusCode;

  GetProductResponseModel({
    required this.success,
    required this.messsage,
    required this.data,
    this.errors,
    required this.statusCode,
  });

  factory GetProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetProductResponseModelToJson(this);
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
