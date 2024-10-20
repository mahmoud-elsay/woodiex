class FurnitureItemModel {
  final String productPath; // Path to the SVG asset
  final String name;
  final double price;
  bool isFavorite;

  FurnitureItemModel({
    required this.productPath,
    required this.name,
    required this.price,
    this.isFavorite = false,
  });
}
