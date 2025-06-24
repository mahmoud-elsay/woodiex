import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderFilter extends StatefulWidget {
  final String selectedFilter;
  final Function(String) onFilterChanged;

  const OrderFilter({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  State<OrderFilter> createState() => _OrderFilterState();
}

class _OrderFilterState extends State<OrderFilter> {
  // List of filter names
  final List<String> _filterNames = [
    'All',
    'Delivered',
    'Pending',
    'Cancelled'
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_filterNames.length, (index) {
        final filterName = _filterNames[index];
        final isSelected = widget.selectedFilter == filterName;

        return Expanded(
          child: GestureDetector(
            onTap: () {
              widget.onFilterChanged(filterName);
            },
            child: Column(
              children: [
                Text(
                  filterName,
                  style: isSelected
                      ? Fonts.nunitoSans18BoldMainBlack
                      : Fonts.nunitoSans18RegularSecondaryGrey,
                ),
                verticalSpace(5),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  width: 40.w,
                  height: isSelected ? 4.h : 0,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorsManager.mainBlack
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
