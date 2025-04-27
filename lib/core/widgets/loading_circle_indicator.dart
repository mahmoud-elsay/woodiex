import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';

class LoadingCircleIndicator extends StatelessWidget {
  const LoadingCircleIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: ColorsManager.mainBlack),
    );
  }
}
