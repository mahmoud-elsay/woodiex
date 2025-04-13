import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/wishlist/ui/widgets/wishlist_list_view_.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTopBar(
            title: Text(
              'Wishlist',
              style: Fonts.merriweather16BoldMainBlack,
            ),
            rightIconAsset: 'assets/svgs/cartsvg.svg',
          ),
          verticalSpace(20),
          Expanded(child: WishlistListView())
        ],
      ),
    )));
  }
}
