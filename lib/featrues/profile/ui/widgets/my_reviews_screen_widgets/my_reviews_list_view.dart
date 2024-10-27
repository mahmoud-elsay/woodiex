import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/my_reviews_screen_widgets/my_reviews_list_view_item.dart';
import 'package:woodiex/featrues/profile/ui/widgets/shipping_address_widgets/shpinng_address_list_view_item.dart';

// Import the widget you created

class MyReviewsListView extends StatelessWidget {
  const MyReviewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: 4, // Number of items
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        return const MyReviewsListViewItem();
      },
    );
  }
}
