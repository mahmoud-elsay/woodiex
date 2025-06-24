import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';

part 'selected_address_provider.g.dart';

@riverpod
class SelectedAddress extends _$SelectedAddress {
  @override
  AddressData? build() => null;

  void selectAddress(AddressData address) {
    state = address;
  }

  void clearSelection() {
    state = null;
  }
}
