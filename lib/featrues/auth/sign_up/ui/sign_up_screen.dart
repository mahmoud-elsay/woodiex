import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_app_bar.dart';
import 'package:woodiex/featrues/auth/sign_up/ui/widgets/sign_up_form.dart';
import 'package:woodiex/featrues/auth/sign_up/ui/widgets/already_have_account_text.dart';


class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
                Text(
                  'Welcome',
                  style: Fonts.merriweather24BoldDarkGrey,
                ),
                verticalSpace(50),
                const SignUpForm(),
                verticalSpace(30),
                const Center(child: AlreadyHaveAccountText()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}