import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';

class ProductSliverAppBar extends StatelessWidget {
  final FurnitureItemModel item;

  const ProductSliverAppBar({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'furniture_${item.name}_${item.hashCode}', // Use item directly
          child: Image.asset(
            item.productPath,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
