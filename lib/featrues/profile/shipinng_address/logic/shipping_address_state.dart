import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/add_shipping_address_response_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';

sealed class ShippingAddressState {
  const ShippingAddressState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(AddShippingAddressResponseModel data)
        addShippingAddressSuccess,
    required T Function(GetShippingAddressResponseModel data)
        getShippingAddressSuccess,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      ShippingAddressInitial _ => initial(),
      ShippingAddressLoading _ => loading(),
      AddShippingAddressSuccess(data: final data) =>
        addShippingAddressSuccess(data),
      GetShippingAddressSuccess(data: final data) =>
        getShippingAddressSuccess(data),
      ShippingAddressError(error: final errorModel) => error(errorModel),
    };
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(AddShippingAddressResponseModel data)? addShippingAddressSuccess,
    T Function(GetShippingAddressResponseModel data)? getShippingAddressSuccess,
    T Function(ApiErrorModel errorModel)? error,
    required T Function() orElse,
  }) {
    return switch (this) {
      ShippingAddressInitial _ => initial?.call() ?? orElse(),
      ShippingAddressLoading _ => loading?.call() ?? orElse(),
      AddShippingAddressSuccess(data: final data) =>
        addShippingAddressSuccess?.call(data) ?? orElse(),
      GetShippingAddressSuccess(data: final data) =>
        getShippingAddressSuccess?.call(data) ?? orElse(),
      ShippingAddressError(error: final errorModel) =>
        error?.call(errorModel) ?? orElse(),
    };
  }
}

class ShippingAddressInitial extends ShippingAddressState {
  const ShippingAddressInitial();
}

class ShippingAddressLoading extends ShippingAddressState {
  const ShippingAddressLoading();
}

class AddShippingAddressSuccess extends ShippingAddressState {
  final AddShippingAddressResponseModel data;

  const AddShippingAddressSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AddShippingAddressSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class GetShippingAddressSuccess extends ShippingAddressState {
  final GetShippingAddressResponseModel data;

  const GetShippingAddressSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetShippingAddressSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class ShippingAddressError extends ShippingAddressState {
  final ApiErrorModel error;

  const ShippingAddressError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShippingAddressError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
