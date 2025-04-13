import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';

class DescriptionSection extends StatelessWidget {
  final String description;

  const DescriptionSection({Key? key, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      overflow: TextOverflow.fade,
      style: Fonts.nunitoSans14LightMainBlack,
    );
  }
}
