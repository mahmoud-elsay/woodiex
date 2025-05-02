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
    state = const ShippingAddressLoading();

    final requestModel = AddShippingAddressRequestModel(
      fullName: fullName,
      zipCode: zipCode,
      country: country,
      city: city,
      district: district,
    );

    try {
      final token = await SharedPrefHelper.getUserToken();
      if (token.isEmpty) {
        state = ShippingAddressError(
            ApiErrorModel(message: 'User not logged in', statusCode: 401));
        return;
      }

      final response = await ref
          .read(shippingAddressRepoProvider)
          .addShippingAddress(requestModel, 'Bearer $token');
      response.when(
        success: (addShippingAddressResponse) {
          state = AddShippingAddressSuccess(addShippingAddressResponse);
        },
        failure: (error) => state = ShippingAddressError(error),
      );
    } catch (e) {
      state = ShippingAddressError(ApiErrorModel(
        message: 'Unexpected error: $e',
        statusCode: 0,
      ));
    }
  }
}
