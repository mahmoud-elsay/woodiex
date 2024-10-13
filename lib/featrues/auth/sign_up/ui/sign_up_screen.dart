import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/app_form_field.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_app_bar.dart';
import 'package:woodiex/featrues/auth/sign_up/ui/widgets/already_have_account_text.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
              LoginAppBar(),
              verticalSpace(45),
              Text(
                'Welcome',
                style: Fonts.merriweather24bold,
              ),
              verticalSpace(50),
              AppTextFormField(
                hintText: 'Name',
              ),
              verticalSpace(18),
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
              verticalSpace(18),
              AppTextFormField(
                hintText: 'Confirm password',
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
              verticalSpace(25),
              AppTextButton(
                  buttonText: 'sign up  ',
                  textStyle: Fonts.whiteNunitoSansSemiBold18,
                  onPressed: () {}),
              verticalSpace(30),
              Center(child: AlreadyHaveAccountText())
            ],
          ),
        ),
      )),
    );
  }
}
