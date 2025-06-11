import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/animations/custom_loading_animation.dart';
import 'package:woodiex/featrues/profile/profile/logic/profile_image_states.dart';
import 'package:woodiex/featrues/profile/profile/logic/profile_image_notifier.dart';
import 'package:woodiex/featrues/profile/profile/ui/widgets/profile_screen_widgets/profile_pic_row.dart';
import 'package:woodiex/featrues/profile/profile/ui/widgets/profile_screen_widgets/profile_list_view.dart';


class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImageState = ref.watch(profileImageNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  AppTopBar(
                    title: Text(
                      'Profile',
                      style: Fonts.merriweather16BoldMainBlack,
                    ),
                    rightIconAsset: 'assets/svgs/logout.svg',
                  ),
                  verticalSpace(30),
                  ProfilePicRow(),
                  verticalSpace(50),
                  Expanded(
                    child: ProfileListView(),
                  ),
                ],
              ),
            ),
            
            // Full Screen Loading Overlay (only for initial loading scenarios)
            if (profileImageState is ProfileImageLoading && _shouldShowFullScreenLoading(profileImageState))
              Container(
                color: Colors.black.withOpacity(0.3),
                child: Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 40.w),
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 100.w,
                          height: 100.h,
                          child: CustomLoadingWidget(),
                        ),
                        verticalSpace(16),
                        Text(
                          'Uploading profile image...',
                          style: Fonts.nunitoSans16SemiBoldMainBlack,
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(8),
                        Text(
                          'Please wait while we update your profile',
                          style: Fonts.nunitoSans14RegularSecondaryGrey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Helper method to determine when to show full screen loading
  bool _shouldShowFullScreenLoading(ProfileImageState state) {
    // You can customize this logic based on your needs
    // For now, we'll only show the small loading indicator in the profile pic
    return false;
  }
}