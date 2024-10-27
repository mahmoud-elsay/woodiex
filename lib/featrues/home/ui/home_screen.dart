import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/ui/widgets/furnitrue_grid.dart';
import 'package:woodiex/featrues/home/ui/widgets/filter_option_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTopBar(
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Make Home',
                      style: Fonts.gelasio18Regular,
                    ),
                    verticalSpace(2),
                    Text(
                      'BEAUTIFUL',
                      style: Fonts.mainBlackGelasio18Bold,
                    ),
                  ],
                ),
                rightIconAsset: 'assets/svgs/cartsvg.svg',
              ),
              verticalSpace(20),
              const FilterOptionsList(),
              verticalSpace(20),
              Expanded(
                child: FurnitureGridView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
