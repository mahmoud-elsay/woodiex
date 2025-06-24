import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_notifier.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_reviews_screen/reviews_list_view_item.dart';


class ReviewsListView extends ConsumerStatefulWidget {
  final int productId;
  
  const ReviewsListView({
    super.key,
    required this.productId,
  });

  @override
  ConsumerState<ReviewsListView> createState() => _ReviewsListViewState();
}

class _ReviewsListViewState extends ConsumerState<ReviewsListView> {
  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    final token = await SharedPrefHelper.getUserToken();
    if (token.isNotEmpty) {
      ref.read(reviewsNotifierProvider.notifier)
          .getReviews('Bearer $token', widget.productId);
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(reviewsNotifierProvider);
    
    return reviewsState.when(
      initial: () => _buildEmptyState('No reviews yet'),
      loading: (addData, getReviewsData) => _buildLoadingState(getReviewsData),
      success: (addData, getReviewsData) => _buildSuccessState(getReviewsData),
      error: (error) => _buildErrorState(error.message ?? 'Failed to load reviews'),
    );
  }

  Widget _buildLoadingState(getReviewsData) {
    if (getReviewsData != null && getReviewsData.data.reviews.isNotEmpty) {
      // Show existing reviews while loading
      return _buildReviewsList(getReviewsData.data.reviews);
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          verticalSpace(16),
          Text(
            'Loading reviews...',
            style: Fonts.nunitoSans14RegularMainBlack,
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(getReviewsData) {
    if (getReviewsData == null || getReviewsData.data.reviews.isEmpty) {
      return _buildEmptyState('No reviews available for this product');
    }
    return _buildReviewsList(getReviewsData.data.reviews);
  }

  Widget _buildReviewsList(reviews) {
    return RefreshIndicator(
      onRefresh: _loadReviews,
      child: ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 15.h),
        itemCount: reviews.length,
        separatorBuilder: (context, index) => verticalSpace(15),
        itemBuilder: (context, index) {
          return ReviewsListViewItem(
            reviewItem: reviews[index],
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.rate_review_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          verticalSpace(16),
          Text(
            message,
            style: Fonts.nunitoSans16RegularMainBlack,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            'Be the first to leave a review!',
            style: Fonts.nunitoSans14RegularMainBlack.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red.shade400,
          ),
          verticalSpace(16),
          Text(
            'Failed to load reviews',
            style: Fonts.nunitoSans16SemiBoldMainBlack,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            error,
            style: Fonts.nunitoSans14RegularMainBlack.copyWith(
              color: Colors.grey.shade600,
            ),
            textAlign: TextAlign.center,
          ),
          verticalSpace(16),
          ElevatedButton(
            onPressed: _loadReviews,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }
}