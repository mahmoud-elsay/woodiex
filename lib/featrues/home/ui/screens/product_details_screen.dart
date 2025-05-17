import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/get_product_response_model.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/product_info.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/rating_sction.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/wishlist_button.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/quantity_selector.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/description_section.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/product_sliver_app_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductData item;

  const ProductDetailsScreen({super.key, required this.item});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 1;
  bool isSaved = false;

  void _increaseQuantity() => setState(() => quantity++);

  void _decreaseQuantity() {
    if (quantity > 1) setState(() => quantity--);
  }

  void _toggleWishlist() => setState(() => isSaved = !isSaved);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ProductSliverAppBar(item: widget.item),
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
                        ProductInfo(item: widget.item),
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
                    RatingSection(rating: 4.5, reviews: 50),
                    verticalSpace(20),
                    DescriptionSection(
                      description:
                          'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home.',
                    ),
                    verticalSpace(30),
                    Row(
                      children: [
                        WishlistButton(
                            isSaved: isSaved, onToggle: _toggleWishlist),
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
      ),
    );
  }
}
