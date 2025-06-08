import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/product_details_response_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/product_info.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/rating_sction.dart';
import 'package:woodiex/featrues/home/logic/product_details_notifier/product_details_notifier.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/wishlist_button.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/quantity_selector.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/description_section.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/product_sliver_app_bar.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  final int id;

  const ProductDetailsScreen({super.key, required this.id});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  int quantity = 1;
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref
        .read(productDetailsNotifierProvider.notifier)
        .fetchProductDetails(widget.id));
  }

  void _increaseQuantity() => setState(() => quantity++);

  void _decreaseQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  void _toggleWishlist() => setState(() => isSaved = !isSaved);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productDetailsNotifierProvider);

    return Scaffold(
      body: state.when(
        initial: () => const Center(child: CircularProgressIndicator()),
        loading: (data) => _buildContent(data),
        success: (data) => _buildContent(data),
        error: (error) => Center(child: Text('Error: ${error.message}')),
      ),
    );
  }

  Widget _buildContent(ProductDetailsData? data) {
    return CustomScrollView(
      slivers: [
        ProductSliverAppBar(
          item: data ??
              ProductDetailsData(
                id: widget.id,
                name: 'Loading...',
                imageUrl: '',
                description: 'Loading description...',
                price: 0.0,
                reviewsCount: 0,
                reveiewAverageRating: 0.0,
                reviews: [],
              ),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ProductInfo(
                        item: data ??
                            ProductDetailsData(
                              id: widget.id,
                              name: 'Loading...',
                              imageUrl: '',
                              description: 'Loading description...',
                              price: 0.0,
                              reviewsCount: 0,
                              reveiewAverageRating: 0.0,
                              reviews: [],
                            ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: QuantitySelector(
                          quantity: quantity,
                          onIncrease: _increaseQuantity,
                          onDecrease: _decreaseQuantity,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  RatingSection(
                    rating: data?.reveiewAverageRating ?? 0.0,
                    reviews: data?.reviewsCount ?? 0,
                  ),
                  verticalSpace(20),
                  DescriptionSection(
                    description:
                        data?.description ?? 'No description available.',
                  ),
                  verticalSpace(30),
                  Row(
                    children: [
                      WishlistButton(
                        isSaved: isSaved,
                        onToggle: _toggleWishlist,
                      ),
                      horizontalSpace(20),
                      AppTextButton(
                        buttonText: 'Add to cart',
                        textStyle: Fonts.nunitoSans20SemiBoldWhite,
                        onPressed: () {},
                        buttonWidth: 250.w,
                        buttonHeight: 60.h,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
