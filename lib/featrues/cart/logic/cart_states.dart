import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/cart/data/models/get_cart_response_model.dart';
import 'package:woodiex/featrues/cart/data/models/add_product_response_model.dart';
import 'package:woodiex/featrues/cart/data/models/delete_cart_item_response_model.dart';

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

sealed class GetCartState {
  const GetCartState();

  T when<T>({
    required T Function() initial,
    required T Function(GetCartResponseModel data) loading,
    required T Function(GetCartResponseModel data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      GetCartInitial _ => initial(),
      GetCartLoading(data: final data) => loading(data),
      GetCartSuccess(data: final data) => success(data),
      GetCartError(error: final errorModel) => error(errorModel),
    };
  }
}

class GetCartInitial extends GetCartState {
  const GetCartInitial();
}

class GetCartLoading extends GetCartState {
  final GetCartResponseModel data;

  const GetCartLoading(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCartLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class GetCartSuccess extends GetCartState {
  final GetCartResponseModel data;

  const GetCartSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCartSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class GetCartError extends GetCartState {
  final ApiErrorModel error;

  const GetCartError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetCartError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}

sealed class DeleteCartState {
  const DeleteCartState();

  T when<T>({
    required T Function() initial,
    required T Function(DeleteCartItemResponseModel data) loading,
    required T Function(DeleteCartItemResponseModel data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      DeleteCartInitial _ => initial(),
      DeleteCartLoading(data: final data) => loading(data),
      DeleteCartSuccess(data: final data) => success(data),
      DeleteCartError(error: final errorModel) => error(errorModel),
    };
  }
}

class DeleteCartInitial extends DeleteCartState {
  const DeleteCartInitial();
}

class DeleteCartLoading extends DeleteCartState {
  final DeleteCartItemResponseModel data;

  const DeleteCartLoading(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteCartLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class DeleteCartSuccess extends DeleteCartState {
  final DeleteCartItemResponseModel data;

  const DeleteCartSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteCartSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class DeleteCartError extends DeleteCartState {
  final ApiErrorModel error;

  const DeleteCartError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeleteCartError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}