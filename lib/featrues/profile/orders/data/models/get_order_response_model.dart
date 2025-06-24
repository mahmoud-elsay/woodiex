import 'package:json_annotation/json_annotation.dart';

part 'get_order_response_model.g.dart';

@JsonSerializable(explicitToJson: true)
class GetOrderResponseModel {
  final bool success;
  final String messsage;
  final List<Order>? data;
  final dynamic errors;
  final int statusCode;

  GetOrderResponseModel({
    required this.success,
    required this.messsage,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory GetOrderResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetOrderResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetOrderResponseModelToJson(this);
}

@JsonSerializable()
class Order {
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

  Order({
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

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);
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
