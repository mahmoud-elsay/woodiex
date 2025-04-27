import 'package:flutter/material.dart';
import 'package:woodiex/core/theming/styles.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:woodiex/core/helpers/app_validtion.dart';
import 'package:woodiex/core/widgets/app_form_field.dart';
import 'package:woodiex/core/widgets/app_text_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/core/widgets/loading_circle_indicator.dart';
import 'package:woodiex/featrues/auth/sign_up/logic/sign_up_state.dart';
import 'package:woodiex/featrues/auth/sign_up/logic/sign_up_notifier.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key});

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _controllers = {
    'fullName': TextEditingController(),
    'userName': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'confirmPassword': TextEditingController(),
  };
  final _errors = <String, String?>{};
  bool _isObscureText = true;
  String? _formError;

  @override
  void initState() {
    super.initState();
    _controllers.forEach((key, controller) {
      controller.addListener(() => _validateField(key));
    });
  }

  @override
  void dispose() {
    _controllers.values.forEach((controller) => controller.dispose());
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() => _isObscureText = !_isObscureText);
  }

  void _validateField(String key) {
    setState(() {
      switch (key) {
        case 'fullName':
          _errors[key] = validateName(_controllers[key]!.text);
          break;
        case 'userName':
          _errors[key] = _validateUsername(_controllers[key]!.text);
          break;
        case 'email':
          _errors[key] = validateEmail(_controllers[key]!.text);
          break;
        case 'password':
          _errors[key] = validatePassword(_controllers[key]!.text);
          _errors['confirmPassword'] = validateConfirmPassword(
              _controllers['confirmPassword']!.text, _controllers[key]!.text);
          break;
        case 'confirmPassword':
          _errors[key] = validateConfirmPassword(
              _controllers[key]!.text, _controllers['password']!.text);
          break;
      }
    });
  }

  String? _validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) return 'Username is required';
    if (value.trim().length < 3)
      return 'Username must be at least 3 characters';
    return null;
  }

  void _submitForm() {
    setState(() {
      _formError = null;
      _controllers.keys.forEach(_validateField);
    });
    if (_formKey.currentState!.validate()) {
      ref.read(signUpNotifierProvider.notifier).signUp(
            fullName: _controllers['fullName']!.text.trim(),
            userName: _controllers['userName']!.text.trim(),
            email: _controllers['email']!.text.trim(),
            password: _controllers['password']!.text,
            confirmPassword: _controllers['confirmPassword']!.text,
          );
    }
  }

  bool _isFormFilled() => _controllers.values
      .every((controller) => controller.text.trim().isNotEmpty);

  Widget _buildTextField({
    required String key,
    required String hintText,
    TextInputType? keyboardType,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextFormField(
          hintText: hintText,
          controller: _controllers[key],
          keyboardType: keyboardType,
          isObscureText: key.contains('password') ? _isObscureText : null,
          suffixIcon: key.contains('password')
              ? GestureDetector(
                  onTap: _togglePasswordVisibility,
                  child: Icon(
                    _isObscureText ? Icons.visibility_off : Icons.visibility,
                  ),
                )
              : null,
          validator: validator,
        ),
        if (_errors[key] != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 10.w),
            child: Text(
              _errors[key]!,
              style: Fonts.nunitoSans14RegularRed,
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final signUpState = ref.watch(signUpNotifierProvider);

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (signUpState is SignUpLoading) const LoadingCircleIndicator(),
          if (_formError != null)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                _formError!,
                style: Fonts.nunitoSans16RegularRed,
              ),
            ),
          _buildTextField(
            key: 'fullName',
            hintText: 'Full Name',
            validator: validateName,
          ),
          verticalSpace(18),
          _buildTextField(
            key: 'userName',
            hintText: 'Username',
            validator: _validateUsername,
          ),
          verticalSpace(18),
          _buildTextField(
            key: 'email',
            hintText: 'Email',
            keyboardType: TextInputType.emailAddress,
            validator: validateEmail,
          ),
          verticalSpace(18),
          _buildTextField(
            key: 'password',
            hintText: 'Password',
            validator: validatePassword,
          ),
          verticalSpace(18),
          _buildTextField(
            key: 'confirmPassword',
            hintText: 'Confirm password',
            validator: (value) =>
                validateConfirmPassword(value, _controllers['password']!.text),
          ),
          verticalSpace(25),
          AppTextButton(
            buttonText: 'Sign Up',
            textStyle: Fonts.nunitoSans18SemiBoldWhite,
            onPressed: () {
              if (_isFormFilled()) {
                _submitForm();
              } else {
                setState(() => _formError = 'Please fill all fields');
              }
            },
          ),
          signUpState.when(
            initial: () => const SizedBox.shrink(),
            loading: () => const SizedBox.shrink(),
            success: (data) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _controllers.values.forEach((controller) => controller.clear());
                setState(() => _formError = 'Sign up successful!');
              });
              return const SizedBox.shrink();
            },
            error: (error) => Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Text(
                'Sign up failed: ${error.message}',
                style: Fonts.nunitoSans16RegularRed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
