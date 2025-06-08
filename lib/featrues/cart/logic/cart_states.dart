import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/cart/data/models/add_product_response_model.dart';

sealed class AddCartState {
  const AddCartState();

  T when<T>({
    required T Function() initial,
    required T Function(AddProductResponseModel data) loading,
    required T Function(AddProductResponseModel data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      AddCartInitial _ => initial(),
      AddCartLoading(data: final data) => loading(data),
      AddCartSuccess(data: final data) => success(data),
      AddCartError(error: final errorModel) => error(errorModel),
    };
  }
}

class AddCartInitial extends AddCartState {
  const AddCartInitial();
}

class AddCartLoading extends AddCartState {
  final AddProductResponseModel data;

  const AddCartLoading(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddCartLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class AddCartSuccess extends AddCartState {
  final AddProductResponseModel data;

  const AddCartSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddCartSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class AddCartError extends AddCartState {
  final ApiErrorModel error;

  const AddCartError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddCartError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
