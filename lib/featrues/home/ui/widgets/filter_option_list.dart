import 'package:flutter/material.dart';
import '../widgets/filter_option_item.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/home/data/models/fillter_option_model.dart';

class FilterOptionsList extends StatefulWidget {
  const FilterOptionsList({super.key});

  @override
  State<FilterOptionsList> createState() => _FilterOptionsListState();
}

class _FilterOptionsListState extends State<FilterOptionsList> {
  List<FilterOption> filterOptions = [
    FilterOption(
        iconPath: 'assets/svgs/popular.svg',
        label: 'popular',
        isSelected: true),
    FilterOption(iconPath: 'assets/svgs/chair.svg', label: 'Chair'),
    FilterOption(iconPath: 'assets/svgs/table.svg', label: 'Table'),
    FilterOption(iconPath: 'assets/svgs/armchair.svg', label: 'Armchair'),
    FilterOption(iconPath: 'assets/svgs/bed.svg', label: 'Bed'),
  ];

  void toggleSelection(int index) {
    setState(() {
      for (var i = 0; i < filterOptions.length; i++) {
        filterOptions[i].isSelected = i == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: filterOptions.length,
        separatorBuilder: (context, index) => horizontalSpace(16),
        itemBuilder: (context, index) {
          return FilterOptionItem(
            option: filterOptions[index],
            onTap: () => toggleSelection(index),
          );
        },
      ),
    );
  }
}
