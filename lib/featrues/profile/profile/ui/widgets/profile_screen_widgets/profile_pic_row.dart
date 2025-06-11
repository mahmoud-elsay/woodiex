import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/custom_snakbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/helpers/shared_pref_helper.dart';
import 'package:woodiex/featrues/profile/profile/logic/profile_image_states.dart';
import 'package:woodiex/featrues/profile/profile/logic/get_profile_notifier.dart';
import 'package:woodiex/featrues/profile/profile/logic/profile_image_notifier.dart';
import 'package:woodiex/featrues/profile/profile/data/models/update_profile_image_request.dart';
import 'package:woodiex/featrues/profile/profile/data/models/get_profile_info_response_model.dart';
import 'package:woodiex/featrues/profile/profile/ui/widgets/profile_screen_widgets/image_picker_dialog.dart';

class ProfilePicRow extends ConsumerStatefulWidget {
  final Data? profileData;

  const ProfilePicRow({super.key, this.profileData});

  @override
  ConsumerState<ProfilePicRow> createState() => _ProfilePicRowState();
}

class _ProfilePicRowState extends ConsumerState<ProfilePicRow> {
  final ImagePicker _picker = ImagePicker();
  String? _localImagePath;

  @override
  void initState() {
    super.initState();
    _loadCachedImage();
  }

  Future<void> _loadCachedImage() async {
    final cachedPath = await ref
        .read(profileImageNotifierProvider.notifier)
        .getCachedProfileImagePath();
    if (cachedPath != null && await File(cachedPath).exists()) {
      setState(() {
        _localImagePath = cachedPath;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await ImagePickerDialog.show(context);
      if (image != null) {
        setState(() {
          _localImagePath = image.path;
        });
        await _uploadImage(image.path);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
            context, 'Failed to pick image: ${e.toString()}');
      }
    }
  }

  Future<void> _uploadImage(String imagePath) async {
    try {
      print('Starting image upload with path: $imagePath');
      final token = await SharedPrefHelper.getUserToken();
      print('Retrieved token: $token');
      if (token == null || token.isEmpty) {
        if (mounted) {
          CustomSnackBar.showError(
              context, 'Authentication token not found. Please log in.');
        }
        return;
      }

      final request =
          UpdateEngineerProfileRequest(profileImageUrl: File(imagePath));
      print('FormData creation started');
      final formData = await request.toFormData();
      print('FormData created: $formData');
      await ref
          .read(profileImageNotifierProvider.notifier)
          .updateProfileImage('Bearer $token', formData);
      print('Image upload called');
    } catch (e) {
      print('Upload error: $e');
      if (mounted) {
        CustomSnackBar.showError(
            context, 'Failed to upload image: ${e.toString()}');
      }
    }
  }

  String _getDisplayName() {
    if (widget.profileData?.fullName != null &&
        widget.profileData!.fullName.isNotEmpty) {
      return widget.profileData!.fullName;
    }
    return 'Loading...';
  }

  String _getDisplayEmail() {
    if (widget.profileData?.email != null &&
        widget.profileData!.email.isNotEmpty) {
      return widget.profileData!.email;
    }
    return 'Loading...';
  }

  String? _getProfileImageUrl() {
    // Priority: local image > server image > null
    if (_localImagePath != null) {
      return _localImagePath;
    }
    if (widget.profileData?.profileImage != null &&
        widget.profileData!.profileImage.isNotEmpty) {
      return widget.profileData!.profileImage;
    }
    return null;
  }

  Widget _buildProfileImage() {
    final imageUrl = _getProfileImageUrl();

    if (imageUrl != null) {
      // Check if it's a local file path or network URL
      if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
        return Image.network(
          imageUrl,
          fit: BoxFit.cover,
          width: 80.w,
          height: 80.h,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.person,
              size: 60,
              color: ColorsManager.white,
            );
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: SizedBox(
                width: 30.w,
                height: 30.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorsManager.white),
                ),
              ),
            );
          },
        );
      } else {
        // Local file
        return Image.file(
          File(imageUrl),
          fit: BoxFit.cover,
          width: 80.w,
          height: 80.h,
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              Icons.person,
              size: 60,
              color: ColorsManager.white,
            );
          },
        );
      }
    }

    return Icon(
      Icons.person,
      size: 60,
      color: ColorsManager.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ProfileImageState>(profileImageNotifierProvider,
        (previous, next) {
      if (next is ProfileImageSuccess) {
        CustomSnackBar.showSuccess(
            context, 'Profile image updated successfully!');
        // Refresh profile data to get updated image URL
        ref.read(getProfileNotifierProvider.notifier).refreshProfile();
      } else if (next is ProfileImageError) {
        CustomSnackBar.showError(
            context, next.error.message ?? 'Upload failed');
      }
    });

    final profileImageState = ref.watch(profileImageNotifierProvider);

    return Row(
      children: [
        GestureDetector(
          onTap: profileImageState is ProfileImageLoading ? null : _pickImage,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: ColorsManager.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.mainBlack.withOpacity(0.2),
                    blurRadius: 10.r,
                    spreadRadius: 2.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    ColorsManager.mainBlack,
                    ColorsManager.secondaryGrey,
                    ColorsManager.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipOval(
                child: Stack(
                  children: [
                    _buildProfileImage(),
                    if (profileImageState is ProfileImageLoading)
                      Container(
                        width: 80.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: ColorsManager.mainBlack.withOpacity(0.5),
                        ),
                        child: Center(
                          child: SizedBox(
                            width: 30.w,
                            height: 30.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorsManager.white),
                            ),
                          ),
                        ),
                      ),
                    if (profileImageState is! ProfileImageLoading)
                      Positioned(
                        bottom: 5.w,
                        right: 5.w,
                        child: Container(
                          width: 22.w,
                          height: 22.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorsManager.white,
                            boxShadow: [
                              BoxShadow(
                                color: ColorsManager.mainBlack.withOpacity(0.2),
                                blurRadius: 4,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 12,
                            color: ColorsManager.secondaryGrey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        horizontalSpace(10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getDisplayName(),
                style: Fonts.nunitoSans20BoldMainBlack,
              ),
              verticalSpace(10),
              Text(
                _getDisplayEmail(),
                style: Fonts.nunitoSans14RegularSecondaryGrey,
              ),
              if (profileImageState is ProfileImageLoading)
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    'Uploading image...',
                    style: Fonts.nunitoSans12RegularSecondaryGrey,
                  ),
                ),
            ],
          ),
        )
      ],
    );
  }
}
