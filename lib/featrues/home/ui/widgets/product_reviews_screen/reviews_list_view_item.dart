import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/get_reviews_response_model.dart';

class ReviewsListViewItem extends StatefulWidget {
  final ReviewItem reviewItem;

  const ReviewsListViewItem({
    super.key,
    required this.reviewItem,
  });

  @override
  _ReviewsListViewItemState createState() => _ReviewsListViewItemState();
}

class _ReviewsListViewItemState extends State<ReviewsListViewItem> {
  bool _isExpanded = false;

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final comment = widget.reviewItem.comment;
    final shouldShowSeeMore = comment.length > 120;
    final displayText = shouldShowSeeMore && !_isExpanded
        ? '${comment.substring(0, 120)}...'
        : comment;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 335.w,
          padding: EdgeInsets.only(
            top: 40.h,
            left: 16,
            right: 16,
            bottom: 16,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                verticalSpace(16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.reviewItem.userName,
                        style: Fonts.nunitoSans14SemiBoldMainBlack,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      _formatDate(widget.reviewItem.createdAt),
                      style: Fonts.nunitoSans12RegularMainBlack,
                    ),
                  ],
                ),
                verticalSpace(10),
                Row(
                  children: List.generate(5, (index) {
                    return SvgPicture.asset(
                      'assets/svgs/star.svg',
                      width: 20.0,
                      height: 20.0,
                      colorFilter: ColorFilter.mode(
                        index < widget.reviewItem.rating
                            ? ColorsManager.secondaryGold
                            : Colors.grey.shade300,
                        BlendMode.srcIn,
                      ),
                    );
                  }),
                ),
                verticalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayText,
                      style: Fonts.nunitoSans14RegularMainBlack,
                    ),
                    if (shouldShowSeeMore) ...[
                      verticalSpace(5),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Text(
                          _isExpanded ? 'See Less' : 'See More',
                          style: Fonts.nunitoSans14BoldDarkGrey,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey.shade300,
            child: widget.reviewItem.userImageUrl.isNotEmpty
                ? ClipOval(
                    child: Image.network(
                      widget.reviewItem.userImageUrl,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person,
                          color: Colors.grey.shade600,
                          size: 24,
                        );
                      },
                    ),
                  )
                : Icon(
                    Icons.person,
                    color: Colors.grey.shade600,
                    size: 24,
                  ),
          ),
        ),
      ],
    );
  }
}
