import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/custom_snakbar.dart';
import 'package:woodiex/core/widgets/loading_circle_indicator.dart';
import 'package:woodiex/core/animations/custom_loading_animation.dart';
import 'package:woodiex/featrues/wishlist/logic/wishlist_notifier.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';
import 'package:woodiex/featrues/home/logic/get_product_notifier/get_product_states.dart';
import 'package:woodiex/featrues/home/logic/get_product_notifier/get_product_notifier.dart';
import 'package:woodiex/featrues/home/ui/widgets/home_screen_widgets/furnitrue_item_widget.dart';

class FurnitureGridView extends ConsumerStatefulWidget {
  const FurnitureGridView({super.key});

  @override
  _FurnitureGridViewState createState() => _FurnitureGridViewState();
}

class _FurnitureGridViewState extends ConsumerState<FurnitureGridView> {
  final ScrollController _scrollController = ScrollController();
  late List<bool> shoppingCartStates;
  bool _isLoadingMore = false; // Flag to prevent multiple simultaneous loads

  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => ref.read(getProductNotifierProvider.notifier).fetchProducts());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !_scrollController.position.outOfRange &&
          !_isLoadingMore) {
        final notifier = ref.read(getProductNotifierProvider.notifier);
        final state = ref.read(getProductNotifierProvider);
        state.when(
          initial: () {},
          loading: (_) {},
          success: (products) {
            _isLoadingMore = true;
            notifier.loadMoreProducts().then((_) {
              _isLoadingMore = false;
            });
          },
          loadMoreSuccess: (products, hasReachedMax) {
            if (!hasReachedMax) {
              _isLoadingMore = true;
              notifier.loadMoreProducts().then((_) {
                _isLoadingMore = false;
              });
            }
          },
          error: (_) {},
          filterLoading: (_) {},
          filterSuccess: (_) {}, // Skip load more during filtered state
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void toggleShoppingCart(int index) {
    setState(() {
      shoppingCartStates[index] = !shoppingCartStates[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(getProductNotifierProvider);

    return state.when(
      initial: () => const Center(child: Text('Loading products...')),
      loading: (products) {
        print('Building grid with ${products.length} products (loading state)');
        shoppingCartStates = List<bool>.filled(products.length, false);
        return _buildGridView(products, state: state);
      },
      success: (products) {
        print('Building grid with ${products.length} products (success state)');
        shoppingCartStates = List<bool>.filled(products.length, false);
        return _buildGridView(products,
            hasReachedMax: true,
            state: state); // No more loading for initial fetch
      },
      loadMoreSuccess: (products, hasReachedMax) {
        print(
            'Building grid with ${products.length} products (load more success state)');
        shoppingCartStates = List<bool>.filled(products.length, false);
        return _buildGridView(products,
            hasReachedMax: hasReachedMax, state: state);
      },
      error: (error) => Center(child: Text('Error: ${error.message}')),
      filterLoading: (products) {
        print(
            'Building grid with ${products.length} products (filter loading state)');
        shoppingCartStates = List<bool>.filled(products.length, false);
        return _buildGridView(products,
            hasReachedMax: true, state: state); // No more loading during filter
      },
      filterSuccess: (products) {
        print(
            'Building grid with ${products.length} products (filter success state)');
        shoppingCartStates = List<bool>.filled(products.length, false);
        return _buildGridView(products,
            hasReachedMax: true, state: state); // No more loading after filter
      },
    );
  }

  Widget _buildGridView(List<ProductData> products,
      {bool hasReachedMax = false, required GetProductState state}) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(12),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                if (index >= products.length) return null;
                return FurnitureItemWidget(
                  item: products[index],
                  onCartToggle: () {
                    final wishlistNotifier =
                        ref.read(wishlistNotifierProvider.notifier);
                    wishlistNotifier.addToWishlist(products[index]);
                    CustomSnackBar.showInfo(
                      context,
                      '${products[index].name} added to cart successfully!',
                    );
                  },
                  heroTag:
                      'furniture_${products[index].name}_${products[index].id}',
                  isTapped: ref
                      .watch(wishlistNotifierProvider)
                      .any((item) => item.id == products[index].id),
                );
              },
              childCount: products.length,
            ),
          ),
        ),
        // Show loading indicator for all states except when hasReachedMax is true
        if (!hasReachedMax)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: CustomLoadingWidget()),
            ),
          ),
        if (hasReachedMax && products.isNotEmpty)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Center(child: Text('No more products to load')),
            ),
          ),
      ],
    );
  }
}
