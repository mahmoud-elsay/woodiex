import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';

class RatingSection extends StatefulWidget {
  final Function(int) onRatingChanged;
  final int initialRating;

  const RatingSection({
    super.key,
    required this.onRatingChanged,
    this.initialRating = 0,
  });

  @override
  State<RatingSection> createState() => _RatingSectionState();
}

class _RatingSectionState extends State<RatingSection> {
  late int _rating;
  final double _starSize = 40.0;
  final double _padding = 4.0;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  @override
  void didUpdateWidget(RatingSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialRating != oldWidget.initialRating) {
      setState(() {
        _rating = widget.initialRating;
      });
    }
  }

  void _updateRating(Offset localPosition) {
    final starTotalWidth = _starSize + (_padding * 2);
    int newRating = (localPosition.dx / starTotalWidth).floor() + 1;
    newRating = newRating.clamp(0, 5);

    if (newRating != _rating) {
      setState(() {
        _rating = newRating;
      });
      widget.onRatingChanged(_rating);
      print('Rating updated to: $_rating');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: 'Rate this product ',
            style: Fonts.nunitoSans14RegularMainBlack,
            children: [
              TextSpan(
                text: '*',
                style: Fonts.nunitoSans14RegularMainBlack.copyWith(
                  color: ColorsManager.red,
                ),
              ),
            ],
          ),
        ),
        verticalSpace(15),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final localPosition =
                renderBox.globalToLocal(details.globalPosition);
            _updateRating(localPosition);
          },
          onTapDown: (details) {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final localPosition =
                renderBox.globalToLocal(details.globalPosition);
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
                        ? ColorsManager.secondaryGrey // Filled star color
                        : ColorsManager.mainBlack, // Empty star color
                    BlendMode.srcIn,
                  ),
                  width: _starSize,
                  height: _starSize,
                ),
              );
            }),
          ),
        ),
        if (_rating > 0) ...[
          verticalSpace(10),
          Text(
            _getRatingText(_rating),
            style: Fonts.nunitoSans12BoldMainBlack.copyWith(
              color: ColorsManager.secondaryGrey,
            ),
          ),
        ],
      ],
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Very Good';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }
}
