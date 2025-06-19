// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_order_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostOrderResponseModel _$PostOrderResponseModelFromJson(
        Map<String, dynamic> json) =>
    PostOrderResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : OrderData.fromJson(json['data'] as Map<String, dynamic>),
      errors: json['errors'],
      statusCode: (json['statusCode'] as num).toInt(),
    );

Map<String, dynamic> _$PostOrderResponseModelToJson(
        PostOrderResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'errors': instance.errors,
      'statusCode': instance.statusCode,
    };

OrderData _$OrderDataFromJson(Map<String, dynamic> json) => OrderData(
      id: (json['id'] as num).toInt(),
      buyerEmail: json['buyerEmail'] as String,
      orderDate: json['orderDate'] as String,
      status: json['status'] as String,
      shippingAddress: ShippingAddress.fromJson(
          json['shippingAddress'] as Map<String, dynamic>),
      deliveryMethodName: json['deliveryMethodName'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      subTotal: (json['subTotal'] as num).toDouble(),
      total: (json['total'] as num).toDouble(),
      paymentIntentId: json['paymentIntentId'] as String,
    );

Map<String, dynamic> _$OrderDataToJson(OrderData instance) => <String, dynamic>{
      'id': instance.id,
      'buyerEmail': instance.buyerEmail,
      'orderDate': instance.orderDate,
      'status': instance.status,
      'shippingAddress': instance.shippingAddress,
      'deliveryMethodName': instance.deliveryMethodName,
      'items': instance.items,
      'subTotal': instance.subTotal,
      'total': instance.total,
      'paymentIntentId': instance.paymentIntentId,
    };

ShippingAddress _$ShippingAddressFromJson(Map<String, dynamic> json) =>
    ShippingAddress(
      fullName: json['fullName'] as String,
      zipCode: json['zipCode'] as String,
      country: json['country'] as String,
      city: json['city'] as String,
      district: json['district'] as String,
    );

Map<String, dynamic> _$ShippingAddressToJson(ShippingAddress instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'zipCode': instance.zipCode,
      'country': instance.country,
      'city': instance.city,
      'district': instance.district,
    };

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) => OrderItem(
      productId: (json['productId'] as num).toInt(),
      productName: json['productName'] as String,
      pictureUrl: json['pictureUrl'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$OrderItemToJson(OrderItem instance) => <String, dynamic>{
      'productId': instance.productId,
      'productName': instance.productName,
      'pictureUrl': instance.pictureUrl,
      'price': instance.price,
      'quantity': instance.quantity,
    };
