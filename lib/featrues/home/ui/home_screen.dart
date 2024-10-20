import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/ui/widgets/home_top_bar.dart';
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
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeTopBar(),
              verticalSpace(20),
              const FilterOptionsList(),
              verticalSpace(20),
              // Wrap the GridView with Expanded to allow it to scroll properly
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
