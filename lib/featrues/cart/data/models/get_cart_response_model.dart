import 'package:json_annotation/json_annotation.dart';

part 'get_cart_response_model.g.dart';

@JsonSerializable()
class GetCartResponseModel {
  final bool success;
  final String messsage;
  final CartData data;
  final dynamic errors;
  final int statusCode;

  GetCartResponseModel({
    required this.success,
    required this.messsage,
    required this.data,
    required this.errors,
    required this.statusCode,
  });

  factory GetCartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCartResponseModelToJson(this);
}

@JsonSerializable()
class CartData {
  final int id;
  final double total;
  final List<CartItem> items;

  CartData({
    required this.id,
    required this.total,
    required this.items,
  });

  factory CartData.fromJson(Map<String, dynamic> json) =>
      _$CartDataFromJson(json);

  Map<String, dynamic> toJson() => _$CartDataToJson(this);
}

@JsonSerializable()
class CartItem {
  final int id;
  final int productId;
  final String productName;
  final String productImageUrl;
  final double price;
  final int quantity;
  final double subTotal;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImageUrl,
    required this.price,
    required this.quantity,
    required this.subTotal,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}
