import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/reviews/ui/widgets/rating_widget.dart';

class MyReviewsListViewItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final double price;
  final int rating;
  final String comment;
  final String date;

  const MyReviewsListViewItem({
    super.key,
    required this.name,
    required this.imageUrl,
    required this.price,
    required this.rating,
    required this.comment,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335.w,
      height: 242.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: 75.w,
                  height: 75.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) => Image.asset(
                          'assets/images/prod.png'), // Fallback image
                    ),
                  ),
                ),
                horizontalSpace(25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: Fonts.nunitoSans16BoldSecondaryGrey,
                    ),
                    verticalSpace(10),
                    Text(
                      '\$${price.toStringAsFixed(2)}',
                      style: Fonts.nunitoSans16BoldMainBlack,
                    ),
                  ],
                ),
              ],
            ),
            verticalSpace(15),
            Row(
              children: [
                RatingWidget(rating: rating),
                const Spacer(),
                Text(
                  date.split('T')[0], // Extract date part only
                  style: Fonts.nunitoSans14RegularSecondaryGrey,
                ),
              ],
            ),
            verticalSpace(15),
            Expanded(
              child: Text(
                comment,
                style: Fonts.nunitoSans14RegularMainBlack,
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
