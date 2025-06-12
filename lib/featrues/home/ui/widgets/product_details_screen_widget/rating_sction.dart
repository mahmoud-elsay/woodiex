import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';

class RatingSection extends StatelessWidget {
  final double rating;
  final int reviews;
  final ProductDetailsData? productDetails;

  const RatingSection({
    super.key,
    required this.rating,
    required this.reviews,
    this.productDetails,
  });

  @override
  Widget build(BuildContext context) {
    print(
        'RatingSection - ProductDetails: ${productDetails?.name}, ${productDetails?.imageUrl}'); // Debug print
    return GestureDetector(
      onTap: () {
        print(
            'Navigating to ProductReviewsScreen with: ${productDetails?.name}, ${productDetails?.imageUrl}'); // Debug print
        context.pushNamed(
          Routes.productReviewsScreen,
          arguments: productDetails,
        );
      },
      child: Row(
        children: [
          SvgPicture.asset('assets/svgs/star.svg'),
          horizontalSpace(10),
          Text(
            rating.toString(),
            style: Fonts.nunitoSans18BoldMainBlack,
          ),
          horizontalSpace(15),
          Text(
            '($reviews reviews)',
            style: Fonts.nunitoSans14RegularSecondaryGrey,
          ),
        ],
      ),
    );
  }
}
