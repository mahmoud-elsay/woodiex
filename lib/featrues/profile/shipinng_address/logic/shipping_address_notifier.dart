import 'package:woodiex/core/di/di.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/shipinng_address/logic/shipping_address_state.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/add_shipping_address_request_model.dart';

part 'shipping_address_notifier.g.dart';

@riverpod
class ShippingAddressNotifier extends _$ShippingAddressNotifier {
  @override
  ShippingAddressState build() => const ShippingAddressInitial();

  Future<void> addShippingAddress({
    required String fullName,
    required String zipCode,
    required String country,
    required String city,
    required String district,
  }) async {
    print('Adding shipping address...');
    state = const ShippingAddressLoading();

    try {
      final token = await SharedPrefHelper.getUserToken();
      print('Token: $token');
      if (token.isEmpty) {
        print('Token is empty, user not logged in');
        state = ShippingAddressError(
            ApiErrorModel(message: 'User not logged in', statusCode: 401));
        return;
      }

      final requestModel = AddShippingAddressRequestModel(
        fullName: fullName,
        zipCode: zipCode,
        country: country,
        city: city,
        district: district,
      );

      print('Sending addShippingAddress request...');
      final response = await ref
          .read(shippingAddressRepoProvider)
          .addShippingAddress(requestModel, 'Bearer $token');
      print('addShippingAddress response: $response');
      response.when(
        success: (addShippingAddressResponse) {
          print(
              'addShippingAddress success: ${addShippingAddressResponse.data}');
          state = AddShippingAddressSuccess(addShippingAddressResponse);
        },
        failure: (error) {
          print('addShippingAddress error: ${error.message}');
          state = ShippingAddressError(error);
        },
      );
    } catch (e) {
      print('addShippingAddress unexpected error: $e');
      state = ShippingAddressError(ApiErrorModel(
        message: 'Unexpected error: $e',
        statusCode: 0,
      ));
    }
  }

  Future<void> getShippingAddress() async {
    print('Fetching shipping addresses...');
    state = const ShippingAddressLoading();

    try {
      final token = await SharedPrefHelper.getUserToken();
      print('Token: $token');
      if (token.isEmpty) {
        print('Token is empty, user not logged in');
        state = ShippingAddressError(
            ApiErrorModel(message: 'User not logged in', statusCode: 401));
        return;
      }

      print('Sending getShippingAddress request...');
      final response = await ref
          .read(shippingAddressRepoProvider)
          .getShippingAddress('Bearer $token');
      print('getShippingAddress response: $response');
      response.when(
        success: (getShippingAddressResponse) {
          print(
              'getShippingAddress success: ${getShippingAddressResponse.data.length} addresses');
          state = GetShippingAddressSuccess(getShippingAddressResponse);
        },
        failure: (error) {
          print('getShippingAddress error: ${error.message}');
          state = ShippingAddressError(error);
        },
      );
    } catch (e) {
      print('getShippingAddress unexpected error: $e');
      state = ShippingAddressError(ApiErrorModel(
        message: 'Unexpected error: $e',
        statusCode: 0,
      ));
    }
  }
}
