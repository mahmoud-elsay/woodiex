import 'package:flutter/material.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/indicator.dart';
import 'package:woodiex/featrues/home/ui/widgets/product_details_screen_widget/image_carousel.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String> imgList;

  CarouselWithIndicator({required this.imgList});

  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageCarousel(
          imgList: widget.imgList,
          onPageChanged: (index) {
            setState(() {
              _current = index;
            });
          },
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: CarouselIndicator(
            currentIndex: _current,
            itemCount: widget.imgList.length,
          ),
        ),
      ],
    );
  }
}
