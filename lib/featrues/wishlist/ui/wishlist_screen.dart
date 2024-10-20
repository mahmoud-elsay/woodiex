import 'package:flutter/material.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: AppTopBar(
                title: Text(
      'Wishlist',
    ))));
  }
}
