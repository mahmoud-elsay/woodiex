import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/theming/colors.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ImagePickerDialog {
  static Future<XFile?> show(BuildContext context) async {
    XFile? selectedImage;

    await showModalBottomSheet<XFile?>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext modalContext) {
        return WillPopScope(
          onWillPop: () async => false, // Prevent back button from dismissing
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Handle bar
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: ColorsManager.lightGrey,
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                    verticalSpace(20),

                    Text(
                      'Select Profile Picture',
                      style: Fonts.nunitoSans18SemiBoldMainBlack,
                    ),
                    verticalSpace(30),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildOption(
                          modalContext,
                          icon: Icons.camera_alt,
                          label: 'Camera',
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.camera,
                              imageQuality: 85,
                              maxWidth: 800,
                              maxHeight: 800,
                            );
                            if (image != null) {
                              selectedImage = image;
                            }
                            if (modalContext.mounted) {
                              Navigator.pop(modalContext, selectedImage);
                            }
                          },
                        ),
                        _buildOption(
                          modalContext,
                          icon: Icons.photo_library,
                          label: 'Gallery',
                          onTap: () async {
                            final ImagePicker picker = ImagePicker();
                            final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery,
                              imageQuality: 85,
                              maxWidth: 800,
                              maxHeight: 800,
                            );
                            if (image != null) {
                              selectedImage = image;
                            }
                            if (modalContext.mounted) {
                              Navigator.pop(modalContext, selectedImage);
                            }
                          },
                        ),
                      ],
                    ),
                    verticalSpace(30),

                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(
                              modalContext, null); // Return null on cancel
                        },
                        child: Text(
                          'Cancel',
                          style: Fonts.nunitoSans16SemiBoldSecondaryGrey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    return selectedImage; // Return the selected image or null
  }

  static Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120.w,
        padding: EdgeInsets.symmetric(vertical: 20.h),
        decoration: BoxDecoration(
          color: ColorsManager.lightGrey.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.lightGrey.withOpacity(0.3),
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: ColorsManager.mainBlack,
            ),
            verticalSpace(8),
            Text(
              label,
              style: Fonts.nunitoSans14RegularMainBlack,
            ),
          ],
        ),
      ),
    );
  }
}
