import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';
import 'package:woodiex/featrues/home/ui/screens/product_details_screen.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/animation_transtion.dart';

class FurnitureItemWidget extends StatelessWidget {
  final FurnitureItemModel item;
  final VoidCallback onFavoriteToggle;
  final String heroTag;
  final bool isTapped;

  const FurnitureItemWidget({
    super.key,
    required this.item,
    required this.onFavoriteToggle,
    required this.heroTag,
    required this.isTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Container with rounded corners, white background, and shadow
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(CustomHeroPageRoute(
              page: ProductDetailsScreen(item: item),
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.white, // White background for the image container
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              children: [
                Hero(
                  tag: heroTag,
                  child: Container(
                    width: double.infinity,
                    height: 200.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors
                          .transparent, // Transparent background for the image
                      image: DecorationImage(
                        image: AssetImage(
                          item.productPath.replaceAll('.svg', '.png'),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      width: 30.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        color: isTapped
                            ? ColorsManager.mainBlack
                            : ColorsManager.lighterGreyWith40Opacity,
                        borderRadius: BorderRadius.circular(6.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/svgs/shopping.svg',
                          height: 16.h,
                          width: 16.w,
                          color: isTapped ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Text section outside the Container, directly on the parent's background
        Padding(
          padding: const EdgeInsets.only(
              top: 8), // Space between the container and text
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name,
                style: Fonts.nunitoSans14RegularSecondaryGrey,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              verticalSpace(4),
              Text(
                '\$${item.price.toStringAsFixed(2)}',
                style: Fonts.nunitoSans14BoldMainBlack,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
