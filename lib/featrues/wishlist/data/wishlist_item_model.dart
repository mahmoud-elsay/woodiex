import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';

class WishlistItem {
  final int id;
  final String name;
  final double price;
  final String imageUrl;

  WishlistItem({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });

  factory WishlistItem.fromProductData(ProductData product) {
    return WishlistItem(
      id: product.id,
      name: product.name,
      price: product.price,
      imageUrl: product.imageUrl,
    );
  }
}
