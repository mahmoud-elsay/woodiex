import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';

sealed class ProductDetailsState {
  const ProductDetailsState();

  T when<T>({
    required T Function() initial,
    required T Function(ProductDetailsData data) loading,
    required T Function(ProductDetailsData data) success,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      ProductDetailsInitial _ => initial(),
      ProductDetailsLoading(data: final data) => loading(data),
      ProductDetailsSuccess(data: final data) => success(data),
      ProductDetailsError(error: final errorModel) => error(errorModel),
    };
  }
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
}

class ProductDetailsLoading extends ProductDetailsState {
  final ProductDetailsData data;

  const ProductDetailsLoading(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class ProductDetailsSuccess extends ProductDetailsState {
  final ProductDetailsData data;

  const ProductDetailsSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class ProductDetailsError extends ProductDetailsState {
  final ApiErrorModel error;

  const ProductDetailsError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductDetailsError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
