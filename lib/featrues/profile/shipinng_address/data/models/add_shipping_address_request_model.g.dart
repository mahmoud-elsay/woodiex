// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_shipping_address_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddShippingAddressRequestModel _$AddShippingAddressRequestModelFromJson(
        Map<String, dynamic> json) =>
    AddShippingAddressRequestModel(
      fullName: json['fullName'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
    );

Map<String, dynamic> _$AddShippingAddressRequestModelToJson(
        AddShippingAddressRequestModel instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'city': instance.city,
      'district': instance.district,
    };
