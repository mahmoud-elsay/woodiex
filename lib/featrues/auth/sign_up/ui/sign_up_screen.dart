import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_app_bar.dart';
import 'package:woodiex/featrues/auth/sign_up/logic/sign_up_notifier.dart';
import 'package:woodiex/featrues/auth/sign_up/ui/widgets/sign_up_form.dart';
import 'package:woodiex/featrues/auth/sign_up/ui/widgets/already_have_account_text.dart';


class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(signUpNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: state.when(
          initial: () => Padding(
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
          loading: () => const Center(child: CircularProgressIndicator()),
          success: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.appLayout,
                (route) => false,
              );
            });
            return const SizedBox.shrink();
          },
          error: (error) => Padding(
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
                  verticalSpace(20),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'Sign-up failed. Please correct the following errors:',
                          style: Fonts.nunitoSans16RegularRed,
                          textAlign: TextAlign.center,
                        ),
                        verticalSpace(10),
                        Text(
                          error.getAllErrorMessages(),
                          style: Fonts.nunitoSans16RegularRed,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(30),
                  const SignUpForm(),
                  verticalSpace(30),
                  const Center(child: AlreadyHaveAccountText()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}