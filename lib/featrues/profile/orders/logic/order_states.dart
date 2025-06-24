import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/get_order_response_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_response_model.dart';

sealed class OrderState {
  const OrderState();

  T when<T>({
    required T Function() initial,
    required T Function(dynamic data) loading, // Generic data for flexibility
    required T Function(PostOrderResponseModel data) postSuccess,
    required T Function(GetOrderResponseModel data) getSuccess,
    required T Function(ApiErrorModel error) error,
  }) {
    return switch (this) {
      OrderInitial _ => initial(),
      OrderLoading(data: final data) => loading(data),
      OrderPostSuccess(data: final data) => postSuccess(data),
      OrderGetSuccess(data: final data) => getSuccess(data),
      OrderError(error: final err) => error(err),
    };
  }
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  final dynamic data; // Can be PostOrderResponseModel or GetOrderResponseModel

  const OrderLoading(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderLoading &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class OrderPostSuccess extends OrderState {
  final PostOrderResponseModel data;

  const OrderPostSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderPostSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class OrderGetSuccess extends OrderState {
  final GetOrderResponseModel data;

  const OrderGetSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderGetSuccess &&
          runtimeType == other.runtimeType &&
          data == other.data;

  @override
  int get hashCode => data.hashCode;
}

class OrderError extends OrderState {
  final ApiErrorModel error;

  const OrderError(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OrderError &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;
}
