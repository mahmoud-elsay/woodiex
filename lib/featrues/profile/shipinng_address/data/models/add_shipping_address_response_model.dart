import 'package:json_annotation/json_annotation.dart';

part 'add_shipping_address_response_model.g.dart';

@JsonSerializable()
class AddShippingAddressResponseModel {
  final bool success;
  final String messsage;
  final ShippingAddressData? data;
  final dynamic errors;
  final int statusCode;

  AddShippingAddressResponseModel({
    required this.success,
    required this.messsage,
    this.data,
    this.errors,
    required this.statusCode,
  });

  factory AddShippingAddressResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddShippingAddressResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$AddShippingAddressResponseModelToJson(this);
}

@JsonSerializable()
class ShippingAddressData {
  final String fullName;
  final String zipCode;
  final String country;
  final String city;
  final String district;

  ShippingAddressData({
    required this.fullName,
    required this.zipCode,
    required this.country,
    required this.city,
    required this.district,
  });

  factory ShippingAddressData.fromJson(Map<String, dynamic> json) =>
      _$ShippingAddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$ShippingAddressDataToJson(this);
}
