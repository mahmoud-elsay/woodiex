import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/widgets/loading_circle_indicator.dart';
import 'package:woodiex/featrues/auth/login/logic/login_notifier.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_form.dart';
import 'package:woodiex/featrues/auth/login/ui/widgets/login_app_bar.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginState = ref.watch(loginNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: loginState.when(
          initial: () => Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const LoginAppBar(),
                  verticalSpace(45),
                  Text('Hello !',
                      style: Fonts.merriweather30RegularMoreDarkGrey),
                  verticalSpace(10),
                  Text('Welcome Back', style: Fonts.merriweather24BoldDarkGrey),
                  verticalSpace(80),
                  const LoginForm(),
                ],
              ),
            ),
          ),
          loading: () => const Center(child: LoadingCircleIndicator()),
          success: (data) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.pushNamedAndRemoveUntil(
                Routes.appLayout,
                predicate: (_) => false,
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
                  Text('Hello !',
                      style: Fonts.merriweather30RegularMoreDarkGrey),
                  verticalSpace(10),
                  Text('Welcome Back', style: Fonts.merriweather24BoldDarkGrey),
                  verticalSpace(20),
                  Center(
                    child: Text(
                      'Login failed: ${error.getAllErrorMessages()}',
                      style: Fonts.nunitoSans16RegularRed,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  verticalSpace(60),
                  const LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
