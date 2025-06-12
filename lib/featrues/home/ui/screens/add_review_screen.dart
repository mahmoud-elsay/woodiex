import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/rating_section.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/write_review_part.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/horizontal_divider.dart';
import 'package:woodiex/featrues/home/ui/widgets/add_review_screen_widgets/product_row_for_review.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key});

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
          style: Fonts.nunitoSans18SemiBoldWhite, // White text for contrast
        ),
        backgroundColor: ColorsManager.darkGrey, // Dark grey for a subtle look
        elevation: 2.0, // Slight elevation for depth
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              verticalSpace(35),
              ProductRowForReview(),
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
          backgroundColor: isButtonEnabled
              ? ColorsManager.mainBlack // Bold black when enabled
              : null, // Use default disabled color
          disabledColor: ColorsManager.disableGray, // Light grey when disabled
          borderRadius: 8,
        ),
      ),
    );
  }
}
