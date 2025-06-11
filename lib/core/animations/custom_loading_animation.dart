import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 200,
            child: Lottie.asset('assetsظlottiesظfurniture_loading_lottie.json'),
          ),
          const SizedBox(
            height: 20,
          ),
          const LinearProgressIndicator(
            color: ColorsManager.mainBlack,
            backgroundColor: ColorsManager.lightGrey,
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      ),
    );
  }
}
