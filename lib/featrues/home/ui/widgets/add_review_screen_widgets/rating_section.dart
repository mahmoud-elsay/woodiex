import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';

class RatingSection extends StatefulWidget {
  final Function(int) onRatingChanged;

  const RatingSection({super.key, required this.onRatingChanged});

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  int _rating = 0;
  final double _starSize = 40.0;
  final double _padding = 4.0;

  void _updateRating(Offset localPosition) {
    final starTotalWidth = _starSize + (_padding * 2);
    int newRating = (localPosition.dx / starTotalWidth).floor() + 1;
    newRating = newRating.clamp(0, 5);

    setState(() {
      _rating = newRating;
      widget.onRatingChanged(_rating);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rate this product',
          style: Fonts.nunitoSans14RegularMainBlack,
        ),
        verticalSpace(15),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            final localPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(details.globalPosition);
            _updateRating(localPosition);
          },
          onTapDown: (details) {
            final localPosition = (context.findRenderObject() as RenderBox)
                .globalToLocal(details.globalPosition);
            _updateRating(localPosition);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(5, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: SvgPicture.asset(
                  index < _rating
                      ? 'assets/svgs/fill_star_icon.svg'
                      : 'assets/svgs/empty_star_icon.svg',
                  colorFilter: ColorFilter.mode(
                    index < _rating
                        ? ColorsManager.secondaryGrey // Adjusted to match theme
                        : ColorsManager.mainBlack,
                    BlendMode.srcIn,
                  ),
                  width: _starSize,
                  height: _starSize,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
