import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/shipinng_address/data/models/get_shipping_address_response_model.dart';
import 'package:woodiex/featrues/profile/shipinng_address/ui/widgets/shipping_address_widgets/shpinng_address_list_view_item.dart';

class ShippingAddressListView extends StatelessWidget {
  final List<AddressData>? addresses;

  const ShippingAddressListView({super.key, this.addresses});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: addresses?.length ?? 0,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        return ShpinngAddressListViewItem(address: addresses![index]);
      },
    );
  }
}
