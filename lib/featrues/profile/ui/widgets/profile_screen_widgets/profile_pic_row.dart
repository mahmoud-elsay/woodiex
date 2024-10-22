import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePicRow extends StatelessWidget {
  const ProfilePicRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
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
                  offset:
                      Offset(0, 5.h), // Slight shadow below the profile picture
                ),
              ],
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.purpleAccent
                ], // Optional gradient for a cool effect
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/profile_pic.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        horizontalSpace(10),
        Column(
          children: [
            Text(
              ' mostafa naf3',
              style: Fonts.darkNnitoSansBold20,
            ),
            verticalSpace(10),
            Text(
              'moustfanaf3@gmail.com',
              style: Fonts.nunitoSansRegular14,
            )
          ],
        )
      ],
    );
  }
}
