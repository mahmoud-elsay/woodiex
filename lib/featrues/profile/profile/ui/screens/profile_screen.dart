import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_top_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/custom_snakbar.dart';
import 'package:woodiex/core/network/api_error_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/core/animations/custom_loading_animation.dart';
import 'package:woodiex/featrues/profile/profile/logic/get_profile_staets.dart';
import 'package:woodiex/featrues/profile/profile/logic/profile_image_states.dart';
import 'package:woodiex/featrues/profile/profile/logic/get_profile_notifier.dart';
import 'package:woodiex/featrues/profile/profile/logic/profile_image_notifier.dart';
import 'package:woodiex/featrues/profile/profile/ui/widgets/profile_screen_widgets/profile_pic_row.dart';
import 'package:woodiex/featrues/profile/profile/ui/widgets/profile_screen_widgets/profile_list_view.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  bool _hasTriedCachedData = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProfile();
    });
  }

  Future<void> _loadProfile() async {
    try {
      print('ProfileScreen: Starting _loadProfile');

      // Try to load cached data first for immediate display
      if (!_hasTriedCachedData) {
        final cachedData = await ref
            .read(getProfileNotifierProvider.notifier)
            .getCachedProfileData();
        if (cachedData != null) {
          print('ProfileScreen: Found cached data, displaying it first');
          // You could set a temporary state here if needed
        }
        _hasTriedCachedData = true;
      }

      // Always fetch fresh data
      final token = await SharedPrefHelper.getUserToken();
      print(
          'ProfileScreen: Retrieved token - ${token.isNotEmpty ? "Token exists" : "No token found"}');

      if (token.isNotEmpty) {
        final formattedToken =
            token.startsWith('Bearer ') ? token : 'Bearer $token';
        print('ProfileScreen: Calling getProfileInfo with formatted token');
        await ref
            .read(getProfileNotifierProvider.notifier)
            .getProfileInfo(formattedToken);
      } else {
        print('ProfileScreen: No token available, showing error');
        CustomSnackBar.showError(context, 'Please log in to view your profile');
      }
    } catch (e) {
      print('ProfileScreen: Error in _loadProfile: $e');
      if (mounted) {
        CustomSnackBar.showError(
            context, 'Failed to load profile: ${e.toString()}');
      }
    }
  }

  Future<void> _refreshProfile() async {
    try {
      print('ProfileScreen: Starting _refreshProfile');
      await ref.read(getProfileNotifierProvider.notifier).refreshProfile();
    } catch (e) {
      print('ProfileScreen: Error in _refreshProfile: $e');
      if (mounted) {
        CustomSnackBar.showError(
            context, 'Failed to refresh profile: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileImageState = ref.watch(profileImageNotifierProvider);
    final getProfileState = ref.watch(getProfileNotifierProvider);

    print(
        'ProfileScreen: Current profile state: ${getProfileState.runtimeType}');

    // Listen to profile fetch state changes
    ref.listen<GetProfileState>(getProfileNotifierProvider, (previous, next) {
      print(
          'ProfileScreen: State changed from ${previous.runtimeType} to ${next.runtimeType}');

      if (next is GetProfileError) {
        final errorMessage = next.error.message ?? 'Failed to load profile';
        print('ProfileScreen: Showing error: $errorMessage');
        CustomSnackBar.showError(context, errorMessage);
      } else if (next is GetProfileSuccess) {
        print('ProfileScreen: Profile loaded successfully');
        // Optionally show success message
        // CustomSnackBar.showSuccess(context, 'Profile loaded successfully');
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            RefreshIndicator(
              onRefresh: _refreshProfile,
              child: Padding(
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

                    // Pass profile data to ProfilePicRow with better state handling
                    _buildProfilePicSection(getProfileState),

                    verticalSpace(50),
                    Expanded(
                      child: _buildProfileContent(getProfileState),
                    ),
                  ],
                ),
              ),
            ),

            // Full Screen Loading Overlay (only for initial loading)
            if (_shouldShowFullScreenLoading(getProfileState))
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
                          'Loading profile...',
                          style: Fonts.nunitoSans16SemiBoldMainBlack,
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(8),
                        Text(
                          'Please wait while we fetch your profile information',
                          style: Fonts.nunitoSans14RegularSecondaryGrey,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

            // Profile Image Upload Loading Overlay
            if (profileImageState is ProfileImageLoading)
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

  Widget _buildProfilePicSection(GetProfileState state) {
    return state.when(
      initial: () => _buildLoadingProfilePicRow(),
      loading: () => _buildLoadingProfilePicRow(),
      success: (profileData) {
        print(
            'ProfileScreen: Building ProfilePicRow with data: ${profileData.data}');
        return ProfilePicRow(profileData: profileData.data);
      },
      error: (error) {
        print('ProfileScreen: Building ProfilePicRow with error state');
        return _buildErrorProfilePicRow(
            error.message ?? 'Failed to load profile');
      },
    );
  }

  Widget _buildProfileContent(GetProfileState state) {
    return state.when(
      initial: () => ProfileListView(),
      loading: () => ProfileListView(),
      success: (profileData) => ProfileListView(),
      error: (error) => _buildErrorContent(error),
    );
  }

  Widget _buildLoadingProfilePicRow() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[300],
            ),
            child: Center(
              child: SizedBox(
                width: 30.w,
                height: 30.h,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 150.w,
                height: 20.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              verticalSpace(10),
              Container(
                width: 200.w,
                height: 16.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorProfilePicRow(String errorMessage) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            width: 80.w,
            height: 80.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red[100],
            ),
            child: Icon(
              Icons.error_outline,
              color: Colors.red[400],
              size: 30.w,
            ),
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Error Loading Profile',
                style: Fonts.nunitoSans16SemiBoldMainBlack,
              ),
              verticalSpace(5),
              Text(
                errorMessage,
                style: Fonts.nunitoSans14RegularSecondaryGrey,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorContent(ApiErrorModel error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60.w,
            color: Colors.red[400],
          ),
          verticalSpace(16),
          Text(
            'Failed to load profile',
            style: Fonts.nunitoSans18SemiBoldMainBlack,
            textAlign: TextAlign.center,
          ),
          verticalSpace(8),
          Text(
            error.message ?? 'Unknown error occurred',
            style: Fonts.nunitoSans14RegularSecondaryGrey,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          verticalSpace(20),
          ElevatedButton(
            onPressed: _refreshProfile,
            child: Text('Retry'),
          ),
        ],
      ),
    );
  }

  // Helper method to determine when to show full screen loading
  bool _shouldShowFullScreenLoading(GetProfileState state) {
    // Show full screen loading only for initial loading
    return state is GetProfileLoading && !_hasTriedCachedData;
  }
}
