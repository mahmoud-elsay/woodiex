import 'package:flutter/material.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/furnitrue_item_widget.dart';

class FurnitureGridView extends StatefulWidget {
  const FurnitureGridView({super.key});

  @override
  State<FurnitureGridView> createState() => _FurnitureGridViewState();
}

class _FurnitureGridViewState extends State<FurnitureGridView> {
  final List<FurnitureItemModel> furnitureItems = [
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Modern Chair',
      price: 120.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Wooden Table',
      price: 230.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Sofa',
      price: 340.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Bed',
      price: 450.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Modern Chair',
      price: 120.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Wooden Table',
      price: 230.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Sofa',
      price: 340.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Bed',
      price: 450.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Modern Chair',
      price: 120.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Wooden Table',
      price: 230.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Sofa',
      price: 340.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Bed',
      price: 450.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Modern Chair',
      price: 120.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Wooden Table',
      price: 230.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Sofa',
      price: 340.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Bed',
      price: 450.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Modern Chair',
      price: 120.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Wooden Table',
      price: 230.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Sofa',
      price: 340.0,
    ),
    FurnitureItemModel(
      productPath: 'assets/images/prod.png',
      name: 'Bed',
      price: 450.0,
    ),
  ];

  void toggleFavorite(int index) {
    setState(() {
      furnitureItems[index].isFavorite = !furnitureItems[index].isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12), // Adjust padding if needed
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12, // Adjust spacing for aesthetics
        crossAxisSpacing: 12,
        childAspectRatio: 0.7, // Try tweaking this for better item proportions
      ),
      itemCount: furnitureItems.length,
      itemBuilder: (context, index) {
        return FurnitureItemWidget(
          item: furnitureItems[index],
          onFavoriteToggle: () => toggleFavorite(index),
        );
      },
    );
  }
}
