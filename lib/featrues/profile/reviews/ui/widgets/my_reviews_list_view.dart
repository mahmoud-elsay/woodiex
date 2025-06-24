import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/reviews/ui/widgets/my_reviews_list_view_item.dart';
import 'package:woodiex/featrues/profile/reviews/data/models/my_reviews_response_model.dart';

class MyReviewsListView extends StatelessWidget {
  final MyReviewsResponseModel data;

  const MyReviewsListView({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      itemCount: data.data?.length ?? 0,
      separatorBuilder: (context, index) => verticalSpace(10),
      itemBuilder: (context, index) {
        final review = data.data![index];
        return MyReviewsListViewItem(
          name: review.name,
          imageUrl: review.productImageUrl,
          price: review.price,
          rating: review.rate,
          comment: review.comment,
          date: review.dateOfCreation,
        );
      },
    );
  }
}
