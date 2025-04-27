import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/app_regex.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/widgets/app_form_field.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/auth/sign_up/logic/sign_up_notifier.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscureText = true;

  @override
  void initState() {
    super.initState();
    // Add listeners to debug controller changes
    _fullNameController
        .addListener(() => print('FullName: ${_fullNameController.text}'));
    _userNameController
        .addListener(() => print('UserName: ${_userNameController.text}'));
    _emailController
        .addListener(() => print('Email: ${_emailController.text}'));
    _passwordController
        .addListener(() => print('Password: ${_passwordController.text}'));
    _confirmPasswordController.addListener(
        () => print('ConfirmPassword: ${_confirmPasswordController.text}'));
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Submitting form with values:');
      print('FullName: ${_fullNameController.text}');
      print('UserName: ${_userNameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('ConfirmPassword: ${_confirmPasswordController.text}');

      ref.read(signUpNotifierProvider.notifier).signUp(
            fullName: _fullNameController.text.trim(),
            userName: _userNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            confirmPassword: _confirmPasswordController.text,
          );
    } else {
      print('Form validation failed');
    }
  }

  bool _isFormFilled() {
    return _fullNameController.text.trim().isNotEmpty &&
        _userNameController.text.trim().isNotEmpty &&
        _emailController.text.trim().isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(signUpNotifierProvider, (previous, next) {
      next.when(
        initial: () {},
        loading: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Signing up...')),
          );
        },
        success: (data) {
          _fullNameController.clear();
          _userNameController.clear();
          _emailController.clear();
          _passwordController.clear();
          _confirmPasswordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Sign up successful!')),
          );
          // Navigate to next screen if needed
        },
        error: (error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${error.message}')),
          );
        },
      );
    });

    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Full Name',
            controller: _fullNameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your full name';
              }
              if (value.trim().length < 2) {
                return 'Full name must be at least 2 characters';
              }
              return null;
            },
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Username',
            controller: _userNameController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your username';
              }
              if (value.trim().length < 3) {
                return 'Username must be at least 3 characters';
              }
              return null;
            },
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Email',
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email';
              }
              if (!AppRegex.isEmailValid(value.trim())) {
                return 'Please enter a valid email';
              }
              return null;
            },
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
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value.length < 4) {
                return 'Password must be at least 4 characters';
              }
              return null;
            },
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Confirm password',
            controller: _confirmPasswordController,
            isObscureText: _isObscureText,
            suffixIcon: GestureDetector(
              onTap: _togglePasswordVisibility,
              child: Icon(
                _isObscureText ? Icons.visibility_off : Icons.visibility,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != _passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          verticalSpace(25),
          AppTextButton(
            buttonText: 'Sign Up',
            textStyle: Fonts.nunitoSans18SemiBoldWhite,
            onPressed: () {
              print('Sign Up button pressed');
              if (_isFormFilled()) {
                print('Form is filled, submitting...');
                _submitForm();
              } else {
                print('Form is not filled');
              }
            },
          ),
        ],
      ),
    );
  }
}
