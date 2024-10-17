import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';

class FurnitureItemWidget extends StatelessWidget {
  final FurnitureItemModel item;
  final VoidCallback onFavoriteToggle;

  const FurnitureItemWidget({
    super.key,
    required this.item,
    required this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item.productPath.replaceAll('.svg', '.png'), // Use PNG asset
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.fill, // Ensure the image fits well
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset(
                      'assets/svgs/shoping.png', // Replace with PNG asset
                      height: 20,
                      width: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          verticalSpace(8),
          Text(
            item.name,
            style: Fonts.nunitoSansRegular14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(4),
          Text(
            '\$${item.price.toStringAsFixed(2)}',
            style: Fonts.darkGreyNunitoSansBold14.copyWith(
              color: ColorsManager.mainBlack,
            ),
          ),
        ],
      ),
    );
  }
}
