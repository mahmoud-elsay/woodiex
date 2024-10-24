import 'package:flutter/material.dart';
import 'package:woodiex/core/helpers/spacing.dart';
import 'package:woodiex/core/widgets/backble_top_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:woodiex/featrues/profile/ui/widgets/my_orders_screen_widgets/payment_method_widgets/payment_method_card.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool _isFirstChecked = false;
  bool _isSecondChecked = false;

  void _onFirstCheckboxChanged(bool? value) {
    setState(() {
      _isFirstChecked = value ?? false;
      if (_isFirstChecked) {
        _isSecondChecked = false; // Uncheck the second checkbox
      }
    });
  }

  void _onSecondCheckboxChanged(bool? value) {
    setState(() {
      _isSecondChecked = value ?? false;
      if (_isSecondChecked) {
        _isFirstChecked = false; // Uncheck the first checkbox
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            children: [
              BackableTopBar(screenTitle: 'Payment Methods'),
              verticalSpace(15),
              PaymentMethodCard(
                isChecked: _isFirstChecked,
                onCheckboxChanged: _onFirstCheckboxChanged,
              ),
              verticalSpace(10),
              PaymentMethodCard(
                isChecked: _isSecondChecked,
                onCheckboxChanged: _onSecondCheckboxChanged,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
