import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';

class ProductSliverAppBar extends StatelessWidget {
  final FurnitureItemModel item;

  const ProductSliverAppBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: ColorsManager.white,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'furniture_${item.name}', // Same hero tag for smooth transition
          child: Image.asset(
            item.productPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
