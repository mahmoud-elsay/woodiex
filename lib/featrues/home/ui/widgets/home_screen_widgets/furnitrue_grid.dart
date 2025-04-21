import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/home_screen_widgets/furnitrue_item_widget.dart';

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

  late List<bool> shoppingCartStates;

  @override
  void initState() {
    super.initState();
    shoppingCartStates = List<bool>.filled(furnitureItems.length, false);
  }

  void toggleFavorite(int index) {
    setState(() {
      furnitureItems[index].isFavorite = !furnitureItems[index].isFavorite;
    });
  }

  void toggleShoppingCart(int index) {
    setState(() {
      shoppingCartStates[index] = !shoppingCartStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final pairIndex = index * 2;
                final hasSecondItem = pairIndex + 1 < furnitureItems.length;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: FurnitureItemWidget(
                          item: furnitureItems[pairIndex],
                          onFavoriteToggle: () => toggleShoppingCart(pairIndex),
                          heroTag:
                              'furniture_${furnitureItems[pairIndex].name}_$pairIndex',
                          isTapped: shoppingCartStates[pairIndex],
                        ),
                      ),
                      const SizedBox(width: 12),
                      hasSecondItem
                          ? Expanded(
                              child: FurnitureItemWidget(
                                item: furnitureItems[pairIndex + 1],
                                onFavoriteToggle: () =>
                                    toggleShoppingCart(pairIndex + 1),
                                heroTag:
                                    'furniture_${furnitureItems[pairIndex + 1].name}_${pairIndex + 1}',
                                isTapped: shoppingCartStates[pairIndex + 1],
                              ),
                            )
                          : const Expanded(child: SizedBox()),
                    ],
                  ),
                );
              },
              childCount: (furnitureItems.length / 2).ceil(),
            ),
          ),
        ),
      ],
    );
  }
}
