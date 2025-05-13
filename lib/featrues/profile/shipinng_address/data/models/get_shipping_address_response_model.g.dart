// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_shipping_address_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetShippingAddressResponseModel _$GetShippingAddressResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetShippingAddressResponseModel(
      success: json['success'] as bool,
      messsage: json['messsage'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => AddressData.fromJson(e as Map<String, dynamic>))
          .toList(),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$GetShippingAddressResponseModelToJson(
        GetShippingAddressResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'messsage': instance.messsage,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

AddressData _$AddressDataFromJson(Map<String, dynamic> json) => AddressData(
      fullName: json['fullName'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
    );

Map<String, dynamic> _$AddressDataToJson(AddressData instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'city': instance.city,
      'district': instance.district,
    };
