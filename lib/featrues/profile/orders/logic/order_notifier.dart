import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/orders/logic/order_states.dart';
import 'package:woodiex/featrues/profile/orders/data/models/get_order_response_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_response_model.dart';

part 'order_notifier.g.dart';

@riverpod
class OrderNotifier extends _$OrderNotifier {
  PostOrderResponseModel? _orderResponse;
  GetOrderResponseModel? _getOrderResponse;

  @override
  OrderState build() => const OrderInitial();

  Future<void> postOrder() async {
    print('Posting order');
    state = OrderLoading(_orderResponse ??
        PostOrderResponseModel(
          success: false,
          messsage: '',
          data: null,
          errors: null,
          statusCode: 0,
        ));

    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved: $token');
    if (token.isEmpty) {
      print('Token is empty, setting error state');
      state = OrderError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref.read(orderRepoProvider).postOrder('Bearer $token');
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, order posted');
        _orderResponse = response;
        state = OrderPostSuccess(_orderResponse!);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = OrderError(error);
      },
    );
  }

  Future<void> getOrders() async {
    print('Fetching orders');
    state = OrderLoading(_getOrderResponse ??
        GetOrderResponseModel(
          success: false,
          messsage: '',
          data: null,
          errors: null,
          statusCode: 0,
        ));

    final token = await SharedPrefHelper.getUserToken();
    print('Token retrieved: $token');
    if (token.isEmpty) {
      print('Token is empty, setting error state');
      state = OrderError(
          ApiErrorModel(message: 'User not logged in', statusCode: 401));
      return;
    }

    final result = await ref.read(orderRepoProvider).getOrders('Bearer $token');
    print('API response: $result');

    result.when(
      success: (response) {
        print('Success, orders retrieved - count: ${response.data?.length}');
        _getOrderResponse = response;
        state = OrderGetSuccess(_getOrderResponse!);
      },
      failure: (error) {
        print('Failure, error: ${error.message}');
        state = OrderError(error);
      },
    );
  }

  Future<void> clearOrderState() async {
    print('Clearing order state');
    _orderResponse = null;
    _getOrderResponse = null;
    state = const OrderInitial();
  }
}
