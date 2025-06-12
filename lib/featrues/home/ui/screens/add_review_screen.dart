import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/rating_section.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/write_review_part.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/horizontal_divider.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/product_row_for_review.dart';

class AddReviewScreen extends StatefulWidget {
  final ProductDetailsData? productDetails;

  const AddReviewScreen({super.key, this.productDetails});

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _reviewController.addListener(() {
      setState(() {});
    });
    print(
        'AddReviewScreen - Received: ${widget.productDetails?.name}, ${widget.productDetails?.imageUrl}'); // Debug print
  }

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isButtonEnabled = _reviewController.text.trim().isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Write a review',
          style: Fonts.nunitoSans18SemiBoldWhite,
        ),
        backgroundColor: ColorsManager.darkGrey,
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(35),
              ProductRowForReview(
                imageUrl: widget.productDetails?.imageUrl ??
                    'assets/images/prod.png', // Fallback if null
                name: widget.productDetails?.name ??
                    'Minimal Stand', // Fallback if null
              ),
              verticalSpace(20),
              HorizontalDivider(),
              verticalSpace(25),
              WriteReviewPart(controller: _reviewController),
              verticalSpace(30),
              RatingSection(onRatingChanged: (rating) {}),
              verticalSpace(30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(20.w),
        child: AppTextButton(
          onPressed: isButtonEnabled ? () {} : null,
          buttonText: 'Submit',
          textStyle: Fonts.nunitoSans16BoldWhite,
          backgroundColor: isButtonEnabled ? ColorsManager.mainBlack : null,
          disabledColor: ColorsManager.disableGray,
          borderRadius: 8,
        ),
      ),
    );
  }
}
