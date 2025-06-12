import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_states.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_notifier.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/product_row.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/reviews_list_view.dart';

class ProductReviewsScreen extends ConsumerStatefulWidget {
  final ProductDetailsData? productDetails;

  const ProductReviewsScreen({super.key, this.productDetails});

  @override
  ConsumerState<ProductReviewsScreen> createState() =>
      _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends ConsumerState<ProductReviewsScreen> {
  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    if (widget.productDetails?.id != null) {
      final token = await SharedPrefHelper.getUserToken();
      if (token.isNotEmpty) {
        ref
            .read(reviewsNotifierProvider.notifier)
            .getReviews('Bearer $token', widget.productDetails!.id);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(reviewsNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              BackableTopBar(screenTitle: 'Rating & Review'),
              verticalSpace(40),
              _buildProductRow(reviewsState),
              verticalSpace(20),
              Divider(
                height: 1.h,
                color: Colors.grey.shade300,
              ),
              verticalSpace(35),
              Expanded(
                child: widget.productDetails?.id != null
                    ? ReviewsListView(productId: widget.productDetails!.id)
                    : Center(
                        child: Text(
                          'Product details not available',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(
              'Navigating to AddReviewScreen with: ${widget.productDetails?.name}, ${widget.productDetails?.imageUrl}');
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

  Widget _buildProductRow(ReviewsState reviewsState) {
    return reviewsState.when(
      initial: () => ProductRow(
        imageUrl: widget.productDetails?.imageUrl ?? 'assets/images/prod.png',
        name: widget.productDetails?.name ?? 'Product',
        averageRating: 0.0,
        reviewsCount: 0,
      ),
      loading: (addData, getReviewsData) => ProductRow(
        imageUrl: getReviewsData?.data.productImageUrl ??
            widget.productDetails?.imageUrl ??
            'assets/images/prod.png',
        name: getReviewsData?.data.productName ??
            widget.productDetails?.name ??
            'Product',
        averageRating: getReviewsData?.data.averageRate ?? 0.0,
        reviewsCount: getReviewsData?.data.reviewsCount ?? 0,
      ),
      success: (addData, getReviewsData) => ProductRow(
        imageUrl: getReviewsData?.data.productImageUrl ??
            widget.productDetails?.imageUrl ??
            'assets/images/prod.png',
        name: getReviewsData?.data.productName ??
            widget.productDetails?.name ??
            'Product',
        averageRating: getReviewsData?.data.averageRate ?? 0.0,
        reviewsCount: getReviewsData?.data.reviewsCount ?? 0,
      ),
      error: (error) => ProductRow(
        imageUrl: widget.productDetails?.imageUrl ?? 'assets/images/prod.png',
        name: widget.productDetails?.name ?? 'Product',
        averageRating: 0.0,
        reviewsCount: 0,
      ),
    );
  }
}
