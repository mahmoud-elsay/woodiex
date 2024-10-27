import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/my_reviews_screen_widgets/my_reviews_list_view.dart';

class MyReviewsScreen extends StatelessWidget {
  const MyReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          children: [
            Row(
              children: [
                BackableTopBar(screenTitle: 'My Reviews'),
                Spacer(),
                SvgPicture.asset('assets/svgs/search.svg'),
              ],
            ),
            verticalSpace(20),
            Expanded(child: MyReviewsListView())
          ],
        ),
      )),
    );
  }
}
