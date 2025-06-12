import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/product_row.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/reviews_list_view.dart';

class ProductReviewsScreen extends StatefulWidget {
  final ProductDetailsData? productDetails;

  const ProductReviewsScreen({super.key, this.productDetails});

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  @override
  Widget build(BuildContext context) {
    print(
        'ProductReviewsScreen - Received: ${widget.productDetails?.name}, ${widget.productDetails?.imageUrl}'); // Debug print
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              BackableTopBar(screenTitle: 'Rating & Review'),
              verticalSpace(40),
              ProductRow(
                imageUrl: widget.productDetails?.imageUrl ??
                    'assets/images/prod.png', // Fallback if null
                name: widget.productDetails?.name ??
                    'Minimal Stand', // Fallback if null
              ),
              verticalSpace(20),
              Divider(
                height: 1.h,
                color: Colors.grey.shade300,
              ),
              verticalSpace(35),
              Expanded(
                child: ReviewsListView(),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              'Navigating to AddReviewScreen with: ${widget.productDetails?.name}, ${widget.productDetails?.imageUrl}'); // Debug print
          context.pushNamed(
            Routes.addReviewScreen,
            arguments: widget.productDetails,
          );
        },
        backgroundColor: ColorsManager.mainBlack,
        elevation: 6.0,
        child: Icon(
          Icons.add,
          color: ColorsManager.white,
          size: 28.sp,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
