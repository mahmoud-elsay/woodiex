import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/orders/logic/order_state.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_request_model.dart';
import 'package:woodiex/featrues/profile/orders/data/models/post_order_response_model.dart';

part 'order_notifier.g.dart';

@riverpod
class OrderNotifier extends _$OrderNotifier {
  static const String _cachedCartIdKey = 'cachedCartId';
  static const String _cachedDeliveryMethodIdKey = 'cachedDeliveryMethodId';
  static const String _cachedShippingAddressKey = 'cachedShippingAddress';

  @override
  OrderState build() => const OrderInitial();

  Future<void> postOrder({
    int? cartId,
    int? deliveryMethodId,
    String? fullName,
    String? zipCode,
    String? country,
    String? city,
    String? district,
  }) async {
    print('Creating order...');
    state = const OrderLoading();

    try {
      final token = await SharedPrefHelper.getUserToken();
      print('Token: $token');
      if (token.isEmpty) {
        print('Token is empty, user not logged in');
        state = OrderError(
            ApiErrorModel(message: 'User not logged in', statusCode: 401));
        return;
      }

      // Get cached data or use provided values
      final finalCartId = cartId ?? await getCachedCartId();
      final finalDeliveryMethodId =
          deliveryMethodId ?? await getCachedDeliveryMethodId();

      // For shipping address, try to get from cache if not provided
      final shipToAddress = await _buildShipToAddress(
        fullName: fullName,
        zipCode: zipCode,
        country: country,
        city: city,
        district: district,
      );

      if (finalCartId == 0) {
        print('Cart ID is required');
        state = OrderError(
            ApiErrorModel(message: 'Cart ID is required', statusCode: 400));
        return;
      }

      if (finalDeliveryMethodId == 0) {
        print('Delivery method ID is required');
        state = OrderError(ApiErrorModel(
            message: 'Delivery method ID is required', statusCode: 400));
        return;
      }

      final requestModel = PostOrderRequestModel(
        cartId: finalCartId,
        deliveryMethodId: finalDeliveryMethodId,
        shipToAddress: shipToAddress,
      );

      print('Sending postOrder request...');
      print(
          'Request model: cartId=$finalCartId, deliveryMethodId=$finalDeliveryMethodId');
      print(
          'Shipping address: ${shipToAddress.fullName}, ${shipToAddress.city}');

      final response = await ref
          .read(orderRepoProvider)
          .postOrder('Bearer $token', requestModel);
      print('postOrder response: $response');

      response.when(
        success: (postOrderResponse) {
          print('postOrder success: Order ID ${postOrderResponse.data?.id}');
          state = PostOrderSuccess(postOrderResponse);

          // Cache the order data for future reference
          _cacheOrderData(postOrderResponse);
        },
        failure: (error) {
          print('postOrder error: ${error.message}');
          state = OrderError(error);
        },
      );
    } catch (e) {
      print('postOrder unexpected error: $e');
      state = OrderError(ApiErrorModel(
        message: 'Unexpected error: $e',
        statusCode: 0,
      ));
    }
  }

  Future<ShipToAddress> _buildShipToAddress({
    String? fullName,
    String? zipCode,
    String? country,
    String? city,
    String? district,
  }) async {
    // If all parameters are provided, use them
    if (fullName != null &&
        zipCode != null &&
        country != null &&
        city != null &&
        district != null) {
      return ShipToAddress(
        fullName: fullName,
        zipCode: zipCode,
        country: country,
        city: city,
        district: district,
      );
    }

    // Try to get from cached shipping address
    final cachedAddress = await getCachedShippingAddress();
    if (cachedAddress != null) {
      return ShipToAddress(
        fullName: fullName ?? cachedAddress['fullName'] ?? '',
        zipCode: zipCode ?? cachedAddress['zipCode'] ?? '',
        country: country ?? cachedAddress['country'] ?? '',
        city: city ?? cachedAddress['city'] ?? '',
        district: district ?? cachedAddress['district'] ?? '',
      );
    }

    // Fallback to provided values or empty strings
    return ShipToAddress(
      fullName: fullName ?? '',
      zipCode: zipCode ?? '',
      country: country ?? '',
      city: city ?? '',
      district: district ?? '',
    );
  }

