import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewsListViewItem extends StatefulWidget {
  const ReviewsListViewItem({super.key});

  @override
  _ReviewsListViewItemState createState() => _ReviewsListViewItemState();
}

class _ReviewsListViewItemState extends State<ReviewsListViewItem> {
  bool _isExpanded = false; // State to track if the text is expanded

  @override
  Widget build(BuildContext context) {
    const fullText =
        'Nice Furniture with good delivery. The delivery time is very fast. '
        'Then products look like exactly the picture in the app. Besides, '
        'color is also the same and quality is very good despite very cheap price.';

    const truncatedText =
        'Nice Furniture with good delivery  time is very fast ,Then products look like exactly the picture in the app. Besides'; // Shortened text

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 335.w,
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(horizontal: 16),
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
            // Add this to allow scrolling
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min, // Allow column to size itself
              children: [
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bruno Fernandes',
                      style:
                          Fonts.darkNnitoSansSemiBold18.copyWith(fontSize: 14),
                    ),
                    Spacer(),
                    Text(
                      '20/03/2020',
                      style: Fonts.nunitoSansRegular14.copyWith(fontSize: 12),
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
                    );
                  }),
                ),
                verticalSpace(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _isExpanded ? fullText : truncatedText,
                      style: Fonts.nunitoSansRegular14
                          .copyWith(color: ColorsManager.mainBlack),
                      maxLines: _isExpanded ? null : 3,
                      overflow: _isExpanded
                          ? TextOverflow.visible
                          : TextOverflow.ellipsis,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded; // Toggle state
                        });
                      },
                      child: Text(
                        _isExpanded ? 'See Less' : 'See More',
                        style: Fonts.darkGreyNunitoSansBold14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Centered overlapping profile image
        Positioned(
          top: -24,
          left: 0,
          right: 0,
          child: CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/images/profile_pic.png'),
          ),
        ),
      ],
    );
  }
}
