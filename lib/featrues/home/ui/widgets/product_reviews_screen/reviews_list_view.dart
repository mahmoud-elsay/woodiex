import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/reviews_list_view_item.dart';

class ReviewsListView extends StatelessWidget {
  const ReviewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      itemCount: 7,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        return ReviewsListViewItem();
      },
    );
  }
}
