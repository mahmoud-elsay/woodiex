import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:woodiex/core/widgets/app_form_field.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_app_bar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  bool isObscureText = true;

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
                AppTextFormField(
                  hintText: 'Email',
                ),
                verticalSpace(18),
                AppTextFormField(
                  hintText: 'Password',
                  isObscureText: isObscureText,
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isObscureText = !isObscureText;
                      });
                    },
                    child: Icon(
                      isObscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                  ),
                ),
                verticalSpace(35),
                AppTextButton(
                    buttonText: 'login ',
                    textStyle: Fonts.nunitoSans18SemiBoldWhite,
                    onPressed: () {}),
                verticalSpace(35),
                GestureDetector(
                    onTap: () {
                      context.pushNamed(Routes.signUpScreen);
                    },
                    child: Center(
                      child: Text(
                        'SIGN UP ',
                        style: Fonts.nunitoSans18BoldMainBlack,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