  // Cache management methods
  Future<void> cacheCartId(int cartId) async {
    await SharedPrefHelper.setData(_cachedCartIdKey, cartId);
    print('Cached cart ID: $cartId');
  }

  Future<int> getCachedCartId() async {
    final cartId = await SharedPrefHelper.getInt(_cachedCartIdKey);
    print('Retrieved cached cart ID: $cartId');
    return cartId;
  }

  Future<void> cacheDeliveryMethodId(int deliveryMethodId) async {
    await SharedPrefHelper.setData(
        _cachedDeliveryMethodIdKey, deliveryMethodId);
    print('Cached delivery method ID: $deliveryMethodId');
  }

  Future<int> getCachedDeliveryMethodId() async {
    final deliveryMethodId =
        await SharedPrefHelper.getInt(_cachedDeliveryMethodIdKey);
    print('Retrieved cached delivery method ID: $deliveryMethodId');
    return deliveryMethodId;
  }

  Future<void> cacheShippingAddress({
    required String fullName,
    required String zipCode,
    required String country,
    required String city,
    required String district,
  }) async {
    final addressJson =
        '{"fullName":"$fullName","zipCode":"$zipCode","country":"$country","city":"$city","district":"$district"}';
    await SharedPrefHelper.setData(_cachedShippingAddressKey, addressJson);
    print('Cached shipping address: $addressJson');
  }

  Future<Map<String, String>?> getCachedShippingAddress() async {
    final addressJson =
        await SharedPrefHelper.getString(_cachedShippingAddressKey);
    if (addressJson.isEmpty) {
      print('No cached shipping address found');
      return null;
    }

    try {
      // Simple JSON parsing for cached address
      final parts = addressJson
          .replaceAll('{', '')
          .replaceAll('}', '')
          .replaceAll('"', '')
          .split(',');
      final Map<String, String> address = {};

      for (final part in parts) {
        final keyValue = part.split(':');
        if (keyValue.length == 2) {
          address[keyValue[0]] = keyValue[1];
        }
      }

      print('Retrieved cached shipping address: $address');
      return address;
    } catch (e) {
      print('Error parsing cached shipping address: $e');
      return null;
    }
  }

  Future<void> _cacheOrderData(PostOrderResponseModel response) async {
    if (response.data != null) {
      // Cache useful order information
      await SharedPrefHelper.setData('lastOrderId', response.data!.id);
      await SharedPrefHelper.setData('lastOrderStatus', response.data!.status);
      await SharedPrefHelper.setData('lastOrderTotal', response.data!.total);
      print(
          'Cached order data: ID=${response.data!.id}, Status=${response.data!.status}');
    }
  }

  // Method to clear all cached order-related data
  Future<void> clearOrderCache() async {
    await SharedPrefHelper.removeData(_cachedCartIdKey);
    await SharedPrefHelper.removeData(_cachedDeliveryMethodIdKey);
    await SharedPrefHelper.removeData(_cachedShippingAddressKey);
    await SharedPrefHelper.removeData('lastOrderId');
    await SharedPrefHelper.removeData('lastOrderStatus');
    await SharedPrefHelper.removeData('lastOrderTotal');
    print('Cleared all order cache');
  }

  // Convenience method to create order with cart data
  Future<void> postOrderFromCart({
    required int cartId,
    required int deliveryMethodId,
    required String fullName,
    required String zipCode,
    required String country,
    required String city,
    required String district,
  }) async {
    // Cache the data first
    await cacheCartId(cartId);
    await cacheDeliveryMethodId(deliveryMethodId);
    await cacheShippingAddress(
      fullName: fullName,
      zipCode: zipCode,
      country: country,
      city: city,
      district: district,
    );

    // Then create the order
    await postOrder(
      cartId: cartId,
      deliveryMethodId: deliveryMethodId,
      fullName: fullName,
      zipCode: zipCode,
      country: country,
      city: city,
      district: district,
    );
  }
}
