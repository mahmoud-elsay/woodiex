import 'package:json_annotation/json_annotation.dart';

part 'post_order_response_model.g.dart';

@JsonSerializable()
class PostOrderResponseModel {
  final bool success;
  final String messsage; // Updated to match the typo in the JSON
  final OrderData? data;
  final dynamic errors; // Use dynamic for null or list of errors
  final int statusCode;

  PostOrderResponseModel({
    required this.success,
    required this.messsage,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory PostOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostOrderResponseModelToJson(this);
}

@JsonSerializable()
class OrderData {
  final int id;
  final String buyerEmail;
  final String orderDate;
  final String status;
  final ShippingAddress shippingAddress;
  final String deliveryMethodName;
  final List<OrderItem> items;
  final double subTotal;
  final double total;
  final String paymentIntentId;

  OrderData({
    required this.id,
    required this.buyerEmail,
    required this.orderDate,
    required this.status,
    required this.shippingAddress,
    required this.deliveryMethodName,
    required this.items,
    required this.subTotal,
    required this.total,
    required this.paymentIntentId,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) =>
      _$OrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDataToJson(this);
}

@JsonSerializable()
class ShippingAddress {
  final String fullName;
  final String zipCode;
  final String country;
  final String city;
  final String district;

  ShippingAddress({
    required this.fullName,
    required this.zipCode,
    required this.country,
    required this.city,
    required this.district,
  });

  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressToJson(this);
}

@JsonSerializable()
class OrderItem {
  final int productId;
  final String productName;
  final String pictureUrl;
  final double price;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.productName,
    required this.pictureUrl,
    required this.price,
    required this.quantity,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemToJson(this);
}
