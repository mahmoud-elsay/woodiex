import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePicRow extends StatefulWidget {
  const ProfilePicRow({super.key});

  @override
  State<ProfilePicRow> createState() => _ProfilePicRowState();
}

class _ProfilePicRowState extends State<ProfilePicRow> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _imagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Container(
              width: 80.w,
              height: 80.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10.r,
                    spreadRadius: 2.r,
                    offset: Offset(0, 5.h),
                  ),
                ],
                gradient: LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: ClipOval(
                child: _imagePath != null
                    ? Image.file(
                        File(_imagePath!),
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
        horizontalSpace(10),
        Column(
          children: [
            Text(
              'mostafa naf3',
              style: Fonts.nunitoSans20BoldMainBlack,
            ),
            verticalSpace(10),
            Text(
              'moustfanaf3@gmail.com',
              style: Fonts.nunitoSans14RegularSecondaryGrey,
            )
          ],
        )
      ],
    );
  }
}