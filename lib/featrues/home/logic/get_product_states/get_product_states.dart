import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';

sealed class GetProductState {
  const GetProductState();

  T when<T>({
    required T Function() initial,
    required T Function(List<ProductData> products) loading,
    required T Function(List<ProductData> products) success,
    required T Function(List<ProductData> products, bool hasReachedMax)
        loadMoreSuccess,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      GetProductInitial _ => initial(),
      GetProductLoading(products: final products) => loading(products),
      GetProductSuccess(products: final products) => success(products),
      GetProductLoadMoreSuccess(
        products: final products,
        hasReachedMax: final hasReachedMax
      ) =>
        loadMoreSuccess(products, hasReachedMax),
      GetProductError(error: final errorModel) => error(errorModel),
    };
  }
}

class GetProductInitial extends GetProductState {
  const GetProductInitial();
}

class GetProductLoading extends GetProductState {
  final List<ProductData> products;

  const GetProductLoading(this.products);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetProductLoading &&
          runtimeType == other.runtimeType &&
          products == other.products;

  @override
  int get hashCode => products.hashCode;
}

class GetProductSuccess extends GetProductState {
  final List<ProductData> products;

  const GetProductSuccess(this.products);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetProductSuccess &&
          runtimeType == other.runtimeType &&
          products == other.products;

  @override
  int get hashCode => products.hashCode;
}

class GetProductLoadMoreSuccess extends GetProductState {
  final List<ProductData> products;
  final bool hasReachedMax;

  const GetProductLoadMoreSuccess(this.products, this.hasReachedMax);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetProductLoadMoreSuccess &&
          runtimeType == other.runtimeType &&
          products == other.products &&
          hasReachedMax == other.hasReachedMax;

  @override
  int get hashCode => Object.hash(products, hasReachedMax);
}

class GetProductError extends GetProductState {
  final ApiErrorModel error;

  const GetProductError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetProductError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
