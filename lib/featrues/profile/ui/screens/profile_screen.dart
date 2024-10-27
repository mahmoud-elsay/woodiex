import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/profile_screen_widgets/profile_list_view.dart';
import 'package:woodiex/featrues/profile/ui/widgets/profile_screen_widgets/profile_pic_row.dart'; // Import the new widget


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              AppTopBar(
                title: Text(
                  'Profile',
                  style: Fonts.blackMerriweather16bold,
                ),
                rightIconAsset: 'assets/svgs/logout.svg',
              ),
              verticalSpace(30),
              ProfilePicRow(),
              verticalSpace(50),
              Expanded(
                // Wrap the list view in an Expanded widget
                child: ProfileListView(), // Use the new list view widget here
              ),
            ],
          ),
        ),
      ),
    );
  }
}
