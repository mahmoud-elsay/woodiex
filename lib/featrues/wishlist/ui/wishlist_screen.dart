import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/wishlist/logic/wishlist_notifier.dart';
import 'package:woodiex/featrues/wishlist/ui/widgets/wishlist_list_view_.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlist = ref.watch(wishlistNotifierProvider);

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
              Expanded(
                child: wishlist.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.production_quantity_limits_sharp,
                              size: 70,
                              color: Colors.grey,
                            ),
                            verticalSpace(20),
                            Text(
                              'No Items Added to Wishlist',
                              style: Fonts.nunitoSans16RegularSecondaryGrey
                                  .copyWith(
                                color:
                                    ColorsManager.moreDarkGrey.withAlpha(179),
                              ),
                            ),
                          ],
                        ),
                      )
                    : WishlistListView(items: wishlist),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
