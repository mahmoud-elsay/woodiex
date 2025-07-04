import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/wishlist/data/wishlist_item_model.dart';

class WishlistListViewItem extends StatelessWidget {
  final WishlistItem item;
  final VoidCallback onRemove;

  const WishlistListViewItem(
      {super.key, required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.network(
                  item.imageUrl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.error),
                ),
              ),
            ),
            horizontalSpace(30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Fonts.nunitoSans14SemiBoldSecondaryGrey,
                ),
                verticalSpace(10),
                Text(
                  '\$${item.price.toStringAsFixed(2)}',
                  style: Fonts.nunitoSans16BoldMainBlack,
                ),
              ],
            ),
            const Spacer(),
            Column(
              children: [
                GestureDetector(
                  onTap: onRemove,
                  child: SvgPicture.asset('assets/svgs/remove.svg'),
                ),
                verticalSpace(20),
                SvgPicture.asset('assets/svgs/selected_wish_list.svg'),
              ],
            ),
          ],
        ),
        verticalSpace(10),
        Divider(
          height: 1.h,
          color: Colors.grey.shade300,
        ),
        verticalSpace(10),
      ],
    );
  }
}
