import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';

class ProductSliverAppBar extends StatelessWidget {
  final ProductDetailsData item;

  const ProductSliverAppBar({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'furniture_${item.name}_${item.hashCode}',
          child: CachedNetworkImage(
            imageUrl: item.imageUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) =>
                const Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) =>
                const Center(child: Icon(Icons.broken_image)),
          ),
        ),
      ),
    );
  }
}
