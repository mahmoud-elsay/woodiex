import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/settings_screen_widgets/pesonal_info_widget.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> imgList;
  final ValueChanged<int> onPageChanged;

  const ImageCarousel(
      {super.key, required this.imgList, required this.onPageChanged});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: true,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          onPageChanged(index); // Callback to update current index
        },
      ),
      items: imgList.map((item) {
        return Container(
          child: Center(
            child: Image.asset(
              item,
              fit: BoxFit.cover,
              width: 1000.w,
            ),
          ),
        );
      }).toList(),
    );
  }
}
