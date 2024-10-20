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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  item.productPath.replaceAll('.svg', '.png'),
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: GestureDetector(
                  onTap: onFavoriteToggle,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: item.isFavorite ? Colors.red : Colors.grey,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          ),
        ],
      ),
    );
  }
}
