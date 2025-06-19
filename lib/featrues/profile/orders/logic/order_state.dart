import 'package:woodiex/core/network/api_error_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_response_model.dart';

sealed class OrderState {
  const OrderState();

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(PostOrderResponseModel data) postOrderSuccess,
    required T Function(ApiErrorModel errorModel) error,
  }) {
    return switch (this) {
      OrderInitial _ => initial(),
      OrderLoading _ => loading(),
      PostOrderSuccess(data: final data) => postOrderSuccess(data),
      OrderError(error: final errorModel) => error(errorModel),
    };
  }
}

class OrderInitial extends OrderState {
  const OrderInitial();
}

class OrderLoading extends OrderState {
  const OrderLoading();
}

class PostOrderSuccess extends OrderState {
  final PostOrderResponseModel data;

  const PostOrderSuccess(this.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostOrderSuccess &&
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
