import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: AppTopBar(
                title: Text(
      'Wishlist',
      style: Fonts.blackMerriweather16bold,
    ))));
  }
}
