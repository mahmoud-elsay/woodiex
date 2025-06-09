import 'package:json_annotation/json_annotation.dart';

part 'delete_cart_item_response_model.g.dart';

@JsonSerializable()
class DeleteCartItemResponseModel {
  final bool success;
  final String messsage;
  final bool data;
  final dynamic errors;
  final int statusCode;

  DeleteCartItemResponseModel({
    required this.success,
    required this.messsage,
    required this.data,
    required this.errors,
    required this.statusCode,
  });

  factory DeleteCartItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteCartItemResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DeleteCartItemResponseModelToJson(this);
}
