import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/theming/font_weight.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/furnitrue_item_model.dart';
import 'package:woodiex/featrues/profile/ui/widgets/settings_screen_widgets/pesonal_info_widget.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/product_sliver_app_bar.dart';

class ProductDetailsScreen extends StatefulWidget {
  final FurnitureItemModel item;

  const ProductDetailsScreen({super.key, required this.item});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int quantity = 01;
  void _increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  void _decreaseQuantity() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    }
  }

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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.item.name,
                    style: Fonts.gelasio24SemiBold.copyWith(
                        color: ColorsManager.mainBlack,
                        fontWeight: FontWeightHelper.medium),
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      Text(
                        '\$50',
                        style:
                            Fonts.darkNnitoSansBold20.copyWith(fontSize: 30.sp),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: _increaseQuantity,
                        child: SvgPicture.asset('assets/svgs/add.svg'),
                      ),
                      horizontalSpace(10),
                      Text(
                        quantity.toString(),
                        style: Fonts.darkNnitoSansSemiBold18,
                      ),
                      horizontalSpace(10),
                      GestureDetector(
                        onTap: _decreaseQuantity,
                        child: SvgPicture.asset('assets/svgs/decrease.svg'),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  Row(
                    children: [
                      SvgPicture.asset('assets/svgs/star.svg'),
                      horizontalSpace(10),
                      Text(
                        '4.5',
                        style: Fonts.blacknNnitoSansBold18,
                      ),
                      horizontalSpace(15),
                      Text(
                        '(50 reviews)',
                        style: Fonts.nunitoSansRegular14.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                  verticalSpace(20),
                  Text(
                      'Minimal Stand is made of by natural wood. The design that is very simple and minimal. This is truly one of the best furnitures in any family for now. With 3 different colors, you can easily select the best match for your home. ',
                      overflow: TextOverflow.fade,
                      style: Fonts.nunitoSansRegular14
                          .copyWith(fontWeight: FontWeightHelper.light))
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}
