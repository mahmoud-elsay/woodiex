import 'package:json_annotation/json_annotation.dart';

part 'post_order_request_model.g.dart';

@JsonSerializable()
class PostOrderRequestModel {
  final int cartId;
  final int deliveryMethodId;
  final ShipToAddress shipToAddress;

  PostOrderRequestModel({
    required this.cartId,
    required this.deliveryMethodId,
    required this.shipToAddress,
  });

  factory PostOrderRequestModel.fromJson(Map<String, dynamic> json) =>
      _$PostOrderRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostOrderRequestModelToJson(this);
}

@JsonSerializable()
class ShipToAddress {
  final String fullName;
  final String zipCode;
  final String country;
  final String city;
  final String district;

  ShipToAddress({
    required this.fullName,
    required this.zipCode,
    required this.country,
    required this.city,
    required this.district,
  });

  factory ShipToAddress.fromJson(Map<String, dynamic> json) =>
      _$ShipToAddressFromJson(json);

  Map<String, dynamic> toJson() => _$ShipToAddressToJson(this);
}
