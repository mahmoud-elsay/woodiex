import 'package:json_annotation/json_annotation.dart';

part 'get_shipping_address_response_model.g.dart';

@JsonSerializable()
class GetShippingAddressResponseModel {
  final bool success;
  final String messsage;
  final List<AddressData> data;
  final dynamic errors;
  final int statusCode;

  GetShippingAddressResponseModel({
    required this.success,
    required this.messsage,
    required this.data,
    this.errors,
    required this.statusCode,
  });

  factory GetShippingAddressResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetShippingAddressResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$GetShippingAddressResponseModelToJson(this);
}

@JsonSerializable()
class AddressData {
  final String fullName;
  final String zipCode;
  final String country;
  final String city;
  final String district;

  AddressData({
    required this.fullName,
    required this.zipCode,
    required this.country,
    required this.city,
    required this.district,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) =>
      _$AddressDataFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDataToJson(this);
}
