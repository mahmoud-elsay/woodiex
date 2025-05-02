import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/add_shipping_address_response_model.dart';

sealed class ShippingAddressState {
  const ShippingAddressState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(AddShippingAddressResponseModel data)
        addShippingAddressSuccess,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      ShippingAddressInitial _ => initial(),
      ShippingAddressLoading _ => loading(),
      AddShippingAddressSuccess(data: final data) =>
        addShippingAddressSuccess(data),
      ShippingAddressError(error: final errorModel) => error(errorModel),
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
