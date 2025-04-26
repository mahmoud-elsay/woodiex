import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/helpers/app_regex.dart';
import 'package:woodiex/core/widgets/app_form_field.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isObscureText = true;

  @override
  void dispose() {
    _nameController.dispose();
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
      // TODO: Handle sign-up submission
      print(
          'Form valid: Name: ${_nameController.text}, Email: ${_emailController.text}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextFormField(
            hintText: 'Name',
            controller: _nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          verticalSpace(18),
          AppTextFormField(
            hintText: 'Email',
            controller: _emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!AppRegex.isEmailValid(value)) {
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
              if (!AppRegex.isPasswordValid(value)) {
                if (!AppRegex.hasMinLength(value)) {
                  return 'Password must be at least 8 characters';
                }
                if (!AppRegex.hasLowerCase(value)) {
                  return 'Password must contain a lowercase letter';
                }
                if (!AppRegex.hasUpperCase(value)) {
                  return 'Password must contain an uppercase letter';
                }
                if (!AppRegex.hasNumber(value)) {
                  return 'Password must contain a number';
                }
                if (!AppRegex.hasSpecialCharacter(value)) {
                  return 'Password must contain a special character';
                }
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
            onPressed: _submitForm,
          ),
        ],
      ),
    );
  }
}
