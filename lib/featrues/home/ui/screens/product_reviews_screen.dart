import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/product_row.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/reviews_list_view.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/reviews_list_view_item.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            BackableTopBar(screenTitle: 'Rating & Review'),
            verticalSpace(40),
            ProductRow(),
            verticalSpace(20),
            Divider(
              height: 1.h,
              color: Colors.grey.shade300,
            ),
            verticalSpace(35),
            ReviewsListView()
          ],
        ),
      )),
    );
  }
}
