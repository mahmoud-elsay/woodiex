import 'package:flutter/material.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';

class ProductSliverAppBar extends StatelessWidget {
  final ProductData item;

  const ProductSliverAppBar({super.key, required this.item});

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
            item.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
