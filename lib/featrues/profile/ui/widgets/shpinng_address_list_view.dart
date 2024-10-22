import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/shpinng_address_list_view_item.dart';
 // Import the widget you created

class ShippingAddressListView extends StatelessWidget {
  const ShippingAddressListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 3, // Number of items
      separatorBuilder: (context, index) => verticalSpace(10), 
      itemBuilder: (context, index) {
        return const ShpinngAddressListViewItem();
      },
    );
  }
}
