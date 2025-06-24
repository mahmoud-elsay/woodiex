import 'package:json_annotation/json_annotation.dart';

part 'add_product_response_model.g.dart';

@JsonSerializable()
class AddProductResponseModel {
  final bool success;
  final String messsage;
  final bool data;
  final dynamic errors;
  final int statusCode;

  AddProductResponseModel({
    required this.success,
    required this.messsage,
    required this.data,
    required this.errors,
    required this.statusCode,
  });

  factory AddProductResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AddProductResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductResponseModelToJson(this);
}
