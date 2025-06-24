import 'package:json_annotation/json_annotation.dart';

part 'add_shipping_address_request_model.g.dart';

@JsonSerializable()
class AddShippingAddressRequestModel {
  final String fullName;
  final String zipCode;
  final String country;
  final String city;
  final String district;

  AddShippingAddressRequestModel({
    required this.fullName,
    required this.zipCode,
    required this.country,
    required this.city,
    required this.district,
  });

  factory AddShippingAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddShippingAddressRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddShippingAddressRequestModelToJson(this);
}
