import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_form.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_app_bar.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const LoginAppBar(),
                verticalSpace(45),
                Text('Hello !', style: Fonts.merriweather30RegularMoreDarkGrey),
                verticalSpace(10),
                Text('Welcome Back', style: Fonts.merriweather24BoldDarkGrey),
                verticalSpace(80),
                const LoginForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
