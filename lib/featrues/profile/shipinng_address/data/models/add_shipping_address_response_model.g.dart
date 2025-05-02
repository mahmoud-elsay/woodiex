// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_shipping_address_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddShippingAddressResponseModel _$AddShippingAddressResponseModelFromJson(
        Map<String, dynamic> json) =>
    AddShippingAddressResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: json['data'] == null
          ? null
          : ShippingAddressData.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$AddShippingAddressResponseModelToJson(
        AddShippingAddressResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

ShippingAddressData _$ShippingAddressDataFromJson(Map<String, dynamic> json) =>
    ShippingAddressData(
      fullName: json['fullName'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
    );

Map<String, dynamic> _$ShippingAddressDataToJson(
        ShippingAddressData instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'city': instance.city,
      'district': instance.district,
    };
