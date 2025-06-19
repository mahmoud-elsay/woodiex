// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_order_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostOrderRequestModel _$PostOrderRequestModelFromJson(
        Map<String, dynamic> json) =>
    PostOrderRequestModel(
      cartId: (json['cartId'] as num).toInt(),
      deliveryMethodId: (json['deliveryMethodId'] as num).toInt(),
      shipToAddress:
          ShipToAddress.fromJson(json['shipToAddress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostOrderRequestModelToJson(
        PostOrderRequestModel instance) =>
    <String, dynamic>{
      'cartId': instance.cartId,
      'deliveryMethodId': instance.deliveryMethodId,
      'shipToAddress': instance.shipToAddress,
    };

ShipToAddress _$ShipToAddressFromJson(Map<String, dynamic> json) =>
    ShipToAddress(
      fullName: json['fullName'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
    );

Map<String, dynamic> _$ShipToAddressToJson(ShipToAddress instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'city': instance.city,
      'district': instance.district,
    };
