import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductRow extends StatelessWidget {
  final String imageUrl;
  final String name;
  final double averageRating;
  final int reviewsCount;

  const ProductRow({
    super.key,
    required this.imageUrl,
    required this.name,
    this.averageRating = 0.0,
    this.reviewsCount = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          height: 100.h,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.r),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey.shade200,
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey.shade400,
                    size: 40,
                  ),
                );
              },
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        horizontalSpace(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: Fonts.nunitoSans14RegularMainBlack,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(10),
              Row(
                children: [
                  SvgPicture.asset('assets/svgs/star.svg'),
                  horizontalSpace(5),
                  Text(
                    averageRating.toStringAsFixed(1),
                    style: Fonts.nunitoSans24BoldMainBlack,
                  )
                ],
              ),
              verticalSpace(7),
              Text(
                '$reviewsCount ${reviewsCount == 1 ? 'review' : 'reviews'}',
                style: Fonts.nunitoSans18SemiBoldMainBlack,
              )
            ],
          ),
        )
      ],
    );
  }
}
