import 'package:flutter/material.dart';
import 'package:woodiex/core/routing/routes.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/helpers/app_validtion.dart';
import 'package:woodiex/core/widgets/app_form_field.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/widgets/loading_circle_indicator.dart';
import 'package:woodiex/featrues/auth/login/logic/login_state.dart';
import 'package:woodiex/featrues/auth/login/logic/login_notifier.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isObscureText = true;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() {
      setState(() => _emailError = validateEmail(_emailController.text));
    });
    _passwordController.addListener(() {
      setState(
          () => _passwordError = validatePassword(_passwordController.text));
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _isObscureText = !_isObscureText);
  }

  void _submitForm() {
    setState(() {
      _emailError = validateEmail(_emailController.text);
      _passwordError = validatePassword(_passwordController.text);
    });
    if (_formKey.currentState!.validate()) {
      ref.read(loginNotifierProvider.notifier).login(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          );
    }
  }

  bool _isFormFilled() =>
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.trim().isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final loginState = ref.watch(loginNotifierProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (loginState is LoginLoading) const LoadingCircleIndicator(),
          AppTextFormField(
            hintText: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          if (_emailError != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 10.w),
              child: Text(
                _emailError!,
                style: Fonts.nunitoSans14RegularRed,
              ),
            ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Password',
            controller: _passwordController,
            isObscureText: _isObscureText,
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                _isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: validatePassword,
          ),
          if (_passwordError != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h, left: 10.w),
              child: Text(
                _passwordError!,
                style: Fonts.nunitoSans14RegularRed,
              ),
            ),
          verticalSpace(35),
          AppTextButton(
            buttonText: 'Login',
            textStyle: Fonts.nunitoSans18SemiBoldWhite,
            onPressed: () {
              if (_isFormFilled()) {
                _submitForm();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Please fill all fields')),
                );
              }
            },
          ),
          verticalSpace(35),
          GestureDetector(
            onTap: () => context.pushNamed(Routes.signUpScreen),
            child: Center(
              child: Text(
                'SIGN UP',
                style: Fonts.nunitoSans18BoldMainBlack,
              ),
            ),
          ),
          loginState.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            success: (data) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _emailController.clear();
                _passwordController.clear();
              });
              return const SizedBox.shrink();
            },
            error: (_) => const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
