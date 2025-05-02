import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderFilter extends StatefulWidget {
  const OrderFilter({super.key});

  @override
  State<OrderFilter> createState() => _OrderFilterState();
}

class _OrderFilterState extends State<OrderFilter> {
  // Track the selected filter
  int _selectedFilterIndex = 0;

  // List of filter names for convenience
  final List<String> _filterNames = ['Delivered', 'Pending', 'Cancelled'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_filterNames.length, (index) {
        final isSelected = _selectedFilterIndex == index;
        return Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                // Update the selected filter index
                _selectedFilterIndex = index;
              });
            },
            child: Column(
              children: [
                Text(
                  _filterNames[index],
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
