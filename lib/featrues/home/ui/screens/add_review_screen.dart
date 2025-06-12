import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/custom_snakbar.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/core/animations/custom_loading_animation.dart';
import 'package:woodiex/featrues/home/data/models/add_review_request_model.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_states.dart';
import 'package:woodiex/featrues/home/logic/reviews_notifier/reviews_notifier.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/rating_section.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/write_review_part.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/horizontal_divider.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/product_row_for_review.dart';

class AddReviewScreen extends ConsumerStatefulWidget {
  final ProductDetailsData? productDetails;

  const AddReviewScreen({super.key, this.productDetails});

  @override
  ConsumerState<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends ConsumerState<AddReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 0;

  @override
  void initState() {
    super.initState();
    _reviewController.addListener(() {
      setState(() {});
    });
    print(
        'AddReviewScreen - Received: ${widget.productDetails?.name}, ${widget.productDetails?.imageUrl}');
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  void _handleRatingChanged(int rating) {
    setState(() {
      _rating = rating;
    });
    print('Rating changed to: $rating');
  }

  bool get _isFormValid {
    return _reviewController.text.trim().isNotEmpty && _rating > 0;
  }

  Future<void> _submitReview() async {
    if (!_isFormValid) return;

    try {
      final token = await SharedPrefHelper.getUserToken();
      if (token.isEmpty) {
        CustomSnackBar.showError(context, 'Please login to submit a review');
        return;
      }

      final productId = widget.productDetails?.id;
      if (productId == null) {
        CustomSnackBar.showError(context, 'Product information is missing');
        return;
      }

      final reviewRequest = AddReviewRequestModel(
        productId: productId,
        rating: _rating,
        comment: _reviewController.text.trim(),
      );

      await ref
          .read(reviewsNotifierProvider.notifier)
          .addReview('Bearer $token', reviewRequest);
    } catch (e) {
      print('Error submitting review: $e');
      CustomSnackBar.showError(
          context, 'Failed to submit review. Please try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final reviewsState = ref.watch(reviewsNotifierProvider);

    // Listen to state changes
    ref.listen<ReviewsState>(reviewsNotifierProvider, (previous, next) {
      if (next is ReviewsSuccess) {
        CustomSnackBar.showSuccess(context, 'Review submitted successfully!');
        // Clear form after successful submission
        _reviewController.clear();
        setState(() {
          _rating = 0;
        });
        // Optionally navigate back
        Navigator.of(context).pop(true); // Return true to indicate success
      } else if (next is ReviewsError) {
        CustomSnackBar.showError(
            context, next.error.message ?? 'Failed to submit review');
      }
    });

    final isLoading = reviewsState is ReviewsLoading;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Write a review',
          style: Fonts.nunitoSans18SemiBoldWhite,
        ),
        backgroundColor: ColorsManager.darkGrey,
        elevation: 2.0,
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  verticalSpace(35),
                  ProductRowForReview(
                    imageUrl: widget.productDetails?.imageUrl ??
                        'assets/images/prod.png',
                    name: widget.productDetails?.name ?? 'Minimal Stand',
                  ),
                  verticalSpace(20),
                  HorizontalDivider(),
                  verticalSpace(25),
                  WriteReviewPart(controller: _reviewController),
                  verticalSpace(30),
                  RatingSection(
                    onRatingChanged: _handleRatingChanged,
                    initialRating: _rating,
                  ),
                  verticalSpace(30),
                ],
              ),
            ),
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: const Center(
                child: CustomLoadingWidget(),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: AppTextButton(
          onPressed: (_isFormValid && !isLoading) ? _submitReview : null,
          buttonText: isLoading ? 'Submitting...' : 'Submit',
          textStyle: Fonts.nunitoSans16BoldWhite,
          backgroundColor:
              (_isFormValid && !isLoading) ? ColorsManager.mainBlack : null,
          disabledColor: ColorsManager.disableGray,
          borderRadius: 8,
        ),
      ),
    );
  }
}
